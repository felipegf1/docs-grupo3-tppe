-- =============================================================================
-- Quero. — Trilha de auditoria
-- RNF-13: toda transicao de estado de anuncio, oferta e negociacao deve ser
-- registrada com data, autor e valor. Tabela criada cedo porque as demais a usam.
-- =============================================================================

CREATE TABLE transicao_estado (
  id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  entidade    text NOT NULL CHECK (entidade IN ('anuncio', 'oferta', 'negociacao', 'produto', 'contraproposta')),
  entidade_id uuid NOT NULL,
  estado_de   text,
  estado_para text NOT NULL,
  autor_id    uuid,          -- sem FK: a trilha sobrevive a exclusao da conta
  valor       dinheiro,
  criado_em   timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX transicao_estado_entidade_idx
  ON transicao_estado (entidade, entidade_id, criado_em DESC);

COMMENT ON TABLE transicao_estado IS
  'Historico append-only de mudancas de estado (RNF-13). Nunca sofre UPDATE.';

CREATE FUNCTION registrar_transicao(
  p_entidade    text,
  p_entidade_id uuid,
  p_de          text,
  p_para        text,
  p_autor_id    uuid DEFAULT NULL,
  p_valor       dinheiro DEFAULT NULL
) RETURNS void
LANGUAGE sql AS $$
  INSERT INTO transicao_estado (entidade, entidade_id, estado_de, estado_para, autor_id, valor)
  VALUES (p_entidade, p_entidade_id, p_de, p_para, p_autor_id, p_valor);
$$;

-- Gatilho generico: qualquer tabela com coluna "status" pode registrar sua
-- propria transicao. TG_ARGV[0] e o nome da entidade na trilha.
CREATE FUNCTION auditar_status() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  antes  text := CASE WHEN TG_OP = 'INSERT' THEN NULL ELSE (to_jsonb(OLD) ->> 'status') END;
  depois text := to_jsonb(NEW) ->> 'status';
BEGIN
  IF antes IS DISTINCT FROM depois THEN
    PERFORM registrar_transicao(TG_ARGV[0], NEW.id, antes, depois);
  END IF;
  RETURN NULL;
END;
$$;
