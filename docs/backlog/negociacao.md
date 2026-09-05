# Épico 5 — Negociação

O maior épico do **Quero.**: sete itens que levam a demanda publicada até um acordo fechado com um único vendedor. É aqui que mora a barganha prevista no MVP.

| Item | História | MoSCoW | Pontos | Sprint |
| :--- | :--- | :---: | :---: | :---: |
| [QRO-10](#qro-10) | Palpitar preço no anúncio | C | 5 | 4 |
| [QRO-11](#qro-11) | Comparar ofertas recebidas | M | 5 | 5 |
| [QRO-12](#qro-12) | Ofertar um novo valor | M | 5 | 5 |
| [QRO-13](#qro-13) | Responder a uma contraproposta | M | 5 | 5 |
| [QRO-14](#qro-14) | Negociar por chat | M | 8 | 6 |
| [QRO-15](#qro-15) | Aceitar ou recusar uma oferta | M | 5 | 6 |
| [QRO-16](#qro-16) | Concluir a venda | M | 5 | 7 |
| | **Total do épico** | | **38** | |

---

## QRO-10 — Palpitar preço no anúncio { #qro-10 }

> **Como** vendedor, **eu quero** dar um palpite de preço em um anúncio de "procura-se", **para que** o comprador saiba quanto o produto costuma valer antes de receber ofertas formais.

**História:** [Palpitar preço no anúncio](../historias-de-usuario/palpitar-preco-no-anuncio.md) · **Prioridade:** Média · **Pontos:** 5 · **Sprint:** 4 · **Depende de:** `QRO-04`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-10.1 | Modelar `Palpite` com anúncio, vendedor, valor e data, sem vínculo com oferta | Modelagem | 2h |
| QRO-10.2 | Implementar `POST /anuncios/{id}/palpites` substituindo o palpite anterior do mesmo vendedor | Backend | 4h |
| QRO-10.3 | Calcular a faixa estimada com valor mínimo, médio e máximo | Backend | 3h |
| QRO-10.4 | Liberar a faixa ao comprador apenas a partir de três palpites, preservando o anonimato | Backend | 3h |
| QRO-10.5 | Bloquear palpite do próprio comprador no seu anúncio | Backend | 1h |
| QRO-10.6 | Comparar a faixa desejada do anúncio com a estimada e gerar o aviso de expectativa fora do mercado | Backend | 4h |
| QRO-10.7 | Construir o componente de palpite na visão do vendedor | Frontend | 4h |
| QRO-10.8 | Exibir ao comprador a faixa estimada e o aviso de desalinhamento com o mercado | Frontend | 4h |
| QRO-10.9 | Abrir o formulário de oferta pré-preenchido com o valor do palpite | Frontend | 2h |
| QRO-10.10 | Testar anonimato, limite de um palpite por vendedor e o corte de três palpites | QA | 3h |

**Critérios de pronto específicos**

- [ ] O comprador vê a faixa, nunca quem palpitou nem valores individuais.
- [ ] O palpite não cria oferta nem gera compromisso de venda.

---

## QRO-11 — Comparar ofertas recebidas { #qro-11 }

> **Como** comprador, **eu quero** ver e comparar todas as ofertas recebidas em um anúncio, **para que** eu escolha a proposta mais vantajosa antes de negociar.

**História:** [Comparar ofertas recebidas](../historias-de-usuario/comparar-ofertas-recebidas.md) · **Prioridade:** Alta · **Pontos:** 5 · **Sprint:** 5 · **Depende de:** `QRO-06`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-11.1 | Implementar `GET /anuncios/{id}/ofertas` restrito ao comprador dono do anúncio | Backend | 3h |
| QRO-11.2 | Compor cada oferta com preço, estado de conservação, distância e reputação do vendedor | Backend | 4h |
| QRO-11.3 | Impedir que um vendedor acesse o conteúdo ou o valor das ofertas concorrentes | Backend | 3h |
| QRO-11.4 | Sinalizar ofertas editadas e remover ofertas retiradas da listagem, mantendo-as no histórico | Backend | 3h |
| QRO-11.5 | Construir a listagem de ofertas com ordenação por preço, distância e reputação | Frontend | 6h |
| QRO-11.6 | Construir a visão de comparação lado a lado de duas ou mais ofertas selecionadas | Frontend | 8h |
| QRO-11.7 | Testar isolamento entre vendedores concorrentes e a sinalização de oferta editada | QA | 4h |

**Critérios de pronto específicos**

- [ ] Um vendedor autenticado nunca consegue ler outra oferta do mesmo anúncio, nem pela API.
- [ ] A comparação usa exatamente os mesmos atributos para todas as ofertas selecionadas.

---

## QRO-12 — Ofertar um novo valor em um anúncio { #qro-12 }

> **Como** comprador, **eu quero** propor um valor diferente do pedido pelo vendedor, **para que** eu barganhe até um preço que atenda aos dois lados.

**História:** [Ofertar um novo valor](../historias-de-usuario/ofertar-novo-valor.md) · **Prioridade:** Alta · **Pontos:** 5 · **Sprint:** 5 · **Depende de:** `QRO-11`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-12.1 | Modelar `Contraproposta` com oferta, autor, valor, justificativa, rodada, prazo e status | Modelagem | 3h |
| QRO-12.2 | Implementar `POST /ofertas/{id}/contrapropostas` exigindo oferta e anúncio ativos | Backend | 5h |
| QRO-12.3 | Manter apenas uma contraproposta em aberto por oferta, substituindo a anterior | Backend | 3h |
| QRO-12.4 | Implementar o limite configurável de rodadas compartilhado entre as duas partes | Backend | 4h |
| QRO-12.5 | Implementar a expiração por prazo devolvendo a oferta ao valor anterior | Backend | 4h |
| QRO-12.6 | Avisar quando o valor proposto for igual ou maior que o do vendedor e sugerir aceitar | Backend | 2h |
| QRO-12.7 | Construir o formulário de contraproposta com valor e justificativa opcional | Frontend | 5h |
| QRO-12.8 | Exibir a linha do tempo de valores e a rodada corrente | Frontend | 5h |
| QRO-12.9 | Testar limite de rodadas, substituição de contraproposta em aberto e expiração | QA | 4h |

**Critérios de pronto específicos**

- [ ] Atingido o limite de rodadas, restam apenas aceitar ou recusar a última oferta.
- [ ] A oferta passa a "em negociação" assim que a contraproposta é enviada.

---

## QRO-13 — Responder a uma contraproposta { #qro-13 }

> **Como** vendedor, **eu quero** aceitar, recusar ou responder com um novo valor à contraproposta do comprador, **para que** a negociação chegue a um preço acordado ou seja encerrada com clareza.

**História:** [Responder a uma contraproposta](../historias-de-usuario/responder-contraproposta.md) · **Prioridade:** Alta · **Pontos:** 5 · **Sprint:** 5 · **Depende de:** `QRO-12`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-13.1 | Implementar as três respostas — aceitar, recusar e contrapor — em uma única transição de estado | Backend | 6h |
| QRO-13.2 | Restringir a resposta ao vendedor autor da oferta | Backend | 2h |
| QRO-13.3 | Consumir uma rodada do limite compartilhado a cada resposta com novo valor | Backend | 3h |
| QRO-13.4 | Atualizar o preço da oferta para o valor acordado ao aceitar | Backend | 3h |
| QRO-13.5 | Devolver a oferta ao valor anterior ao recusar ou ao expirar o prazo | Backend | 3h |
| QRO-13.6 | Disparar notificação ao comprador em cada uma das respostas | Backend | 2h |
| QRO-13.7 | Construir a tela de resposta com valor, justificativa e histórico de valores | Frontend | 6h |
| QRO-13.8 | Testar resposta por vendedor não autor, expiração e aceite dentro do limite de rodadas | QA | 4h |

**Critérios de pronto específicos**

- [ ] Aceitar a contraproposta acorda o preço, mas não conclui a venda.
- [ ] O histórico de valores fica visível para as duas partes durante toda a negociação.

---

## QRO-14 — Negociar por chat { #qro-14 }

> **Como** comprador ou vendedor, **eu quero** conversar com a outra parte dentro da plataforma, **para que** eu esclareça dúvidas e combine detalhes sem sair para outro canal.

**História:** [Negociar por chat](../historias-de-usuario/negociar-por-chat.md) · **Prioridade:** Alta · **Pontos:** 8 · **Sprint:** 6 · **Depende de:** `QRO-06`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-14.1 | Modelar `Conversa` e `Mensagem` vinculadas a uma oferta específica | Modelagem | 4h |
| QRO-14.2 | Abrir a conversa automaticamente no envio da oferta e restringi-la às duas partes | Backend | 4h |
| QRO-14.3 | Implementar envio e leitura de mensagens, sem edição nem exclusão | Backend | 5h |
| QRO-14.4 | Implementar indicador de mensagem não lida e marcação de leitura | Backend | 3h |
| QRO-14.5 | Entregar mensagens por *polling* na primeira versão, com contrato preparado para WebSocket | Backend | 6h |
| QRO-14.6 | Tornar a conversa somente leitura ao encerrar o anúncio ou concluir a negociação | Backend | 3h |
| QRO-14.7 | Implementar denúncia de conversa e bloqueio de usuário | Backend | 5h |
| QRO-14.8 | Construir a interface de chat com histórico intercalado de mensagens e valores propostos | Frontend | 8h |
| QRO-14.9 | Exibir o sino do cabeçalho com o contador de conversas não lidas | Frontend | 3h |
| QRO-14.10 | Testar acesso de terceiros à conversa, somente leitura após conclusão e bloqueio | QA | 5h |

**Critérios de pronto específicos**

- [ ] O chat só existe depois que uma oferta foi enviada ao anúncio.
- [ ] Mensagens não podem ser editadas nem apagadas, preservando a evidência da negociação.

---

## QRO-15 — Aceitar ou recusar uma oferta { #qro-15 }

> **Como** comprador, **eu quero** aceitar a oferta escolhida e recusar as demais, **para que** a negociação siga com um único vendedor e as outras propostas sejam liberadas.

**História:** [Aceitar ou recusar uma oferta](../historias-de-usuario/aceitar-ou-recusar-oferta.md) · **Prioridade:** Alta · **Pontos:** 5 · **Sprint:** 6 · **Depende de:** `QRO-11`, `QRO-13`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-15.1 | Implementar o aceite registrando a oferta vigente e o valor final acordado | Backend | 5h |
| QRO-15.2 | Mover o anúncio para "em negociação" e recusar novas ofertas | Backend | 3h |
| QRO-15.3 | Recusar automaticamente as demais ofertas e notificar seus vendedores | Backend | 4h |
| QRO-15.4 | Implementar recusa individual com motivo opcional, visível só ao vendedor recusado | Backend | 3h |
| QRO-15.5 | Implementar o cancelamento da negociação, devolvendo o anúncio ao estado ativo | Backend | 4h |
| QRO-15.6 | Reservar o produto do catálogo vinculado à oferta aceita | Backend | 2h |
| QRO-15.7 | Construir as ações de aceitar e recusar com confirmação e aviso das consequências | Frontend | 5h |
| QRO-15.8 | Testar aceite concorrente de duas ofertas e o cancelamento com reabertura | QA | 4h |

**Critérios de pronto específicos**

- [ ] Só existe uma oferta aceita por anúncio de cada vez.
- [ ] A recusa é definitiva para aquela oferta: para voltar a concorrer, o vendedor envia uma nova.

---

## QRO-16 — Concluir a venda { #qro-16 }

> **Como** vendedor, **eu quero** registrar que a venda foi concluída, **para que** o anúncio seja encerrado, o produto saia do meu catálogo e as duas partes possam se avaliar.

**História:** [Concluir a venda](../historias-de-usuario/concluir-venda.md) · **Prioridade:** Alta · **Pontos:** 5 · **Sprint:** 7 · **Depende de:** `QRO-15`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-16.1 | Modelar `Negociacao` com anúncio, oferta aceita, valor final, status e datas | Modelagem | 3h |
| QRO-16.2 | Implementar a marcação de conclusão pelo vendedor e a solicitação de confirmação ao comprador | Backend | 5h |
| QRO-16.3 | Encerrar o anúncio e registrar a negociação como concluída após a confirmação | Backend | 3h |
| QRO-16.4 | Confirmar automaticamente a conclusão quando o comprador não responder no prazo | Backend | 4h |
| QRO-16.5 | Marcar o produto ofertado como vendido e removê-lo das listagens | Backend | 2h |
| QRO-16.6 | Reverter ao estado anterior quando o comprador negar a conclusão | Backend | 3h |
| QRO-16.7 | Disparar o convite de avaliação para as duas partes | Backend | 2h |
| QRO-16.8 | Construir as telas de conclusão, confirmação e recusa da conclusão | Frontend | 6h |
| QRO-16.9 | Testar a confirmação automática por prazo e a tentativa de reabrir negociação concluída | QA | 4h |

**Critérios de pronto específicos**

- [ ] Uma negociação concluída não pode ser reaberta em nenhuma circunstância.
- [ ] A conclusão exige confirmação das duas partes ou o vencimento do prazo.
