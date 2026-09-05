# Infraestrutura

Ambientes, orquestração e o esboço do que ainda será construído no **Quero.**.

## :material-docker: Serviços

| Serviço | Imagem / base | Porta | Situação |
| :--- | :--- | :--- | :--- |
| `db` | `postgis/postgis:16-3.4` | 5432 | **A ajustar** — hoje é `postgres:16-alpine`, sem PostGIS |
| `backend` | `python:3.12-slim` + GEOS/GDAL/PROJ | 8000 | **A criar** — o diretório `backend/` não existe |
| `frontend` | `node:20-alpine` + Vite | 3000 | **A criar** — o diretório `frontend/` não existe |
| `worker` | mesma imagem do backend | — | **A criar** — a partir da Release 3 |
| `redis` | `redis:7-alpine` | 6379 | **A criar** — a partir da Release 3 |
| `adminer` | `adminer:latest` | 8080 | Pronto |
| `docs` | `squidfunk/mkdocs-material:9` | 8001 | Pronto e em uso |

!!! danger "O compose atual não suporta o raio de busca"
    A imagem `postgres:16-alpine` declarada hoje **não contém a extensão PostGIS**. Enquanto ela não for trocada, `CREATE EXTENSION postgis` falha e nenhuma consulta por raio funciona. Essa é a primeira mudança de infraestrutura a ser feita.

## :material-file-document-edit-outline: Mudanças necessárias no `docker-compose.yml`

```diff
   db:
-    image: postgres:16-alpine
+    image: postgis/postgis:16-3.4
     container_name: tppe-db
```

E os serviços a acrescentar quando a Release 3 começar:

```yaml
  redis:
    image: redis:7-alpine
    container_name: tppe-redis
    ports:
      - "${REDIS_PORT:-6379}:6379"
    networks: [tppe]

  worker:
    build:
      context: ./backend
      dockerfile: Dockerfile
    container_name: tppe-worker
    command: celery -A quero worker -l info
    environment:
      DATABASE_URL: postgresql://${POSTGRES_USER:-tppe}:${POSTGRES_PASSWORD:-tppe}@db:5432/${POSTGRES_DB:-tppe}
      REDIS_URL: redis://redis:6379/0
    depends_on: [db, redis]
    networks: [tppe]
```

Variáveis novas para o `.env.example`:

```bash
# Fila e cache
REDIS_PORT=6379
REDIS_URL=redis://redis:6379/0

# Geocodificação
GEOCODER_URL=https://nominatim.openstreetmap.org
GEOCODER_USER_AGENT=quero-tppe

# Regras configuráveis (RNF-23)
RAIO_PADRAO_KM=20
RAIO_MAXIMO_KM=200
LIMITE_RODADAS_NEGOCIACAO=5
PRAZO_CONTRAPROPOSTA_HORAS=48
PRAZO_CONFIRMACAO_VENDA_HORAS=72
```

