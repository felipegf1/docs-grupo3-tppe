-- =============================================================================
-- Quero. — App "negociacao" (Epico 5 · QRO-10 a QRO-16)
-- Palpites, contrapropostas, conversa, aceite e conclusao.
-- =============================================================================

-- --- Palpite (QRO-10) ---------------------------------------------------------

CREATE TABLE palpite (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  anuncio_id  uuid NOT NULL REFERENCES anuncio(id) ON DELETE CASCADE,
  vendedor_id uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  valor       dinheiro NOT NULL CHECK (valor > 0),
  criado_em   timestamptz NOT NULL DEFAULT now(),
  atualizado_em timestamptz NOT NULL DEFAULT now(),
  -- QRO-10: cada vendedor tem no maximo um palpite por anuncio; palpitar de
  -- novo substitui o valor anterior.
  UNIQUE (anuncio_id, vendedor_id)
);

COMMENT ON TABLE palpite IS
  'Estimativa sem compromisso, que nao cria oferta (QRO-10). Anonima para o '
  'comprador: ele ve a faixa, nunca quem palpitou (RNF-05).';

CREATE TRIGGER palpite_atualizado_em
  BEFORE UPDATE ON palpite
  FOR EACH ROW EXECUTE FUNCTION tocar_atualizado_em();

CREATE FUNCTION palpite_validar() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  -- QRO-10: o comprador nao palpita no proprio anuncio.
  IF EXISTS (
    SELECT 1 FROM anuncio
     WHERE id = NEW.anuncio_id AND comprador_id = NEW.vendedor_id
  ) THEN
    RAISE EXCEPTION 'O autor do anuncio nao pode palpitar nele mesmo (QRO-10)';
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER palpite_validar
  BEFORE INSERT OR UPDATE ON palpite
  FOR EACH ROW EXECUTE FUNCTION palpite_validar();

-- RNF-05: a faixa so e exibida a partir de tres palpites, e sem identificar
-- ninguem. A view existe para que essa regra nao dependa da aplicacao lembrar.
CREATE VIEW vw_palpite_faixa AS
SELECT anuncio_id,
       count(*)                          AS total_palpites,
       min(valor)                        AS valor_minimo,
       round(avg(valor), 2)::dinheiro    AS valor_medio,
       max(valor)                        AS valor_maximo
  FROM palpite
 GROUP BY anuncio_id
HAVING count(*) >= 3;

COMMENT ON VIEW vw_palpite_faixa IS
  'Faixa estimada pelo mercado (RF-22). O HAVING >= 3 e o RNF-05 em forma de SQL.';

-- --- Negociacao (QRO-15, QRO-16) ----------------------------------------------

CREATE TABLE negociacao (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- Glossario: o vinculo entre um anuncio e a oferta aceita.
  anuncio_id    uuid NOT NULL UNIQUE REFERENCES anuncio(id) ON DELETE CASCADE,
  oferta_id     uuid NOT NULL UNIQUE,
  comprador_id  uuid NOT NULL REFERENCES usuario(id) ON DELETE RESTRICT,
  vendedor_id   uuid NOT NULL REFERENCES usuario(id) ON DELETE RESTRICT,
  produto_id    uuid REFERENCES produto(id) ON DELETE SET NULL,

  -- RF-32: o valor acordado no aceite passa a ser a referencia da venda.
  valor_final   dinheiro NOT NULL,
  status        status_negociacao NOT NULL DEFAULT 'em_andamento',

  iniciada_em   timestamptz NOT NULL DEFAULT now(),
  -- RF-35: conclusao exige confirmacao das duas partes, ou vence o prazo.
  confirmada_comprador_em timestamptz,
  confirmada_vendedor_em  timestamptz,
  prazo_confirmacao       timestamptz,
  concluida_em  timestamptz,
  cancelada_em  timestamptz,

  -- Garante que a oferta aceita pertence ao anuncio desta negociacao.
  FOREIGN KEY (oferta_id, anuncio_id) REFERENCES oferta (id, anuncio_id) ON DELETE CASCADE,
  CONSTRAINT negociacao_partes_distintas CHECK (comprador_id <> vendedor_id),
  CONSTRAINT negociacao_concluida_tem_data
    CHECK ((status = 'concluida') = (concluida_em IS NOT NULL)),
  CONSTRAINT negociacao_cancelada_tem_data
    CHECK ((status = 'cancelada') = (cancelada_em IS NOT NULL))
);

