<div align="center">

# Quero.

**Plataforma de compras reversa para produtos usados e seminovos.**

*Você anuncia o que quer. Os vendedores te encontram.*

[![Documentação](https://img.shields.io/badge/docs-GitHub%20Pages-D97338?style=flat-square)](https://felipegf1.github.io/docs-grupo3-tppe/)
[![MkDocs Material](https://img.shields.io/badge/MkDocs-Material-D97338?style=flat-square)](https://squidfunk.github.io/mkdocs-material/)
[![Disciplina](https://img.shields.io/badge/UnB-TPPE%20%C2%B7%20Grupo%203-1A1A1A?style=flat-square)](https://felipegf1.github.io/docs-grupo3-tppe/)

</div>

---

## Sobre o projeto

No **Quero.** a lógica do marketplace se inverte. Em vez de o vendedor anunciar o que tem à venda, é o **comprador** quem publica um anúncio de *"procura-se"* descrevendo o produto que deseja, com faixa de preço e um **raio de busca em quilômetros**. Os vendedores dentro desse raio encontram a demanda e respondem com ofertas, que o comprador compara, barganha e aceita.

| | |
|---|---|
| **Estado atual** | Requisitos, protótipo e arquitetura definidos; implementação a iniciar |
| **Stack** | Python · Django + DRF · PostgreSQL com PostGIS · Vite |
| **Dificuldade principal** | Algoritmo de *match* entre anúncios de "procura-se" e produtos dos vendedores |
| **Modelo de ganhos** | Links de afiliado, percentual sobre a venda ou assinatura |
| **Documentação** | [felipegf1.github.io/docs-grupo3-tppe](https://felipegf1.github.io/docs-grupo3-tppe/) |

### O MVP

- **Comprador** — cria um anúncio de *"procura-se"* com detalhes do produto, faixa de preço e raio de busca em KM.
- **Vendedor** — encontra demandas compatíveis dentro do seu raio, mantém seu catálogo e responde com ofertas.
- **Negociação** — palpite de preço, comparação de ofertas, contraproposta e chat até o acordo entre as partes.

### O projeto em números

| | |
|---|---|
| **Histórias de usuário** | 19, em 6 épicos |
| **Itens de backlog** | 19 (`QRO-01` a `QRO-19`), com 168 tarefas técnicas |
| **Estimativa total** | 111 pontos |
| **Planejamento** | 9 sprints em 3 releases |
| **Requisitos** | 40 funcionais e 23 não funcionais |
| **Stack** | Python · Django · PostgreSQL + PostGIS · Vite |

---

## Documentação

| Seção | O que contém |
|---|---|
| [Histórias de Usuário](https://felipegf1.github.io/docs-grupo3-tppe/historias-de-usuario/) | As 19 histórias do MVP, do cadastro à avaliação pós-venda, com critérios de aceite e regras de negócio |
| [Backlog do Produto](https://felipegf1.github.io/docs-grupo3-tppe/backlog/) | Os 19 itens `QRO-XX` com tarefas técnicas, estimativas, dependências, releases e roadmap por sprint |
| [Requisitos](https://felipegf1.github.io/docs-grupo3-tppe/produto/requisitos/) | 40 requisitos funcionais e 23 não funcionais rastreados até a história de origem |
| [Glossário](https://felipegf1.github.io/docs-grupo3-tppe/produto/glossario/) | A linguagem única do projeto: papéis, objetos do domínio, estados e termos a evitar |
| [Arquitetura](https://felipegf1.github.io/docs-grupo3-tppe/arquitetura/) | Backend em Python, PostGIS para o raio de busca, frontend em Vite, infraestrutura e roadmap técnico |
| [Identidade visual](https://felipegf1.github.io/docs-grupo3-tppe/interface/identidade-visual/) | Marca, paleta laranja abóbora, tipografia Space Grotesk / Inter e componentes |
| [Protótipo](https://felipegf1.github.io/docs-grupo3-tppe/interface/prototipo/) | A tela inicial elemento por elemento, ligada às histórias que cada parte implementa |
| [Equipe](https://felipegf1.github.io/docs-grupo3-tppe/equipe/) | Quem constrói o Quero. e como o trabalho é organizado |

### Épicos do backlog

| Épico | Itens | Pontos |
|---|---|---|
| 1 — Conta e acesso | `QRO-01` a `QRO-03` | 13 |
| 2 — Comprador: publicar a demanda | `QRO-04` `QRO-05` | 13 |
| 3 — Vendedor: encontrar e ofertar | `QRO-06` a `QRO-08` | 18 |
| 4 — Descoberta e recomendação | `QRO-09` | 13 |
| 5 — Negociação | `QRO-10` a `QRO-16` | 38 |
| 6 — Confiança e histórico | `QRO-17` a `QRO-19` | 16 |

---

## Contribuidores

| | Contribuidor | GitHub |
|---|---|---|
| <img src="https://github.com/felipegf1.png" width="48" alt="Avatar de felipegf1"> | **felipegf1** | [@felipegf1](https://github.com/felipegf1) |
| <img src="https://github.com/antonioscarvalho.png" width="48" alt="Avatar de antonioscarvalho"> | **Antonio Carvalho** | [@antonioscarvalho](https://github.com/antonioscarvalho) |
| <img src="https://github.com/maykonjuso.png" width="48" alt="Avatar de maykonjuso"> | **maykonjuso** | [@maykonjuso](https://github.com/maykonjuso) |

Projeto da disciplina de **Técnicas de Programação para Plataformas Emergentes (TPPE)** — Universidade de Brasília, Grupo 3.

---

## Rodando a documentação

Este repositório contém a documentação do Quero., construída com [MkDocs](https://www.mkdocs.org/) e [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/).

### Com Python

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
mkdocs serve
```

O site fica disponível em `http://127.0.0.1:8000/`.

### Com Docker

```bash
docker compose up docs
```

A documentação fica disponível em `http://localhost:8001`.

> O `docker-compose.yml` também descreve os serviços planejados da aplicação (`backend`, `frontend`, `db` e `adminer`). Eles ainda não fazem parte deste repositório: enquanto o código não existir, use `docker compose up docs`, que sobe apenas a documentação. Para o ambiente completo, copie as variáveis com `cp .env.example .env` antes de subir.
>
> **Atenção:** a imagem do banco declarada hoje é `postgres:16-alpine`, que **não** contém a extensão PostGIS exigida pelo raio de busca. A troca por `postgis/postgis:16-3.4` é o primeiro item da [Fase 0 do roadmap técnico](https://felipegf1.github.io/docs-grupo3-tppe/arquitetura/infraestrutura/#o-que-ainda-sera-realizado).

| Endereço | Serviço | Situação |
|---|---|---|
| http://localhost:8001 | Documentação | Disponível |
| http://localhost:3000 | Frontend | Planejado |
| http://localhost:8000 | API | Planejado |
| http://localhost:8080 | Adminer | Planejado |

---

## Como contribuir

| Item | Convenção |
|---|---|
| **Branch principal** | `main` — alterada apenas por *pull request* |
| **Branches de trabalho** | `branch-<nome>` para trabalho individual e `feat/<QRO-XX>` para itens do backlog |
| **Rastreabilidade** | Todo *pull request* referencia o item do backlog que atende, no formato `QRO-XX` |
| **Definition of Done** | Documentação afetada atualizada no mesmo *pull request* da entrega |

## Publicação

O site é publicado automaticamente no GitHub Pages a cada push na `main`, pelo workflow [`deploy-docs.yml`](.github/workflows/deploy-docs.yml):

**[felipegf1.github.io/docs-grupo3-tppe](https://felipegf1.github.io/docs-grupo3-tppe/)**
