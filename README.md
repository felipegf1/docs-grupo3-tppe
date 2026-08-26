# docs-grupo3-tppe

Documentação do projeto da disciplina de **Técnicas de Programação para Plataformas Emergentes (TPPE)** — Grupo 3.

Construída com [MkDocs](https://www.mkdocs.org/) + [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/).

## Sobre o projeto

**Plataforma para E-Commerce** — uma "OLX reversa" para produtos usados e seminovos.

Em vez do vendedor anunciar o que tem à venda, é o **comprador** quem publica um anúncio de "procura-se" descrevendo o que deseja (com raio de busca em KM), e vendedores encontram essa demanda e oferecem seus produtos.

| | |
|---|---|
| **Estado atual** | Ideia |
| **Dificuldade principal** | Algoritmo para dar "match" entre anúncios e produtos |
| **Modelo de ganhos** | Links de afiliado, percentual sobre a venda ou assinatura |

### MVP

- **Vendedor** — procura usuários para ofertar seu produto e pode anunciá-lo em sua loja.
- **Comprador** — cria um anúncio de "procura-se" com detalhes do produto e um raio de busca em KM.
- **App** — permite barganhar entre comprador e vendedor.

## Conteúdo da documentação

- [Histórias de Usuário](docs/historias-de-usuario/) — histórias que descrevem o fluxo principal do MVP, começando pelo núcleo da inversão do modelo: criar um "procura-se" e ofertar um produto.

## Rodando localmente

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
mkdocs serve
```

O site ficará disponível em `http://127.0.0.1:8000/`.

## Publicando

O site é publicado via GitHub Pages a partir deste repositório:
[felipegf1.github.io/docs-grupo3-tppe](https://felipegf1.github.io/docs-grupo3-tppe/)
