-- =============================================================================
-- Quero. — Massa de exemplo para desenvolvimento
-- Espalhada pelas cidades do prototipo: Sao Paulo, Campinas, Rio de Janeiro,
-- Belo Horizonte e Curitiba (docs/arquitetura/geolocalizacao.md).
--
-- NAO e massa de carga: serve para navegar no pgAdmin e ver as regras agindo.
-- O volume real (100 mil anuncios do RNF-08) vem da factory do backend.
-- =============================================================================

-- Hash de fachada, no formato do Django. Nenhuma destas contas tem senha valida.
\set senha '''pbkdf2_sha256$720000$semente-dev$NAO-E-UMA-SENHA-REAL'''

INSERT INTO usuario (id, nome, email, senha_hash, telefone) VALUES
  ('a0000000-0000-4000-8000-000000000001', 'Ana Ribeiro',   'ana@exemplo.test',    :senha, '11988880001'),
  ('a0000000-0000-4000-8000-000000000002', 'Bruno Tavares', 'bruno@exemplo.test',  :senha, '11988880002'),
  ('a0000000-0000-4000-8000-000000000003', 'Carla Mendes',  'carla@exemplo.test',  :senha, '19988880003'),
  ('a0000000-0000-4000-8000-000000000004', 'Diego Souza',   'diego@exemplo.test',  :senha, '21988880004'),
  ('a0000000-0000-4000-8000-000000000005', 'Helena Castro', 'helena@exemplo.test', :senha, '21988880005'),
  ('a0000000-0000-4000-8000-000000000006', 'Elisa Prado',   'elisa@exemplo.test',  :senha, '31988880006'),
  ('a0000000-0000-4000-8000-000000000007', 'Fabio Lima',    'fabio@exemplo.test',  :senha, '41988880007');

INSERT INTO localizacao (usuario_id, ponto, cep, cidade, uf) VALUES
  ('a0000000-0000-4000-8000-000000000001', ST_MakePoint(-46.6333, -23.5505)::geography, '01310100', 'São Paulo',      'SP'),
  ('a0000000-0000-4000-8000-000000000002', ST_MakePoint(-46.6900, -23.5900)::geography, '05409000', 'São Paulo',      'SP'),
  ('a0000000-0000-4000-8000-000000000003', ST_MakePoint(-47.0626, -22.9099)::geography, '13015000', 'Campinas',       'SP'),
  ('a0000000-0000-4000-8000-000000000004', ST_MakePoint(-43.1729, -22.9068)::geography, '20040020', 'Rio de Janeiro', 'RJ'),
  ('a0000000-0000-4000-8000-000000000005', ST_MakePoint(-43.2000, -22.9500)::geography, '22250040', 'Rio de Janeiro', 'RJ'),
  ('a0000000-0000-4000-8000-000000000006', ST_MakePoint(-43.9345, -19.9167)::geography, '30130000', 'Belo Horizonte', 'MG'),
  ('a0000000-0000-4000-8000-000000000007', ST_MakePoint(-49.2733, -25.4284)::geography, '80010000', 'Curitiba',       'PR');

-- --- Anuncios de "procura-se" -------------------------------------------------
-- O raio de cada anuncio decide quem o enxerga. A1 (30 km) alcanca Bruno em SP
-- mas nao Carla em Campinas; A2 (120 km) alcanca as duas.

