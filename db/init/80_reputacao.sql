-- =============================================================================
-- Quero. — App "reputacao" (Epico 6 · QRO-18, QRO-19)
-- Avaliacoes com publicacao simultanea e nota agregada.
-- =============================================================================

CREATE TABLE avaliacao (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  negociacao_id uuid NOT NULL REFERENCES negociacao(id) ON DELETE CASCADE,
  autor_id      uuid NOT NULL REFERENCES usuario(id) ON DELETE RESTRICT,
  avaliado_id   uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  papel_autor   papel NOT NULL,

  nota          nota NOT NULL,
  comentario    text CHECK (comentario IS NULL OR length(btrim(comentario)) <= 1000),

  -- RNF-06: fica oculta ate a publicacao simultanea, impedindo retaliacao.
  publicada_em  timestamptz,
  criado_em     timestamptz NOT NULL DEFAULT now(),

  -- QRO-18: uma vez por negociacao e por parte.
  UNIQUE (negociacao_id, autor_id),
  UNIQUE (negociacao_id, papel_autor),
  CONSTRAINT avaliacao_nao_autoavaliacao CHECK (autor_id <> avaliado_id)
);

COMMENT ON TABLE avaliacao IS
  'Avaliacao da contraparte apos a conclusao (QRO-18). Sempre sobre a PESSOA, '
  'nunca sobre o produto — para o produto existe o estado de conservacao.';

CREATE INDEX avaliacao_avaliado_idx
  ON avaliacao (avaliado_id)
  WHERE publicada_em IS NOT NULL;

-- RNF-12 / QRO-18: avaliacoes nao podem ser editadas nem apagadas pelo autor.
-- Apenas "publicada_em" muda, e quem muda e a rotina de publicacao simultanea.
CREATE TRIGGER avaliacao_imutavel
  BEFORE UPDATE OR DELETE ON avaliacao
  FOR EACH ROW EXECUTE FUNCTION impedir_alteracao('publicada_em');

-- QRO-18: so e possivel avaliar apos negociacao concluida.
CREATE FUNCTION avaliacao_validar() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  n negociacao%ROWTYPE;
BEGIN
  SELECT * INTO n FROM negociacao WHERE id = NEW.negociacao_id;

  IF n.status <> 'concluida' THEN
    RAISE EXCEPTION
      'Negociacao % esta "%": so se avalia apos a conclusao (QRO-18)', n.id, n.status;
  END IF;

  -- O autor e o avaliado sao exatamente as duas partes desta negociacao.
  IF NOT (NEW.autor_id IN (n.comprador_id, n.vendedor_id)
          AND NEW.avaliado_id IN (n.comprador_id, n.vendedor_id)) THEN
    RAISE EXCEPTION 'Autor e avaliado precisam ser as partes da negociacao (RNF-07)';
  END IF;

  IF (NEW.papel_autor = 'comprador' AND NEW.autor_id <> n.comprador_id)
     OR (NEW.papel_autor = 'vendedor' AND NEW.autor_id <> n.vendedor_id) THEN
    RAISE EXCEPTION 'Papel informado nao corresponde ao autor da avaliacao';
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER avaliacao_validar
  BEFORE INSERT ON avaliacao
  FOR EACH ROW EXECUTE FUNCTION avaliacao_validar();

-- RF-39: reputacao agregada recalculada a cada publicacao.
CREATE FUNCTION reputacao_recalcular() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  alvo uuid := COALESCE(NEW.avaliado_id, OLD.avaliado_id);
BEGIN
  UPDATE usuario u
     SET reputacao = sub.media,
         total_avaliacoes = sub.total
    FROM (
      SELECT round(avg(nota), 2) AS media, count(*) AS total
        FROM avaliacao
       WHERE avaliado_id = alvo AND publicada_em IS NOT NULL
    ) AS sub
   WHERE u.id = alvo;
  RETURN NULL;
END;
$$;

CREATE TRIGGER avaliacao_reputacao
  AFTER INSERT OR UPDATE OF publicada_em ON avaliacao
  FOR EACH ROW EXECUTE FUNCTION reputacao_recalcular();

-- RNF-06: as duas avaliacoes saem juntas. A rotina assincrona chama esta funcao
-- quando ambas chegam ou quando o prazo vence.
CREATE FUNCTION publicar_avaliacoes(p_negociacao_id uuid, p_prazo_vencido boolean DEFAULT false)
RETURNS integer
LANGUAGE plpgsql AS $$
DECLARE
  enviadas integer;
  publicadas integer;
BEGIN
  SELECT count(*) INTO enviadas
    FROM avaliacao WHERE negociacao_id = p_negociacao_id;

  IF enviadas < 2 AND NOT p_prazo_vencido THEN
    RETURN 0;   -- ainda oculta: falta a contraparte avaliar
  END IF;

  UPDATE avaliacao
     SET publicada_em = now()
   WHERE negociacao_id = p_negociacao_id
     AND publicada_em IS NULL;

  GET DIAGNOSTICS publicadas = ROW_COUNT;
  RETURN publicadas;
END;
$$;

-- RF-40: historico somente leitura das negociacoes concluidas e canceladas.
CREATE VIEW vw_historico_negociacao AS
SELECT n.id                AS negociacao_id,
       n.status,
       n.valor_final,
       n.iniciada_em,
       COALESCE(n.concluida_em, n.cancelada_em) AS encerrada_em,
       a.id                AS anuncio_id,
       a.titulo            AS anuncio_titulo,
       c.nome              AS categoria,
       n.comprador_id,
       n.vendedor_id,
       comprador.nome      AS comprador_nome,
       vendedor.nome       AS vendedor_nome
  FROM negociacao n
  JOIN anuncio  a         ON a.id = n.anuncio_id
  JOIN categoria c        ON c.id = a.categoria_id
  JOIN usuario  comprador ON comprador.id = n.comprador_id
  JOIN usuario  vendedor  ON vendedor.id  = n.vendedor_id
 WHERE n.status IN ('concluida', 'cancelada');

COMMENT ON VIEW vw_historico_negociacao IS
  'Base do GET /historico (RF-40). Filtrar por comprador_id ou vendedor_id na '
  'aplicacao: cada usuario acessa apenas o proprio historico (RNF-07).';