COMMENT ON TABLE negociacao IS
  'Do aceite da oferta ate a conclusao ou o cancelamento (QRO-15, QRO-16).';

CREATE INDEX negociacao_comprador_idx ON negociacao (comprador_id, status);
CREATE INDEX negociacao_vendedor_idx  ON negociacao (vendedor_id, status);

CREATE TRIGGER negociacao_auditoria
  AFTER INSERT OR UPDATE OF status ON negociacao
  FOR EACH ROW EXECUTE FUNCTION auditar_status('negociacao');

-- RNF-14: uma negociacao concluida nao pode ser reaberta por NENHUMA operacao.
CREATE FUNCTION negociacao_impedir_reabertura() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF OLD.status = 'concluida' AND NEW.status <> 'concluida' THEN
    RAISE EXCEPTION 'Negociacao concluida nao pode ser reaberta (RNF-14)';
  END IF;
  IF OLD.status = 'cancelada' AND NEW.status <> 'cancelada' THEN
    RAISE EXCEPTION 'Negociacao cancelada nao pode ser retomada (QRO-15)';
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER negociacao_sem_reabertura
  BEFORE UPDATE ON negociacao
  FOR EACH ROW EXECUTE FUNCTION negociacao_impedir_reabertura();

-- --- Contraproposta (QRO-12, QRO-13) ------------------------------------------

CREATE TABLE contraproposta (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  oferta_id      uuid NOT NULL REFERENCES oferta(id) ON DELETE CASCADE,
  autor          papel NOT NULL,
  valor          dinheiro NOT NULL CHECK (valor > 0),
  justificativa  text,
  -- O total de rodadas e compartilhado entre as duas partes (glossario) e o
  -- limite vem de LIMITE_RODADAS_NEGOCIACAO (RNF-23), nao do banco.
  rodada         smallint NOT NULL CHECK (rodada >= 1),
  status         status_contraproposta NOT NULL DEFAULT 'em_aberto',
  -- RF-26: expira se nao respondida no prazo (PRAZO_CONTRAPROPOSTA_HORAS).
  expira_em      timestamptz NOT NULL,
  respondida_em  timestamptz,
  criado_em      timestamptz NOT NULL DEFAULT now(),

  UNIQUE (oferta_id, rodada),
  CONSTRAINT contraproposta_prazo_futuro CHECK (expira_em > criado_em),
  CONSTRAINT contraproposta_aberta_sem_resposta
    CHECK ((status = 'em_aberto') = (respondida_em IS NULL))
);

-- RF-25: existe apenas UMA contraproposta em aberto por oferta.
CREATE UNIQUE INDEX contraproposta_uma_aberta_idx
  ON contraproposta (oferta_id)
  WHERE status = 'em_aberto';

CREATE INDEX contraproposta_expiracao_idx
  ON contraproposta (expira_em)
  WHERE status = 'em_aberto';

COMMENT ON TABLE contraproposta IS
  'Novo valor proposto por uma das partes sobre uma oferta existente (QRO-12). '
  'Cada par contraproposta + resposta e uma "rodada".';

CREATE FUNCTION contraproposta_validar() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  oferta_atual  oferta%ROWTYPE;
  anuncio_atual anuncio%ROWTYPE;