INSERT INTO anuncio (id, comprador_id, categoria_id, titulo, descricao, preco_min, preco_max, raio_m, ponto, cidade, uf) VALUES
  ('b0000000-0000-4000-8000-000000000001',
   'a0000000-0000-4000-8000-000000000001',
   (SELECT id FROM categoria WHERE slug = 'esportes'),
   'Bicicleta aro 29 para trilha',
   'Procuro bicicleta aro 29, quadro M, com suspensão dianteira. Aceito usada em bom estado.',
   1200.00, 2500.00, 30000,
   ST_MakePoint(-46.6333, -23.5505)::geography, 'São Paulo', 'SP'),

  ('b0000000-0000-4000-8000-000000000002',
   'a0000000-0000-4000-8000-000000000001',
   (SELECT id FROM categoria WHERE slug = 'informatica'),
   'Notebook para faculdade',
   'Procuro notebook i5 ou superior, 16GB de RAM e SSD. Uso para estudo e programação.',
   2000.00, 3500.00, 120000,
   ST_MakePoint(-46.6333, -23.5505)::geography, 'São Paulo', 'SP'),

  ('b0000000-0000-4000-8000-000000000003',
   'a0000000-0000-4000-8000-000000000004',
   (SELECT id FROM categoria WHERE slug = 'games'),
   'PlayStation 5 com dois controles',
   'Procuro PS5 em bom estado, de preferência com dois controles e caixa original.',
   2800.00, 3600.00, 25000,
   ST_MakePoint(-43.1729, -22.9068)::geography, 'Rio de Janeiro', 'RJ'),

  ('b0000000-0000-4000-8000-000000000004',
   'a0000000-0000-4000-8000-000000000006',
   (SELECT id FROM categoria WHERE slug = 'instrumentos'),
   'Violão elétrico para iniciante',
   'Procuro violão elétrico com case. Ainda estou aprendendo, não precisa ser topo de linha.',
   600.00, 1400.00, 50000,
   ST_MakePoint(-43.9345, -19.9167)::geography, 'Belo Horizonte', 'MG');

-- --- Catalogo dos vendedores --------------------------------------------------

INSERT INTO produto (id, vendedor_id, categoria_id, nome, descricao, estado_conservacao, preco) VALUES
  ('c0000000-0000-4000-8000-000000000001',
   'a0000000-0000-4000-8000-000000000002',
   (SELECT id FROM categoria WHERE slug = 'esportes'),
   'Caloi Elite Carbon aro 29',
   'Bicicleta aro 29 quadro M, suspensão RockShox, revisada em janeiro. Poucas marcas de uso.',
   'usado_bom_estado', 2300.00),

  ('c0000000-0000-4000-8000-000000000002',
   'a0000000-0000-4000-8000-000000000003',
   (SELECT id FROM categoria WHERE slug = 'informatica'),
   'Dell Inspiron 15 i5 16GB',
   'Notebook i5 de 11a geração, 16GB de RAM, SSD de 512GB. Bateria trocada há seis meses.',
   'seminovo', 2900.00),

  ('c0000000-0000-4000-8000-000000000003',
   'a0000000-0000-4000-8000-000000000005',
   (SELECT id FROM categoria WHERE slug = 'games'),
   'PlayStation 5 edição digital',
   'PS5 digital com dois controles DualSense e caixa original. Comprado em 2023.',
   'seminovo', 3200.00);

INSERT INTO produto_foto (produto_id, url, ordem, bytes) VALUES
  ('c0000000-0000-4000-8000-000000000001', 'https://exemplo.test/fotos/caloi-1.jpg', 1, 240000),
  ('c0000000-0000-4000-8000-000000000001', 'https://exemplo.test/fotos/caloi-2.jpg', 2, 198000),
  ('c0000000-0000-4000-8000-000000000003', 'https://exemplo.test/fotos/ps5-1.jpg',   1, 310000);

-- --- Ofertas ------------------------------------------------------------------
-- Os dados sao copiados do produto no envio (RNF-15): editar o catalogo depois
-- nao muda nada aqui.

