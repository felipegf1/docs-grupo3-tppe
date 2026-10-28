# Banco de dados do Quero.

PostgreSQL 16 com PostGIS. O schema aqui é a tradução do modelo descrito em
[`docs/arquitetura/backend.md`](../docs/arquitetura/backend.md#modelo-de-dados) e das regras das
19 histórias de usuário.

## Subir

```bash
cp .env.example .env
docker compose up -d db pgadmin      # ou podman-compose
```

São **duas senhas diferentes**, e confundi-las é o erro mais fácil de cometer aqui:

| Onde | Usuário | Senha |
|---|---|---|
| Login do pgAdmin (a tela de entrada) | `admin@quero.test` | `admin` |
| Conexão com o banco | `tppe` | `tppe` |
| `psql` / DBeaver / string de conexão | `tppe` | `tppe`, base `tppe`, porta 5432 |

A conexão **Quero. - desenvolvimento** já aparece na árvore lateral do pgAdmin e **não pede
senha**: o serviço `pgadmin` recebe `PGPASSWORD` do `.env`, e o libpq a usa ao conectar.

> **Por que não um `passfile`?** Foi a primeira tentativa e não funciona aqui. O processo do
> pgAdmin roda como uid 5050, enquanto um arquivo montado do host aparece como `root:root`
> dentro do container — e o libpq exige modo `0600` no passfile, o que impede afrouxar a
> permissão para contornar. O sintoma é `fe_sendauth: no password supplied`.

## Recriar do zero

Os scripts de `init/` rodam **somente na criação do volume**. Depois de alterar qualquer `.sql`:

```bash
docker compose down -v && docker compose up -d db pgadmin
```

## Organização

A numeração dos arquivos espelha os apps do Django previstos no backend:

| Arquivo | App | Conteúdo |
|---|---|---|
| `00_extensoes.sql` | — | postgis, citext, pg_trgm, unaccent |
| `05_tipos.sql` | — | ENUMs dos estados, domínios `dinheiro`, `nota`, `sigla_uf` |
| `06_auditoria.sql` | `core` | `transicao_estado` e gatilho genérico (RNF-13) |
| `10_contas.sql` | `contas` | `usuario`, `localizacao`, `token_redefinicao_senha` |
| `15_taxonomia.sql` | — | `categoria` (as 8 do glossário) |
| `20_anuncios.sql` | `anuncios` | `anuncio`, `alcance`, índices GiST, máquina de estados |
| `30_catalogo.sql` | `catalogo` | `produto`, `produto_foto` |
| `40_ofertas.sql` | `ofertas` | `oferta`, `busca_salva` |
| `50_negociacao.sql` | `negociacao` | `palpite`, `negociacao`, `contraproposta`, `conversa`, `mensagem`, `denuncia`, `bloqueio` |
| `60_descoberta.sql` | `descoberta` | `recomendacao` |
| `70_notificacoes.sql` | `notificacoes` | `notificacao`, `preferencia_notificacao` |
| `80_reputacao.sql` | `reputacao` | `avaliacao`, publicação simultânea, reputação agregada |
| `99_seed.sql` | — | Massa de exemplo |

## O que o banco garante sozinho

Estas regras estão em *constraints* e *triggers*, não apenas na aplicação:

| Regra | Onde | Origem |
|---|---|---|
| `alcance` = buffer de `ponto` + `raio_m`, recalculado a cada mudança | trigger `anuncio_alcance` | RNF-09 |
| Anúncio encerrado não reabre | trigger `anuncio_transicao` | QRO-05 |
| Negociação concluída não reabre | trigger `negociacao_sem_reabertura` | RNF-14 |
| Uma oferta ativa por vendedor em cada anúncio | índice parcial único | QRO-06 |
| Uma oferta aceita por anúncio | índice parcial único | RF-32 |
| Uma contraproposta em aberto por oferta | índice parcial único | RF-25 |
| Um palpite por vendedor em cada anúncio | `UNIQUE` | QRO-10 |
| Faixa de palpites só a partir de 3 | view `vw_palpite_faixa` | RNF-05 |
| Mensagem e avaliação imutáveis | trigger `impedir_alteracao` | RNF-12 |
| Avaliação só após conclusão, uma por parte | trigger + `UNIQUE` | QRO-18 |
| Avaliações publicadas juntas | função `publicar_avaliacoes()` | RNF-06 |
| Notificação de segurança não desligável | `CHECK` | RF-37 |
| Toda transição de estado registrada | tabela `transicao_estado` | RNF-13 |

## Consultas para experimentar no pgAdmin

```sql
-- Feed de um vendedor: quais anúncios têm raio grande o bastante para alcançá-lo?
SELECT a.titulo,
       round((ST_Distance(a.ponto, l.ponto) / 1000)::numeric, 1) AS distancia_km,
       a.raio_m / 1000 AS raio_km
  FROM anuncio a, localizacao l
 WHERE l.usuario_id = (SELECT id FROM usuario WHERE email = 'carla@exemplo.test')
   AND a.status = 'ativo'
   AND ST_Intersects(a.alcance, l.ponto)
 ORDER BY distancia_km;

-- Por que o índice importa: compare os planos
EXPLAIN ANALYZE
SELECT * FROM anuncio a, localizacao l
 WHERE l.usuario_id = (SELECT id FROM usuario WHERE email = 'carla@exemplo.test')
   AND ST_Intersects(a.alcance, l.ponto);

-- Faixa estimada pelo mercado, anônima (RNF-05)
SELECT a.titulo, f.* FROM vw_palpite_faixa f JOIN anuncio a ON a.id = f.anuncio_id;

-- Trilha de auditoria de uma negociação (RNF-13)
SELECT * FROM transicao_estado ORDER BY criado_em;
```

## Relação com o Django

Este schema **precede** o `backend/`. Quando o projeto Django entrar, uma das duas fontes tem
de ceder: ou vira `models.py` — `manage.py inspectdb` faz o rascunho — e `db/init/` passa a ser
referência, ou as migrações assumem e este diretório é esvaziado. Rodar `migrate` sobre este
banco sem decidir isso cria tabelas duplicadas.

As contas do seed têm um hash de fachada no lugar da senha: **nenhuma delas autentica**.
