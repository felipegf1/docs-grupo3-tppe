-- =============================================================================
-- Quero. — App "anuncios" (Epico 2 · QRO-04, QRO-05)
-- O anuncio de "procura-se": a demanda do comprador, com raio proprio.
-- =============================================================================

CREATE TABLE anuncio (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  comprador_id uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  categoria_id smallint NOT NULL REFERENCES categoria(id),

  -- RF-08: titulo, categoria e descricao sao obrigatorios para publicar.
  titulo       text NOT NULL CHECK (length(btrim(titulo)) >= 3),
  descricao    text NOT NULL CHECK (length(btrim(descricao)) >= 10),
  preco_min    dinheiro,
  preco_max    dinheiro,

  -- RF-09: o raio pertence ao anuncio, nao a quem busca. Guardado em metros e
  -- convertido para KM so na exibicao (RNF-18). Teto = RAIO_MAXIMO_KM.
  raio_m       integer NOT NULL DEFAULT 20000 CHECK (raio_m BETWEEN 1000 AND 200000),
  ponto        geography(Point, 4326) NOT NULL,
  -- Buffer pre-calculado do raio: transforma a consulta por distancia variavel
  -- em contencao indexavel por GiST (RNF-09). Mantido pelo gatilho abaixo.
  alcance      geography(Polygon, 4326),

  -- Pre-filtro barato antes do calculo espacial (RNF-09) e base do "Perto de voce".
  cidade       text NOT NULL,
  uf           sigla_uf NOT NULL,

  status       status_anuncio NOT NULL DEFAULT 'ativo',
  expira_em    timestamptz,
  encerrado_em timestamptz,
  criado_em    timestamptz NOT NULL DEFAULT now(),
  atualizado_em timestamptz NOT NULL DEFAULT now(),

  CONSTRAINT anuncio_faixa_coerente
    CHECK (preco_min IS NULL OR preco_max IS NULL OR preco_min <= preco_max),
  CONSTRAINT anuncio_encerrado_tem_data
    CHECK ((status = 'encerrado') = (encerrado_em IS NOT NULL))
);

COMMENT ON TABLE anuncio IS
  'Anuncio de "procura-se" (QRO-04). No feed aparece com o badge "Procurando".';
COMMENT ON COLUMN anuncio.alcance IS
  'Area de cobertura materializada = ST_Buffer(ponto, raio_m). Recalculada no '
  'banco para nunca ficar dessincronizada em uma edicao (risco de infraestrutura).';

-- Busca textual do feed (RF-15). to_tsvector com regconfig explicita e IMMUTABLE,
-- o que permite a coluna gerada.
ALTER TABLE anuncio ADD COLUMN busca tsvector
  GENERATED ALWAYS AS (
    setweight(to_tsvector('portuguese', coalesce(titulo, '')), 'A') ||
    setweight(to_tsvector('portuguese', coalesce(descricao, '')), 'B')
  ) STORED;

-- --- Indices ------------------------------------------------------------------

-- O indice que sustenta o feed do vendedor: "quais anuncios me alcancam?"
CREATE INDEX anuncio_alcance_idx   ON anuncio USING gist (alcance);
CREATE INDEX anuncio_ponto_idx     ON anuncio USING gist (ponto);
CREATE INDEX anuncio_busca_idx     ON anuncio USING gin  (busca);
CREATE INDEX anuncio_titulo_trgm_idx ON anuncio USING gin (titulo gin_trgm_ops);
-- A maioria das consultas ja filtra por anuncio ativo.
CREATE INDEX anuncio_status_categoria_idx ON anuncio (status, categoria_id);
CREATE INDEX anuncio_cidade_idx    ON anuncio (uf, cidade) WHERE status = 'ativo';
CREATE INDEX anuncio_comprador_idx ON anuncio (comprador_id, criado_em DESC);

-- --- Regras -------------------------------------------------------------------

CREATE FUNCTION anuncio_materializar_alcance() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF TG_OP = 'INSERT'
     OR NEW.ponto  IS DISTINCT FROM OLD.ponto
     OR NEW.raio_m IS DISTINCT FROM OLD.raio_m THEN
    NEW.alcance := ST_Buffer(NEW.ponto, NEW.raio_m)::geography(Polygon, 4326);
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER anuncio_alcance
  BEFORE INSERT OR UPDATE OF ponto, raio_m ON anuncio
  FOR EACH ROW EXECUTE FUNCTION anuncio_materializar_alcance();

-- Transicoes validas do glossario: ativo <-> pausado, ativo -> em_negociacao,
-- em_negociacao -> ativo (cancelamento, RF-34), qualquer um -> encerrado.
-- Encerrado e definitivo e nao pode ser reativado.
CREATE FUNCTION anuncio_validar_transicao() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF OLD.status = NEW.status THEN
    RETURN NEW;
  END IF;

  IF OLD.status = 'encerrado' THEN
    RAISE EXCEPTION 'Anuncio encerrado e definitivo e nao pode voltar para "%" (QRO-05)', NEW.status;
  END IF;

  IF NOT (OLD.status, NEW.status) IN (
        ('ativo', 'pausado'), ('ativo', 'em_negociacao'), ('ativo', 'encerrado'),
        ('pausado', 'ativo'), ('pausado', 'encerrado'),
        ('em_negociacao', 'ativo'), ('em_negociacao', 'encerrado')) THEN
    RAISE EXCEPTION 'Transicao de anuncio invalida: % -> % (QRO-05)', OLD.status, NEW.status;
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER anuncio_transicao
  BEFORE UPDATE OF status ON anuncio
  FOR EACH ROW EXECUTE FUNCTION anuncio_validar_transicao();

CREATE TRIGGER anuncio_auditoria
  AFTER INSERT OR UPDATE OF status ON anuncio
  FOR EACH ROW EXECUTE FUNCTION auditar_status('anuncio');

CREATE TRIGGER anuncio_atualizado_em
  BEFORE UPDATE ON anuncio
  FOR EACH ROW EXECUTE FUNCTION tocar_atualizado_em();

-- RF-02: localizacao e obrigatoria para publicar anuncio (QRO-01).
CREATE FUNCTION exigir_localizacao() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  -- Acesso dinamico: o plpgsql resolve NEW.<coluna> em tempo de compilacao, e a
  -- mesma funcao serve a anuncio (comprador_id) e a oferta (vendedor_id).
  usuario_alvo uuid := (to_jsonb(NEW) ->> TG_ARGV[0])::uuid;
BEGIN
  IF NOT EXISTS (SELECT 1 FROM localizacao WHERE usuario_id = usuario_alvo) THEN
    RAISE EXCEPTION
      'Usuario % precisa de localizacao de referencia antes de publicar ou ofertar (QRO-01)',
      usuario_alvo;
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER anuncio_exige_localizacao
  BEFORE INSERT ON anuncio
  FOR EACH ROW EXECUTE FUNCTION exigir_localizacao('comprador_id');