INSERT INTO oferta (id, anuncio_id, vendedor_id, produto_id, titulo, descricao, estado_conservacao, preco, preco_inicial) VALUES
  ('d0000000-0000-4000-8000-000000000001',
   'b0000000-0000-4000-8000-000000000001',
   'a0000000-0000-4000-8000-000000000002',
   'c0000000-0000-4000-8000-000000000001',
   'Caloi Elite Carbon aro 29',
   'Bicicleta aro 29 quadro M, suspensão RockShox, revisada em janeiro. Poucas marcas de uso.',
   'usado_bom_estado', 2300.00, 2300.00),

  -- Oferta avulsa, sem produto no catalogo: o fluxo funciona sem o QRO-08.
  ('d0000000-0000-4000-8000-000000000002',
   'b0000000-0000-4000-8000-000000000002',
   'a0000000-0000-4000-8000-000000000002',
   NULL,
   'Lenovo IdeaPad 3 i5 16GB',
   'Notebook i5 de 12a geração com 16GB e SSD de 256GB. Tenho nota fiscal.',
   'usado_bom_estado', 2650.00, 2650.00),

  ('d0000000-0000-4000-8000-000000000003',
   'b0000000-0000-4000-8000-000000000003',
   'a0000000-0000-4000-8000-000000000005',
   'c0000000-0000-4000-8000-000000000003',
   'PlayStation 5 edição digital',
   'PS5 digital com dois controles DualSense e caixa original. Comprado em 2023.',
   'seminovo', 3200.00, 3200.00);

-- --- Palpites (QRO-10) --------------------------------------------------------
-- Tres palpites no anuncio do notebook: e o minimo para a faixa aparecer ao
-- comprador (RNF-05). O anuncio da bicicleta fica com menos, de proposito.

INSERT INTO palpite (anuncio_id, vendedor_id, valor) VALUES
  ('b0000000-0000-4000-8000-000000000002', 'a0000000-0000-4000-8000-000000000002', 2700.00),
  ('b0000000-0000-4000-8000-000000000002', 'a0000000-0000-4000-8000-000000000003', 2950.00),
  ('b0000000-0000-4000-8000-000000000002', 'a0000000-0000-4000-8000-000000000005', 3100.00),
  ('b0000000-0000-4000-8000-000000000001', 'a0000000-0000-4000-8000-000000000002', 2100.00);

-- --- Conversa e barganha (QRO-12, QRO-14) -------------------------------------

INSERT INTO conversa (oferta_id) VALUES
  ('d0000000-0000-4000-8000-000000000001'),
  ('d0000000-0000-4000-8000-000000000003');

INSERT INTO mensagem (oferta_id, autor_id, corpo) VALUES
  ('d0000000-0000-4000-8000-000000000001', 'a0000000-0000-4000-8000-000000000001',
   'Oi Bruno! A suspensão foi revisada junto com a bike?'),
  ('d0000000-0000-4000-8000-000000000001', 'a0000000-0000-4000-8000-000000000002',
   'Foi sim, tenho a nota da revisão. Posso mandar foto do comprovante.');

-- Contraproposta em aberto na oferta da bicicleta: a oferta vai para
-- "em_negociacao" e o valor de partida fica guardado em preco_inicial.
INSERT INTO contraproposta (oferta_id, autor, valor, justificativa, rodada, expira_em) VALUES
  ('d0000000-0000-4000-8000-000000000001', 'comprador', 2050.00,
   'Achei o estado ótimo, mas o meu limite é esse. Levo hoje se topar.',
   1, now() + interval '48 hours');

UPDATE oferta
   SET status = 'em_negociacao', rodadas_usadas = 1
 WHERE id = 'd0000000-0000-4000-8000-000000000001';

-- --- Uma negociacao levada ate o fim (QRO-15, QRO-16, QRO-18) ------------------

-- 1. Comprador aceita a oferta do PS5.
UPDATE oferta SET status = 'aceita' WHERE id = 'd0000000-0000-4000-8000-000000000003';
UPDATE anuncio SET status = 'em_negociacao' WHERE id = 'b0000000-0000-4000-8000-000000000003';
UPDATE produto SET status = 'reservado' WHERE id = 'c0000000-0000-4000-8000-000000000003';

INSERT INTO negociacao (id, anuncio_id, oferta_id, comprador_id, vendedor_id, produto_id, valor_final, prazo_confirmacao) VALUES
  ('e0000000-0000-4000-8000-000000000001',
   'b0000000-0000-4000-8000-000000000003',
   'd0000000-0000-4000-8000-000000000003',
   'a0000000-0000-4000-8000-000000000004',
   'a0000000-0000-4000-8000-000000000005',
   'c0000000-0000-4000-8000-000000000003',
   3200.00,
   now() + interval '72 hours');

