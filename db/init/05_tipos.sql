-- =============================================================================
-- Quero. — Tipos, dominios e funcoes compartilhadas
-- Os ENUMs abaixo sao os estados do glossario (docs/produto/glossario.md#estados).
-- =============================================================================

-- --- Estados do dominio -------------------------------------------------------

CREATE TYPE status_anuncio AS ENUM (
  'ativo',          -- visivel no feed e aceitando ofertas
  'pausado',        -- fora do feed; ofertas recebidas continuam acessiveis
  'em_negociacao',  -- uma oferta foi aceita; nao recebe novas
  'encerrado'       -- definitivo, vai para o historico
);

CREATE TYPE status_oferta AS ENUM (
  'enviada',
  'em_negociacao',
  'aceita',
  'recusada',
  'retirada'
);

CREATE TYPE status_produto AS ENUM (
  'disponivel',
  'reservado',
  'vendido'
);

CREATE TYPE status_negociacao AS ENUM (
  'em_andamento',
  'concluida',
  'cancelada'
);

CREATE TYPE status_contraproposta AS ENUM (
  'em_aberto',
  'aceita',
  'recusada',
  'substituida',  -- uma nova contraproposta tomou o lugar (QRO-12)
  'expirada'      -- prazo vencido sem resposta (RF-26)
);

-- Taxonomia fixa de docs/produto/glossario.md#estados-de-conservacao
CREATE TYPE estado_conservacao AS ENUM (
  'novo',
  'seminovo',
  'usado_bom_estado',
  'usado_com_marcas',
  'para_pecas'
);

-- Papel e contexto da acao, nunca tipo de conta (glossario: "Papeis nao sao contas").
CREATE TYPE papel AS ENUM ('comprador', 'vendedor');

-- --- Dominios -----------------------------------------------------------------

-- Valores sempre em reais (RNF-18).
CREATE DOMAIN dinheiro AS numeric(12, 2)
  CHECK (VALUE >= 0);

-- Reputacao e avaliacao usam a mesma escala de 1 a 5 (RF-38).
CREATE DOMAIN nota AS smallint
  CHECK (VALUE BETWEEN 1 AND 5);

CREATE DOMAIN sigla_uf AS char(2)
  CHECK (VALUE ~ '^[A-Z]{2}$');

-- --- Funcoes compartilhadas ---------------------------------------------------

CREATE FUNCTION tocar_atualizado_em() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  NEW.atualizado_em := now();
  RETURN NEW;
END;
$$;

-- RNF-12: mensagens de conversa e avaliacoes sao imutaveis apos o envio.
-- As colunas liberadas viajam em TG_ARGV para o gatilho de cada tabela.
CREATE FUNCTION impedir_alteracao() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE
  coluna text;
  liberadas text[] := COALESCE(TG_ARGV, ARRAY[]::text[]);
BEGIN
  IF TG_OP = 'DELETE' THEN
    RAISE EXCEPTION 'Registro imutavel: % nao pode ser apagado (RNF-12)', TG_TABLE_NAME;
  END IF;

  FOR coluna IN
    SELECT attname
      FROM pg_attribute
     WHERE attrelid = TG_RELID AND attnum > 0 AND NOT attisdropped
  LOOP
    IF coluna = ANY (liberadas) THEN
      CONTINUE;
    END IF;
    IF to_jsonb(NEW) -> coluna IS DISTINCT FROM to_jsonb(OLD) -> coluna THEN
      RAISE EXCEPTION
        'Registro imutavel: %.% nao pode ser alterado (RNF-12)', TG_TABLE_NAME, coluna;
    END IF;
  END LOOP;

  RETURN NEW;
END;
$$;