O [RNF-23](../produto/requisitos.md#operacao) exige que prazos, limite de rodadas e raio padrão sejam configuráveis sem alterar código — daí virem do ambiente.

## :material-server-network: Ambientes

| Ambiente | Onde | Banco | Publicação |
| :--- | :--- | :--- | :--- |
| **Desenvolvimento** | Máquina de cada pessoa, via Docker Compose | Container PostGIS local com massa de exemplo | — |
| **Documentação** | GitHub Pages | — | Automática a cada push na `main` |
| **Demonstração** | A definir | PostGIS gerenciado | Manual, ao fim de cada release |

## :material-pipe: Integração contínua

Hoje existe um único workflow, [`deploy-docs.yml`](https://github.com/felipegf1/docs-grupo3-tppe/blob/main/.github/workflows/deploy-docs.yml), que publica a documentação. Quando o código existir, dois workflows entram:

| Workflow | Gatilho | O que faz |
| :--- | :--- | :--- |
| `ci-backend.yml` | *Pull request* que toca `backend/` | Sobe um serviço PostGIS, roda migrações e `pytest` |
| `ci-frontend.yml` | *Pull request* que toca `frontend/` | Verifica tipos, executa `vitest` e o build de produção |

O `mkdocs build --strict` também deveria rodar em *pull request*, e não só no deploy — hoje um link quebrado só é descoberto depois do *merge* na `main`.

## :material-progress-wrench: O que ainda será realizado

Esboço em fases. As fases 1 a 3 acompanham as releases do [backlog do produto](../backlog/index.md#plano-de-releases); a fase 0 é pré-requisito de todas.

=== "Fase 0 · Fundação técnica"

    Antes da primeira história de usuário. Nada disso está no backlog do produto porque não é funcionalidade — é o chão de fábrica.

    - [ ] Trocar a imagem do banco para `postgis/postgis:16-3.4`
    - [ ] Criar `backend/` com projeto Django, DRF e `django.contrib.gis`
    - [ ] Escrever o `Dockerfile` do backend com GEOS, GDAL e PROJ
    - [ ] Primeira migração com `CREATE EXTENSION postgis`
    - [ ] Criar `frontend/` com Vite, React e TypeScript
    - [ ] Escrever o `Dockerfile` do frontend
    - [ ] Extrair os tokens da identidade visual para `tokens.css`
    - [ ] Acrescentar as variáveis novas ao `.env.example`
    - [ ] Configurar CORS entre `:3000` e `:8000`
    - [ ] Criar os workflows `ci-backend.yml` e `ci-frontend.yml`
    - [ ] Definir o serviço de geocodificação e a política de uso

=== "Fase 1 · Fundação e demanda"

    Acompanha a **Release 1** (`QRO-01` a `QRO-06`).

    - [ ] Apps `contas` e `anuncios`
    - [ ] Autenticação JWT com renovação e bloqueio por tentativas
    - [ ] Modelo `Localizacao` com `geography(Point, 4326)`
    - [ ] Campo `alcance` materializado e índice GiST
    - [ ] Consulta do feed por raio, com distância anotada
    - [ ] Máquina de estados do anúncio
    - [ ] App `ofertas` com uma oferta ativa por vendedor
    - [ ] Telas de cadastro, login, publicação e feed
    - [ ] Seletor de raio com pré-visualização em mapa
    - [ ] *Factory* de massa de dados espalhada geograficamente

=== "Fase 2 · Oferta e barganha"

    Acompanha a **Release 2** (`QRO-07` a `QRO-15`).

    - [ ] Busca textual com índice apropriado
    - [ ] Filtros combináveis e paginação por cursor
    - [ ] App `catalogo` com upload de fotos
    - [ ] Congelamento dos dados do produto na oferta
    - [ ] App `negociacao`: palpites, contrapropostas e rodadas
    - [ ] Permissões por objeto isolando ofertas concorrentes
    - [ ] Chat por *polling*, com contrato pronto para WebSocket
    - [ ] Comparação de ofertas lado a lado
    - [ ] Aceite com recusa automática das demais

=== "Fase 3 · Fechamento e confiança"

    Acompanha a **Release 3** (`QRO-16` a `QRO-19` e `QRO-09`).

    - [ ] Subir `redis` e `worker` no compose
    - [ ] Migrar as rotinas de prazo da verificação preguiçosa para Celery
    - [ ] Barramento de eventos de domínio
    - [ ] App `notificacoes` com preferências por tipo e canal
    - [ ] Envio de e-mail transacional
    - [ ] App `reputacao` com publicação simultânea de avaliações
    - [ ] App `descoberta` com a função de compatibilidade por regras
    - [ ] Pré-cálculo assíncrono das recomendações
    - [ ] `EXPLAIN ANALYZE` em todas as consultas espaciais

=== "Transversal"

    Ao longo de todas as fases.

    - [ ] Testes de unidade e integração conforme a *Definition of Done*
    - [ ] Documentação da API gerada a partir do código
    - [ ] Rodar `mkdocs build --strict` em cada *pull request*
    - [ ] Manter esta seção de arquitetura em dia com o código

## :material-alert-outline: Riscos de infraestrutura

| Risco | Impacto | Mitigação |
| :--- | :--- | :--- |
| Imagem do backend sem GDAL/PROJ | Alto — GeoDjango não sobe | Fixar as bibliotecas no `Dockerfile` e validar na CI |
| Recálculo do `alcance` esquecido em uma edição | Alto — anúncio some do feed sem motivo aparente | Recalcular no `save()` do modelo, não na view |
| Limite de uso do serviço de geocodificação | Médio | Cache de CEP e cidade já resolvidos |
| Dois serviços novos (`redis`, `worker`) no fim do projeto | Médio | Subir o compose completo uma sprint antes de precisar |
| Divergência entre documentação e código | Médio | *Definition of Done* exige atualizar a documentação no mesmo *pull request* |
