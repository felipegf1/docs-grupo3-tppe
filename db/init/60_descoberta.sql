-- =============================================================================
-- Quero. — App "descoberta" (Epico 4 · QRO-09)
-- Recomendacoes pre-calculadas. Recomendacao NAO e oferta.
-- =============================================================================

CREATE TABLE recomendacao (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  anuncio_id   uuid NOT NULL REFERENCES anuncio(id) ON DELETE CASCADE,
  produto_id   uuid NOT NULL REFERENCES produto(id) ON DELETE CASCADE,

  -- Compatibilidade calculada por regras: categoria, palavras-chave, faixa de
  -- preco e distancia (QRO-09). Sem aprendizado de maquina no MVP.
  score        numeric(5, 4) NOT NULL CHECK (score BETWEEN 0 AND 1),
  criterios    jsonb NOT NULL DEFAULT '{}'::jsonb,
  distancia_m  integer CHECK (distancia_m >= 0),

  -- RF-20: convidar a ofertar nao cria oferta.
  convidado_em timestamptz,
  -- RF-21: o descarte alimenta o ajuste das proximas.
  descartada_em timestamptz,
  criado_em    timestamptz NOT NULL DEFAULT now(),

  UNIQUE (anuncio_id, produto_id)
);

COMMENT ON TABLE recomendacao IS
  'Sugestao de produto compativel com um anuncio ativo (QRO-09). Pre-calculada '
  'de forma assincrona para nao bloquear o feed (RNF-11).';

CREATE INDEX recomendacao_anuncio_idx
  ON recomendacao (anuncio_id, score DESC)
  WHERE descartada_em IS NULL;

-- QRO-09: produtos ja ofertados no anuncio nao aparecem como recomendacao.
CREATE FUNCTION recomendacao_validar() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM oferta
     WHERE anuncio_id = NEW.anuncio_id
       AND produto_id = NEW.produto_id
       AND status IN ('enviada', 'em_negociacao', 'aceita')
  ) THEN
    RAISE EXCEPTION 'Produto % ja foi ofertado neste anuncio (QRO-09)', NEW.produto_id;
  END IF;

  -- So entram produtos disponiveis de vendedores ativos.
  IF NOT EXISTS (
    SELECT 1 FROM produto p
      JOIN usuario u ON u.id = p.vendedor_id
     WHERE p.id = NEW.produto_id AND p.status = 'disponivel' AND u.ativo
  ) THEN
    RAISE EXCEPTION 'Produto % nao esta disponivel para recomendacao (QRO-09)', NEW.produto_id;
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER recomendacao_validar
  BEFORE INSERT ON recomendacao
  FOR EACH ROW EXECUTE FUNCTION recomendacao_validar();
