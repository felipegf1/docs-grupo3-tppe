# Épico 6 — Confiança e histórico

Negociação entre desconhecidos, com pagamento e entrega fora da plataforma, depende de reputação e de rastro. Este épico é o que torna o **Quero.** utilizável mais de uma vez pelo mesmo usuário.

| Item | História | Pontos | Sprint |
| :--- | :--- | :---: | :---: |
| [QRO-17](#qro-17) | Receber notificações | 8 | 8 |
| [QRO-18](#qro-18) | Avaliar a contraparte | 5 | 8 |
| [QRO-19](#qro-19) | Histórico de negociações | 3 | 8 |
| | **Total do épico** | **16** | |

---

## QRO-17 — Receber notificações { #qro-17 }

> **Como** usuário, **eu quero** ser avisado dos eventos das minhas negociações, **para que** eu responda rápido sem precisar abrir a plataforma o tempo todo.

**História:** [Receber notificações](../historias-de-usuario/receber-notificacoes.md) · **Pontos:** 8 · **Sprint:** 8 · **Depende de:** `QRO-04`, `QRO-06`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-17.1 | Modelar `Notificacao` e `PreferenciaDeNotificacao` por usuário, tipo e canal | Modelagem | 4h |
| QRO-17.2 | Definir o catálogo de eventos notificáveis a partir de todas as outras histórias | Modelagem | 3h |
| QRO-17.3 | Implementar o barramento de eventos que transforma ações de domínio em notificações | Backend | 8h |
| QRO-17.4 | Notificar o vendedor quando um anúncio compatível é publicado no seu raio | Backend | 5h |
| QRO-17.5 | Agrupar notificações do mesmo tipo em curto intervalo | Backend | 4h |
| QRO-17.6 | Implementar lembrete antes do vencimento de contraproposta | Backend | 4h |
| QRO-17.7 | Configurar o canal de e-mail respeitando as preferências do usuário | Infra | 5h |
| QRO-17.8 | Construir a central de notificações e o sino com contador no cabeçalho | Frontend | 6h |
| QRO-17.9 | Construir a tela de preferências por tipo e canal | Frontend | 5h |
| QRO-17.10 | Testar agrupamento, opt-out e a exceção dos avisos de segurança da conta | QA | 5h |

**Critérios de pronto específicos**

- [ ] Todo evento gera notificação no aplicativo; e-mail segue a preferência do usuário.
- [ ] O usuário pode desativar tudo, menos avisos de segurança da conta.

---

## QRO-18 — Avaliar a contraparte { #qro-18 }

> **Como** comprador ou vendedor, **eu quero** avaliar a outra parte depois da negociação concluída, **para que** a plataforma tenha reputação confiável e os próximos negócios sejam mais seguros.

**História:** [Avaliar a contraparte](../historias-de-usuario/avaliar-contraparte.md) · **Pontos:** 5 · **Sprint:** 8 · **Depende de:** `QRO-16`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-18.1 | Modelar `Avaliacao` com negociação, autor, avaliado, nota de 1 a 5, comentário e resposta | Modelagem | 3h |
| QRO-18.2 | Permitir uma única avaliação por parte em cada negociação concluída | Backend | 3h |
| QRO-18.3 | Implementar a publicação simultânea das duas avaliações ou por vencimento do prazo | Backend | 5h |
| QRO-18.4 | Calcular a reputação agregada exibida nos cards, ofertas e recomendações | Backend | 4h |
| QRO-18.5 | Implementar resposta pública única do avaliado | Backend | 3h |
| QRO-18.6 | Implementar denúncia de comentário ofensivo e fila de análise | Backend | 4h |
| QRO-18.7 | Impedir edição e exclusão de avaliação pelo autor | Backend | 1h |
| QRO-18.8 | Construir o formulário de avaliação e a vitrine de reputação do perfil | Frontend | 6h |
| QRO-18.9 | Testar a retaliação: nenhuma avaliação pode vazar antes da publicação simultânea | QA | 4h |

**Critérios de pronto específicos**

- [ ] As avaliações ficam ocultas até as duas partes avaliarem ou o prazo expirar.
- [ ] A nota agregada usada nos cards vem do mesmo cálculo em toda a plataforma.

---

## QRO-19 — Consultar meu histórico de negociações { #qro-19 }

> **Como** usuário, **eu quero** consultar as negociações que já tive na plataforma, **para que** eu acompanhe o que comprei, o que vendi e com quem negociei.

**História:** [Histórico de negociações](../historias-de-usuario/historico-de-negociacoes.md) · **Pontos:** 3 · **Sprint:** 8 · **Depende de:** `QRO-16`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-19.1 | Implementar `GET /historico` restrito ao próprio usuário, somente leitura | Backend | 4h |
| QRO-19.2 | Implementar filtros por papel (compras ou vendas) e por status | Backend | 3h |
| QRO-19.3 | Compor o detalhe com valores propostos e mensagens trocadas | Backend | 4h |
| QRO-19.4 | Excluir do histórico as negociações ainda em andamento | Backend | 1h |
| QRO-19.5 | Construir a listagem com data, contraparte, produto, valor final e status | Frontend | 5h |
| QRO-19.6 | Construir o estado vazio explicando como começar a negociar | Frontend | 2h |
| QRO-19.7 | Testar o isolamento entre usuários e a imutabilidade do histórico | QA | 3h |

**Critérios de pronto específicos**

- [ ] Cada usuário vê apenas o próprio histórico, inclusive pela API.
- [ ] Nenhuma ação da tela altera dados da negociação.
