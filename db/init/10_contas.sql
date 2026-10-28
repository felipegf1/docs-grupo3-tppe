-- =============================================================================
-- Quero. — App "contas" (Epico 1 · QRO-01 a QRO-03)
-- Usuario, autenticacao e localizacao de referencia.
-- =============================================================================

CREATE TABLE usuario (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nome             text NOT NULL CHECK (length(btrim(nome)) >= 2),
  -- RF-01: o e-mail e o identificador unico da conta.
  email            citext NOT NULL UNIQUE CHECK (email ~ '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$'),
  -- RNF-01: apenas o hash, gerado por algoritmo de derivacao lento (PBKDF2).
  senha_hash       text NOT NULL,
  telefone         text CHECK (telefone IS NULL OR telefone ~ '^[0-9]{10,11}$'),
  foto_url         text,
  -- RF-39: reputacao agregada, mantida pelo gatilho em 80_reputacao.sql.
  reputacao        numeric(3, 2) CHECK (reputacao BETWEEN 1 AND 5),
  total_avaliacoes integer NOT NULL DEFAULT 0 CHECK (total_avaliacoes >= 0),
  ativo            boolean NOT NULL DEFAULT true,
  -- RNF-03: bloqueio temporario apos tentativas malsucedidas.
  tentativas_login smallint NOT NULL DEFAULT 0 CHECK (tentativas_login >= 0),
  bloqueado_ate    timestamptz,
  criado_em        timestamptz NOT NULL DEFAULT now(),
  atualizado_em    timestamptz NOT NULL DEFAULT now()
);

COMMENT ON TABLE usuario IS
  'Conta unica: a mesma pessoa atua como comprador e como vendedor (RF-03).';
COMMENT ON COLUMN usuario.reputacao IS
  'Media das avaliacoes publicadas. NULL enquanto nao houver nenhuma (RF-39).';

CREATE TRIGGER usuario_atualizado_em
  BEFORE UPDATE ON usuario
  FOR EACH ROW EXECUTE FUNCTION tocar_atualizado_em();

-- RF-02 / RF-07: uma unica localizacao de referencia por usuario, por isso a
-- chave primaria e o proprio usuario_id.
CREATE TABLE localizacao (
  usuario_id    uuid PRIMARY KEY REFERENCES usuario(id) ON DELETE CASCADE,
  ponto         geography(Point, 4326) NOT NULL,
  cep           text CHECK (cep IS NULL OR cep ~ '^[0-9]{8}$'),
  logradouro    text,
  cidade        text NOT NULL,
  uf            sigla_uf NOT NULL,
  atualizado_em timestamptz NOT NULL DEFAULT now()
);

COMMENT ON TABLE localizacao IS
  'Centro de todos os calculos de distancia. Alterar o ponto nao altera o raio '
  'dos anuncios ja publicados (QRO-03).';

-- RNF-09: pre-filtro barato por cidade antes do calculo espacial.
CREATE INDEX localizacao_ponto_idx  ON localizacao USING gist (ponto);
CREATE INDEX localizacao_cidade_idx ON localizacao (uf, cidade);

CREATE TRIGGER localizacao_atualizado_em
  BEFORE UPDATE ON localizacao
  FOR EACH ROW EXECUTE FUNCTION tocar_atualizado_em();

-- RF-05: redefinicao de senha por link temporario de uso unico.
CREATE TABLE token_redefinicao_senha (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  token_hash text NOT NULL UNIQUE,   -- o token em claro nunca e persistido
  expira_em  timestamptz NOT NULL,
  usado_em   timestamptz,
  criado_em  timestamptz NOT NULL DEFAULT now(),
  CHECK (expira_em > criado_em)
);

-- Uso unico: no maximo um token valido por conta.
CREATE UNIQUE INDEX token_redefinicao_ativo_idx
  ON token_redefinicao_senha (usuario_id)
  WHERE usado_em IS NULL;
