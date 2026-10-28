-- =============================================================================
-- Quero. — App "ofertas" (Epico 3 · QRO-06, QRO-07)
-- A resposta formal do vendedor a um anuncio.
-- =============================================================================

CREATE TABLE oferta (
  id                 uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  anuncio_id         uuid NOT NULL REFERENCES anuncio(id) ON DELETE CASCADE,
  vendedor_id        uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  -- O vinculo com o catalogo e opcional: ofertar avulso funciona sem QRO-08.
  produto_id         uuid REFERENCES produto(id) ON DELETE SET NULL,

  -- RNF-15: os dados do produto sao CONGELADOS no envio. Editar ou remover o
  -- produto depois nao altera as ofertas ja enviadas (QRO-08).
  titulo             text NOT NULL CHECK (length(btrim(titulo)) >= 3),
  descricao          text NOT NULL CHECK (length(btrim(descricao)) >= 10),
  estado_conservacao estado_conservacao NOT NULL,
  preco              dinheiro NOT NULL,
  -- Valor de partida, para onde a oferta volta quando uma contraproposta
  -- expira sem resposta (RF-26).
  preco_inicial      dinheiro NOT NULL,

  status             status_oferta NOT NULL DEFAULT 'enviada',
  -- RF-33: motivo opcional, visivel apenas ao vendedor recusado.
  motivo_recusa      text,
  rodadas_usadas     smallint NOT NULL DEFAULT 0 CHECK (rodadas_usadas >= 0),

  criado_em          timestamptz NOT NULL DEFAULT now(),
  atualizado_em      timestamptz NOT NULL DEFAULT now(),

  -- Permite a chave composta em negociacao, garantindo que a oferta aceita
  -- pertence mesmo ao anuncio negociado.
  UNIQUE (id, anuncio_id),
  CONSTRAINT oferta_motivo_so_em_recusa
    CHECK (motivo_recusa IS NULL OR status = 'recusada')
);

COMMENT ON TABLE oferta IS
  'Oferta do vendedor (QRO-06). Os dados do produto sao copiados no envio (RNF-15).';

-- QRO-06: cada vendedor tem no maximo UMA oferta ativa por anuncio.
-- Recusadas e retiradas nao contam, para o vendedor poder concorrer de novo.
CREATE UNIQUE INDEX oferta_uma_ativa_por_vendedor_idx
  ON oferta (anuncio_id, vendedor_id)
  WHERE status IN ('enviada', 'em_negociacao', 'aceita');

-- RF-32: uma unica oferta aceita por anuncio.
CREATE UNIQUE INDEX oferta_uma_aceita_por_anuncio_idx
  ON oferta (anuncio_id)
  WHERE status = 'aceita';

CREATE INDEX oferta_anuncio_idx  ON oferta (anuncio_id, status, preco);
CREATE INDEX oferta_vendedor_idx ON oferta (vendedor_id, criado_em DESC);

CREATE TRIGGER oferta_atualizado_em
  BEFORE UPDATE ON oferta
  FOR EACH ROW EXECUTE FUNCTION tocar_atualizado_em();

CREATE TRIGGER oferta_auditoria
  AFTER INSERT OR UPDATE OF status ON oferta
  FOR EACH ROW EXECUTE FUNCTION auditar_status('oferta');

CREATE TRIGGER oferta_exige_localizacao
  BEFORE INSERT ON oferta
  FOR EACH ROW EXECUTE FUNCTION exigir_localizacao('vendedor_id');

-- --- Regras que atravessam tabelas --------------------------------------------

CREATE FUNCTION oferta_validar_envio() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  anuncio_atual anuncio%ROWTYPE;
BEGIN
  SELECT * INTO anuncio_atual FROM anuncio WHERE id = NEW.anuncio_id;

  -- QRO-06: uma oferta so pode ser enviada para um anuncio ativo.
  IF anuncio_atual.status <> 'ativo' THEN
    RAISE EXCEPTION
      'Anuncio % esta "%" e nao aceita novas ofertas (QRO-06)',
      anuncio_atual.id, anuncio_atual.status;
  END IF;

  -- O comprador nao oferta no proprio anuncio.
  IF anuncio_atual.comprador_id = NEW.vendedor_id THEN
    RAISE EXCEPTION 'O autor do anuncio nao pode ofertar nele mesmo (QRO-06)';
  END IF;

  -- QRO-08: produto reservado em outra negociacao nao pode ser ofertado.
  IF NEW.produto_id IS NOT NULL THEN
    IF NOT EXISTS (
      SELECT 1 FROM produto
       WHERE id = NEW.produto_id
         AND vendedor_id = NEW.vendedor_id
         AND status = 'disponivel'
    ) THEN
      RAISE EXCEPTION
        'Produto % nao esta disponivel no catalogo deste vendedor (QRO-08)', NEW.produto_id;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER oferta_validar
  BEFORE INSERT ON oferta
  FOR EACH ROW EXECUTE FUNCTION oferta_validar_envio();

-- RF-14: editar ou retirar so enquanto a oferta nao for aceita.
CREATE FUNCTION oferta_travar_apos_aceite() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF OLD.status IN ('recusada', 'retirada') AND NEW.status <> OLD.status THEN
    RAISE EXCEPTION 'Oferta "%" e definitiva para este anuncio (QRO-15)', OLD.status;
  END IF;

  IF OLD.status = 'aceita'
     AND (NEW.preco IS DISTINCT FROM OLD.preco
          OR NEW.descricao IS DISTINCT FROM OLD.descricao
          OR NEW.estado_conservacao IS DISTINCT FROM OLD.estado_conservacao) THEN
    RAISE EXCEPTION 'Oferta aceita nao pode mais ser editada (RF-14)';
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER oferta_travar
  BEFORE UPDATE ON oferta
  FOR EACH ROW EXECUTE FUNCTION oferta_travar_apos_aceite();

-- --- Buscas salvas (QRO-07 / RF-16) -------------------------------------------

CREATE TABLE busca_salva (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  vendedor_id uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  nome        text NOT NULL CHECK (length(btrim(nome)) >= 1),
  -- Conjunto de filtros: termo, categorias, faixa de preco, distancia, ordenacao.
  filtros     jsonb NOT NULL DEFAULT '{}'::jsonb,
  criado_em   timestamptz NOT NULL DEFAULT now(),
  UNIQUE (vendedor_id, nome)
);

COMMENT ON TABLE busca_salva IS
  'Conjunto de filtros nomeado que o vendedor reaplica depois (glossario).';
