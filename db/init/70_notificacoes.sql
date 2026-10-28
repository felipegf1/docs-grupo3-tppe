-- =============================================================================
-- Quero. — App "notificacoes" (Epico 6 · QRO-17)
-- =============================================================================

CREATE TABLE notificacao (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  tipo       text NOT NULL,
  titulo     text NOT NULL,
  corpo      text,
  -- Rota do frontend para onde a notificacao leva.
  link       text,
  -- QRO-17: notificacoes do mesmo tipo em curto intervalo sao agrupadas.
  agrupadas  integer NOT NULL DEFAULT 1 CHECK (agrupadas >= 1),
  enviada_email_em timestamptz,
  lida_em    timestamptz,
  criado_em  timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX notificacao_caixa_idx
  ON notificacao (usuario_id, criado_em DESC);
CREATE INDEX notificacao_nao_lida_idx
  ON notificacao (usuario_id)
  WHERE lida_em IS NULL;

-- RF-37: o usuario configura tipos e canais, exceto avisos de seguranca.
CREATE TABLE preferencia_notificacao (
  usuario_id uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  tipo       text NOT NULL,
  no_app     boolean NOT NULL DEFAULT true,
  por_email  boolean NOT NULL DEFAULT true,
  PRIMARY KEY (usuario_id, tipo),
  -- O unico canal que nao pode ser desligado.
  CONSTRAINT seguranca_nao_desligavel
    CHECK (tipo <> 'seguranca_conta' OR (no_app AND por_email))
);

COMMENT ON CONSTRAINT seguranca_nao_desligavel ON preferencia_notificacao IS
  'RF-37: o usuario pode desativar tudo, menos avisos de seguranca da conta.';
