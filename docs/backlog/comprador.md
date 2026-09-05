# Épico 2 — Comprador: publicar a demanda

O lado que inverte o marketplace. Aqui o comprador publica o que procura e passa a ser encontrado, em vez de procurar.

| Item | História | MoSCoW | Pontos | Sprint |
| :--- | :--- | :---: | :---: | :---: |
| [QRO-04](#qro-04) | Criar anúncio de "procura-se" | M | 8 | 2 |
| [QRO-05](#qro-05) | Gerenciar meus anúncios | M | 5 | 3 |
| | **Total do épico** | | **13** | |

---

## QRO-04 — Criar anúncio de "procura-se" { #qro-04 }

> **Como** comprador, **eu quero** criar um anúncio de "procura-se" descrevendo o produto que estou buscando, **para que** vendedores da minha região sejam notificados e possam me ofertar o produto.

**História:** [Criar anúncio de "procura-se"](../historias-de-usuario/criar-anuncio-procura-se.md) · **Prioridade:** Alta · **Pontos:** 8 · **Sprint:** 2 · **Depende de:** `QRO-02`, `QRO-03`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-04.1 | Modelar `Anuncio` com título, categoria, descrição, faixa de preço, raio em KM, status e autor | Modelagem | 4h |
| QRO-04.2 | Modelar `Categoria` com a taxonomia do protótipo: Eletrônicos, Veículos, Informática, Games, Esportes, Casa & Jardim, Instrumentos e Outros | Modelagem | 2h |
| QRO-04.3 | Implementar `POST /anuncios` com validação de campos obrigatórios e da faixa de preço | Backend | 5h |
| QRO-04.4 | Aplicar raio padrão pré-definido quando o comprador não informar um valor | Backend | 2h |
| QRO-04.5 | Implementar consulta geoespacial que retorna anúncios cujo raio contém a posição do vendedor | Backend | 8h |
| QRO-04.6 | Criar índice geoespacial e pré-filtro por cidade para sustentar a consulta em volume | Infra | 4h |
| QRO-04.7 | Construir o formulário de publicação acionado pelo botão **+ Anunciar** e pelo botão flutuante | Frontend | 8h |
| QRO-04.8 | Implementar o seletor de raio em KM com pré-visualização da área de alcance | Frontend | 5h |
| QRO-04.9 | Construir o card "Procurando" do feed com badge, categoria, tempo, orçamento, cidade, distância, reputação do autor e contador de ofertas | Frontend | 6h |
| QRO-04.10 | Testar publicação sem raio, faixa de preço invertida, campos obrigatórios e visibilidade por distância | QA | 5h |

**Critérios de pronto específicos**

- [ ] O raio é sempre expresso e exibido em quilômetros.
- [ ] Um vendedor fora do raio nunca vê o anúncio em nenhuma listagem.
- [ ] O anúncio permanece ativo até ser encerrado, concluído ou expirado.

---

## QRO-05 — Gerenciar meus anúncios { #qro-05 }

> **Como** comprador, **eu quero** ver, editar, pausar, reativar e encerrar os anúncios que publiquei, **para que** fiquem visíveis apenas as demandas que ainda tenho.

**História:** [Gerenciar meus anúncios](../historias-de-usuario/gerenciar-meus-anuncios.md) · **Prioridade:** Alta · **Pontos:** 5 · **Sprint:** 3 · **Depende de:** `QRO-04`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-05.1 | Implementar a máquina de estados do anúncio: ativo, pausado, em negociação e encerrado | Modelagem | 4h |
| QRO-05.2 | Implementar `GET /anuncios/meus` com status e contagem de ofertas recebidas | Backend | 3h |
| QRO-05.3 | Implementar `PATCH /anuncios/{id}` bloqueando alterações em anúncio encerrado | Backend | 4h |
| QRO-05.4 | Implementar pausa e reativação preservando as ofertas já recebidas | Backend | 3h |
| QRO-05.5 | Impedir encerramento de anúncio com negociação em andamento | Backend | 2h |
| QRO-05.6 | Notificar vendedores com oferta ativa quando o anúncio for editado | Backend | 3h |
| QRO-05.7 | Construir a tela "Meus anúncios" com filtro por status e ações de cada card | Frontend | 6h |
| QRO-05.8 | Testar as transições de estado, inclusive as proibidas | QA | 4h |

**Critérios de pronto específicos**

- [ ] Anúncio pausado some do feed público e recusa novas ofertas, mas mantém as recebidas acessíveis.
- [ ] Encerramento é definitivo e não oferece ação de reativar na interface.
