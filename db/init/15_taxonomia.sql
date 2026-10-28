-- =============================================================================
-- Quero. — Taxonomia compartilhada
-- Categorias do feed, dos filtros e do calculo de match
-- (docs/produto/glossario.md#categorias).
-- =============================================================================

CREATE TABLE categoria (
  id    smallint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  slug  text NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9-]+$'),
  nome  text NOT NULL UNIQUE,
  ordem smallint NOT NULL
);

COMMENT ON TABLE categoria IS
  'Taxonomia fechada do glossario. Classifica anuncio e produto e entra no match.';

INSERT INTO categoria (slug, nome, ordem) VALUES
  ('eletronicos',  'Eletrônicos',   1),
  ('veiculos',     'Veículos',      2),
  ('informatica',  'Informática',   3),
  ('games',        'Games',         4),
  ('esportes',     'Esportes',      5),
  ('casa-jardim',  'Casa & Jardim', 6),
  ('instrumentos', 'Instrumentos',  7),
  ('outros',       'Outros',        8);