BEGIN
  SELECT * INTO oferta_atual  FROM oferta  WHERE id = NEW.oferta_id;
  SELECT * INTO anuncio_atual FROM anuncio WHERE id = oferta_atual.anuncio_id;

  -- QRO-12: a contraproposta exige oferta ativa em anuncio ativo.
  IF oferta_atual.status NOT IN ('enviada', 'em_negociacao') THEN
    RAISE EXCEPTION 'Oferta "%" nao aceita contraproposta (QRO-12)', oferta_atual.status;
  END IF;

  IF anuncio_atual.status NOT IN ('ativo', 'em_negociacao') THEN
    RAISE EXCEPTION 'Anuncio "%" nao aceita contraproposta (QRO-12)', anuncio_atual.status;
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER contraproposta_validar
  BEFORE INSERT ON contraproposta
  FOR EACH ROW EXECUTE FUNCTION contraproposta_validar();

-- --- Conversa e mensagens (QRO-14) --------------------------------------------

-- A conversa existe apenas entre o comprador e o vendedor de UMA oferta, por
-- isso a chave primaria e a propria oferta.
CREATE TABLE conversa (
  oferta_id     uuid PRIMARY KEY REFERENCES oferta(id) ON DELETE CASCADE,
  -- RF-30: somente leitura apos o encerramento do anuncio ou a conclusao.
  somente_leitura boolean NOT NULL DEFAULT false,
  criado_em     timestamptz NOT NULL DEFAULT now()
);

COMMENT ON TABLE conversa IS
  'Conversa de negociacao (nunca "chat de suporte"). Liberada so depois que uma '
  'oferta e enviada ao anuncio (QRO-14).';

CREATE TABLE mensagem (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  oferta_id  uuid NOT NULL REFERENCES conversa(oferta_id) ON DELETE CASCADE,
  autor_id   uuid NOT NULL REFERENCES usuario(id) ON DELETE RESTRICT,
  corpo      text NOT NULL CHECK (length(btrim(corpo)) BETWEEN 1 AND 2000),
  lida_em    timestamptz,
  criado_em  timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX mensagem_conversa_idx ON mensagem (oferta_id, criado_em);

-- RNF-12: mensagens nao podem ser editadas nem apagadas. So "lida_em" muda.
CREATE TRIGGER mensagem_imutavel
  BEFORE UPDATE OR DELETE ON mensagem
  FOR EACH ROW EXECUTE FUNCTION impedir_alteracao('lida_em');

CREATE FUNCTION mensagem_validar() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  conversa_atual conversa%ROWTYPE;
  oferta_atual   oferta%ROWTYPE;
  dono_anuncio   uuid;
BEGIN
  SELECT * INTO conversa_atual FROM conversa WHERE oferta_id = NEW.oferta_id;
  SELECT * INTO oferta_atual   FROM oferta   WHERE id = NEW.oferta_id;
  SELECT comprador_id INTO dono_anuncio FROM anuncio WHERE id = oferta_atual.anuncio_id;

  IF conversa_atual.somente_leitura THEN
    RAISE EXCEPTION 'Conversa encerrada: somente leitura (RF-30)';
  END IF;

  -- RNF-07: so as duas partes da negociacao escrevem nesta conversa.
  IF NEW.autor_id NOT IN (dono_anuncio, oferta_atual.vendedor_id) THEN
    RAISE EXCEPTION 'Autor % nao participa desta negociacao (RNF-07)', NEW.autor_id;
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER mensagem_validar
  BEFORE INSERT ON mensagem
  FOR EACH ROW EXECUTE FUNCTION mensagem_validar();

-- --- Denuncia e bloqueio (RF-31) ----------------------------------------------

CREATE TABLE denuncia (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  denunciante_id uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  oferta_id      uuid REFERENCES conversa(oferta_id) ON DELETE CASCADE,
  mensagem_id    uuid REFERENCES mensagem(id) ON DELETE SET NULL,
  motivo         text NOT NULL,
  analisada_em   timestamptz,
  criado_em      timestamptz NOT NULL DEFAULT now(),
  CHECK (oferta_id IS NOT NULL OR mensagem_id IS NOT NULL)
);

CREATE TABLE bloqueio (
  bloqueador_id uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  bloqueado_id  uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  criado_em     timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (bloqueador_id, bloqueado_id),
  CHECK (bloqueador_id <> bloqueado_id)
);
