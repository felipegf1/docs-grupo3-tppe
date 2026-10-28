-- =============================================================================
-- Quero. — App "catalogo" (Epico 3 · QRO-08)
-- Produtos do vendedor. No feed aparecem com o badge "Vendendo".
-- =============================================================================

CREATE TABLE produto (
  id                 uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  vendedor_id        uuid NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  categoria_id       smallint NOT NULL REFERENCES categoria(id),

  -- QRO-08: nome, categoria, descricao e estado de conservacao sao obrigatorios.
  nome               text NOT NULL CHECK (length(btrim(nome)) >= 3),
  descricao          text NOT NULL CHECK (length(btrim(descricao)) >= 10),
  estado_conservacao estado_conservacao NOT NULL,
  preco              dinheiro,

  status             status_produto NOT NULL DEFAULT 'disponivel',
  criado_em          timestamptz NOT NULL DEFAULT now(),
  atualizado_em      timestamptz NOT NULL DEFAULT now()
);

COMMENT ON TABLE produto IS
  'Catalogo do vendedor (RF-17). Um produto reservado nao pode ser ofertado em '
  'outro anuncio; um produto vendido sai das recomendacoes.';

CREATE INDEX produto_vendedor_idx  ON produto (vendedor_id, status);
CREATE INDEX produto_disponivel_idx ON produto (categoria_id) WHERE status = 'disponivel';

CREATE TRIGGER produto_atualizado_em
  BEFORE UPDATE ON produto
  FOR EACH ROW EXECUTE FUNCTION tocar_atualizado_em();

CREATE TRIGGER produto_auditoria
  AFTER INSERT OR UPDATE OF status ON produto
  FOR EACH ROW EXECUTE FUNCTION auditar_status('produto');

-- QRO-08: fotos tem limite de quantidade e tamanho por produto.
CREATE TABLE produto_foto (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  produto_id uuid NOT NULL REFERENCES produto(id) ON DELETE CASCADE,
  url        text NOT NULL,
  bytes      integer CHECK (bytes IS NULL OR bytes <= 5 * 1024 * 1024),
  ordem      smallint NOT NULL CHECK (ordem BETWEEN 1 AND 8),
  criado_em  timestamptz NOT NULL DEFAULT now(),
  UNIQUE (produto_id, ordem)
);

COMMENT ON COLUMN produto_foto.ordem IS
  'Posicao na galeria, 1 a 8. O limite de 8 fotos vem da regra de negocio do QRO-08.';
