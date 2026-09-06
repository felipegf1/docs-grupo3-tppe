# Épico 3 — Vendedor: encontrar e ofertar

O outro lado do modelo reverso: o vendedor localiza demandas compatíveis com o que tem e responde com uma oferta.

| Item | História | Pontos | Sprint |
| :--- | :--- | :---: | :---: |
| [QRO-06](#qro-06) | Ofertar produto em anúncio | 8 | 3 |
| [QRO-07](#qro-07) | Buscar e filtrar anúncios | 5 | 4 |
| [QRO-08](#qro-08) | Cadastrar produtos na minha loja | 5 | 4 |
| | **Total do épico** | **18** | |

---

## QRO-06 — Ofertar produto em um anúncio { #qro-06 }

> **Como** vendedor, **eu quero** encontrar anúncios de "procura-se" compatíveis com o que tenho disponível e responder com uma oferta, **para que** eu venda meu produto usado ou seminovo direto para quem já está procurando por ele.

**História:** [Ofertar produto em anúncio](../historias-de-usuario/ofertar-produto-em-anuncio.md) · **Pontos:** 8 · **Sprint:** 3 · **Depende de:** `QRO-04`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-06.1 | Modelar `Oferta` com anúncio, vendedor, descrição, estado de conservação, preço, status e histórico de valores | Modelagem | 4h |
| QRO-06.2 | Implementar `POST /anuncios/{id}/ofertas` validando anúncio ativo e campos mínimos | Backend | 5h |
| QRO-06.3 | Garantir no máximo uma oferta ativa por vendedor em cada anúncio | Backend | 3h |
| QRO-06.4 | Implementar edição e retirada de oferta enquanto ela não for aceita | Backend | 4h |
| QRO-06.5 | Implementar `GET /anuncios` para o vendedor, já filtrado pelo raio que contém sua localização | Backend | 4h |
| QRO-06.6 | Construir o feed do vendedor com os cards de demanda e o botão **Ofertar** | Frontend | 6h |
| QRO-06.7 | Construir o formulário de oferta com descrição, estado de conservação, preço e fotos | Frontend | 6h |
| QRO-06.8 | Construir a tela "Minhas ofertas" com status de cada proposta enviada | Frontend | 5h |
| QRO-06.9 | Testar oferta em anúncio pausado, segunda oferta do mesmo vendedor e edição após aceite | QA | 5h |

**Critérios de pronto específicos**

- [ ] Descrição, estado de conservação e preço são obrigatórios para enviar.
- [ ] Uma oferta aceita não pode mais ser editada nem retirada.
- [ ] O contador de ofertas do card do comprador reflete o envio em tempo real.

---

## QRO-07 — Buscar e filtrar anúncios { #qro-07 }

> **Como** vendedor, **eu quero** buscar e filtrar os anúncios de "procura-se" da minha região, **para que** eu encontre rápido as demandas que consigo atender.

**História:** [Buscar e filtrar anúncios](../historias-de-usuario/buscar-e-filtrar-anuncios.md) · **Pontos:** 5 · **Sprint:** 4 · **Depende de:** `QRO-04`, `QRO-06`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-07.1 | Implementar busca textual por título e descrição com índice apropriado | Backend | 5h |
| QRO-07.2 | Implementar filtros combináveis de categoria, faixa de preço e distância máxima | Backend | 5h |
| QRO-07.3 | Implementar ordenação por distância, data de publicação e faixa de preço | Backend | 3h |
| QRO-07.4 | Implementar paginação para o botão **Carregar mais anúncios** | Backend | 3h |
| QRO-07.5 | Modelar e implementar `BuscaSalva` por usuário | Backend | 4h |
| QRO-07.6 | Construir a barra de busca global do cabeçalho por produto, categoria ou cidade | Frontend | 5h |
| QRO-07.7 | Construir os chips de categoria com contadores e o alternador Todos / Procurando / Vendendo | Frontend | 5h |
| QRO-07.8 | Construir o estado vazio que informa a ausência de resultados e sugere afrouxar os critérios | Frontend | 2h |
| QRO-07.9 | Manter os filtros aplicados durante a sessão, inclusive ao voltar do detalhe | Frontend | 3h |
| QRO-07.10 | Testar combinações de filtros, ordenações e resultado vazio | QA | 4h |

**Critérios de pronto específicos**

- [ ] A busca nunca retorna anúncio encerrado, pausado ou em negociação.
- [ ] Os contadores dos chips refletem o conjunto filtrado corrente.

---

## QRO-08 — Cadastrar produtos na minha loja { #qro-08 }

> **Como** vendedor, **eu quero** cadastrar os produtos que tenho disponíveis, **para que** eu oferte com poucos cliques e apareça nas sugestões de match.

**História:** [Cadastrar produtos na minha loja](../historias-de-usuario/cadastrar-produtos-na-loja.md) · **Pontos:** 5 · **Sprint:** 4 · **Depende de:** `QRO-02`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-08.1 | Modelar `Produto` com nome, categoria, descrição, estado de conservação, preço, fotos e status | Modelagem | 3h |
| QRO-08.2 | Implementar CRUD de produtos restrito ao vendedor dono do catálogo | Backend | 5h |
| QRO-08.3 | Congelar os dados do produto no momento do envio da oferta, preservando edições futuras | Backend | 4h |
| QRO-08.4 | Implementar os status disponível, reservado e vendido, com bloqueio de produto reservado | Backend | 4h |
| QRO-08.5 | Implementar upload de fotos com limite de quantidade e tamanho | Infra | 5h |
| QRO-08.6 | Construir a tela de catálogo com a listagem dos produtos e seus status | Frontend | 6h |
| QRO-08.7 | Preencher automaticamente o formulário de oferta ao selecionar um produto do catálogo | Frontend | 4h |
| QRO-08.8 | Construir o card "Vendendo" do feed com imagem, badge de conservação, preço e contador de visualizações | Frontend | 5h |
| QRO-08.9 | Testar edição de produto já ofertado, produto reservado e limites de upload | QA | 4h |

**Critérios de pronto específicos**

- [ ] Editar ou remover um produto não altera as ofertas já enviadas com ele.
- [ ] Produto vendido some das sugestões e do feed público.
