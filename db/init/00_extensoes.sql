-- =============================================================================
-- Quero. — Extensoes do banco
-- Fase 0 da infraestrutura: "Primeira migracao com CREATE EXTENSION postgis"
-- Ver docs/arquitetura/infraestrutura.md
-- =============================================================================

-- Raio de busca, alcance materializado e calculo de distancia (RNF-09).
CREATE EXTENSION IF NOT EXISTS postgis;

-- E-mail como identificador unico e case-insensitive (RF-01).
CREATE EXTENSION IF NOT EXISTS citext;

-- Busca textual tolerante a erro de digitacao no feed (RF-15).
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS unaccent;

COMMENT ON DATABASE tppe IS
  'Quero. — plataforma de compras reversa. Modelo derivado de docs/arquitetura/backend.md';
