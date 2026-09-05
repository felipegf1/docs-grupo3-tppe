# Consultar meu histórico de negociações

!!! abstract "QRO-19 · Épico 6 — Confiança e histórico"
    **Ator:** Usuário &nbsp;·&nbsp; **Prioridade:** Baixa &nbsp;·&nbsp; **Estimativa:** 3 pontos &nbsp;·&nbsp; **Sprint:** 8 &nbsp;·&nbsp; **Depende de:** QRO-16

    [:material-format-list-checks: Tarefas desta história no backlog](../backlog/confianca-e-historico.md#qro-19)

## Descrição

**Como** usuário,
**Eu quero** consultar as negociações que já tive na plataforma,
**Para que** eu acompanhe o que comprei, o que vendi e com quem negociei.

## Contexto

Depois que um anúncio é encerrado, ele sai das listas ativas. O histórico é a única forma de recuperar o que foi negociado, com quem e por quanto.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado, **quando** acesso meu histórico, **então** vejo minhas negociações com data, contraparte, produto, valor final e status.
- [ ] **Dado** o histórico, **quando** filtro por compras ou vendas, **então** vejo apenas as negociações daquele papel.
- [ ] **Dado** o histórico, **quando** filtro por status, **então** vejo apenas as concluídas ou apenas as canceladas.
- [ ] **Dado** uma negociação no histórico, **quando** a abro, **então** vejo os valores propostos e as mensagens trocadas.
- [ ] **Dado** que nunca negociei, **então** a plataforma exibe um estado vazio explicando como começar.

## Regras de Negócio

- Cada usuário vê apenas o próprio histórico.
- Negociações concluídas e canceladas permanecem no histórico.
- O histórico é somente leitura e não permite alterar nada da negociação.
- Negociações em andamento não aparecem aqui, e sim nas listas ativas.

## Fora de Escopo (nesta história)

- Exportar o histórico para planilha ou PDF.
- Relatórios e gráficos de desempenho.
- Recibo ou comprovante da venda.

## Prioridade

Baixa. Somente leitura sobre dados que já existem.
