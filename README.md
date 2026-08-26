# docs-grupo3-tppe

Documentação do projeto da disciplina de **Técnicas de Programação para Plataformas Emergentes (TPPE)**, Grupo 3.

Construída com [MkDocs](https://www.mkdocs.org/) e [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/).

## Sobre o projeto

**Plataforma para E-Commerce**, uma "OLX reversa" para produtos usados e seminovos.

Em vez do vendedor anunciar o que tem à venda, é o **comprador** quem publica um anúncio de "procura-se" descrevendo o que deseja, com raio de busca em KM. Os vendedores encontram essa demanda e oferecem seus produtos.

| | |
|---|---|
| **Estado atual** | Ideia |
| **Dificuldade principal** | Algoritmo para dar "match" entre anúncios e produtos |
| **Modelo de ganhos** | Links de afiliado, percentual sobre a venda ou assinatura |

### MVP

- **Vendedor**: procura usuários para ofertar seu produto e pode anunciá-lo em sua loja.
- **Comprador**: cria um anúncio de "procura-se" com detalhes do produto e um raio de busca em KM.
- **App**: permite barganhar entre comprador e vendedor.

## Conteúdo da documentação

- [Histórias de Usuário](docs/historias-de-usuario/): as 20 histórias do MVP, do cadastro à avaliação pós-venda.
- [Ambiente com Docker](docs/ambiente/docker.md): como subir o projeto com Docker Compose.

## Rodando com Docker

```bash
cp .env.example .env
docker compose up -d --build
```

| Endereço | O que é |
|---|---|
| http://localhost:3000 | Frontend |
| http://localhost:8000 | API |
| http://localhost:8080 | Adminer |
| http://localhost:8001 | Documentação |

## Rodando a documentação sem Docker

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
mkdocs serve
```

O site fica disponível em `http://127.0.0.1:8000/`.

## Publicando

O site é publicado via GitHub Pages a partir deste repositório:
[felipegf1.github.io/docs-grupo3-tppe](https://felipegf1.github.io/docs-grupo3-tppe/)