-- 2. As duas partes confirmam: a venda e concluida.
UPDATE negociacao
   SET confirmada_comprador_em = now() - interval '2 days',
       confirmada_vendedor_em  = now() - interval '2 days',
       status = 'concluida',
       concluida_em = now() - interval '2 days'
 WHERE id = 'e0000000-0000-4000-8000-000000000001';

UPDATE produto SET status = 'vendido'   WHERE id = 'c0000000-0000-4000-8000-000000000003';
UPDATE anuncio SET status = 'encerrado', encerrado_em = now() - interval '2 days'
 WHERE id = 'b0000000-0000-4000-8000-000000000003';
UPDATE conversa SET somente_leitura = true WHERE oferta_id = 'd0000000-0000-4000-8000-000000000003';

-- 3. As duas avaliam. Note que elas nascem ocultas (publicada_em IS NULL).
INSERT INTO avaliacao (negociacao_id, autor_id, avaliado_id, papel_autor, nota, comentario) VALUES
  ('e0000000-0000-4000-8000-000000000001',
   'a0000000-0000-4000-8000-000000000004', 'a0000000-0000-4000-8000-000000000005',
   'comprador', 5, 'Entrega combinada e cumprida, console impecável.'),
  ('e0000000-0000-4000-8000-000000000001',
   'a0000000-0000-4000-8000-000000000005', 'a0000000-0000-4000-8000-000000000004',
   'vendedor', 5, 'Comprador pontual, negociação tranquila.');

-- 4. So agora, com as duas enviadas, elas sao publicadas juntas (RNF-06)
--    e a reputacao dos dois e recalculada pelo gatilho.
SELECT publicar_avaliacoes('e0000000-0000-4000-8000-000000000001');

-- --- Descoberta, buscas salvas e notificacoes ---------------------------------

-- O notebook da Carla esta em Campinas, dentro dos 120 km do anuncio da Ana,
-- e ela ainda nao ofertou: vira recomendacao, nao oferta (QRO-09).
INSERT INTO recomendacao (anuncio_id, produto_id, score, distancia_m, criterios) VALUES
  ('b0000000-0000-4000-8000-000000000002',
   'c0000000-0000-4000-8000-000000000002',
   0.8700, 89000,
   '{"categoria": true, "faixa_preco": true, "palavras_chave": ["notebook", "i5", "16GB"]}'::jsonb);

INSERT INTO busca_salva (vendedor_id, nome, filtros) VALUES
  ('a0000000-0000-4000-8000-000000000002', 'Informática até 50 km',
   '{"categorias": ["informatica"], "distancia_max_km": 50, "ordenar_por": "distancia"}'::jsonb);

INSERT INTO preferencia_notificacao (usuario_id, tipo, no_app, por_email) VALUES
  ('a0000000-0000-4000-8000-000000000001', 'oferta_recebida',     true,  true),
  ('a0000000-0000-4000-8000-000000000001', 'contraproposta',      true,  false),
  ('a0000000-0000-4000-8000-000000000001', 'seguranca_conta',     true,  true),
  ('a0000000-0000-4000-8000-000000000002', 'contraproposta',      true,  true),
  ('a0000000-0000-4000-8000-000000000002', 'seguranca_conta',     true,  true);

INSERT INTO notificacao (usuario_id, tipo, titulo, corpo, link) VALUES
  ('a0000000-0000-4000-8000-000000000001', 'oferta_recebida',
   'Você recebeu uma oferta', 'Bruno Tavares ofertou R$ 2.300,00 na sua bicicleta aro 29.',
   '/anuncios/b0000000-0000-4000-8000-000000000001/ofertas'),
  ('a0000000-0000-4000-8000-000000000002', 'contraproposta',
   'Nova contraproposta', 'Ana Ribeiro propôs R$ 2.050,00. Você tem 48 horas para responder.',
   '/ofertas/d0000000-0000-4000-8000-000000000001');
