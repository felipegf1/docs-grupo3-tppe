# Responder a uma contraproposta

!!! abstract "QRO-13 · Épico 5 — Negociação"
    **Ator:** Vendedor &nbsp;·&nbsp; **Prioridade:** Alta &nbsp;·&nbsp; **Estimativa:** 5 pontos &nbsp;·&nbsp; **Sprint:** 5 &nbsp;·&nbsp; **Depende de:** QRO-12

    [:material-format-list-checks: Tarefas desta história no backlog](../backlog/negociacao.md#qro-13)

## Descrição

**Como** vendedor,
**Eu quero** aceitar, recusar ou responder com um novo valor à contraproposta do comprador,
**Para que** a negociação chegue a um preço acordado ou seja encerrada com clareza.

## Contexto

É o outro lado de [Ofertar um novo valor em um anúncio](ofertar-novo-valor.md). Sem esta história a barganha fica unilateral e sem desfecho.

## Critérios de Aceite

- [ ] **Dado** que recebi uma contraproposta, **quando** acesso a oferta, **então** vejo o valor proposto, a justificativa e o histórico de valores da negociação.
- [ ] **Dado** que recebi uma contraproposta, **quando** a aceito, **então** o valor acordado vira o preço da oferta e o comprador é notificado.
- [ ] **Dado** que recebi uma contraproposta, **quando** a recuso, **então** a oferta volta ao valor anterior e o comprador é notificado.
- [ ] **Dado** que recebi uma contraproposta, **quando** respondo com um novo valor, **então** uma nova rodada é registrada e o comprador é notificado.
- [ ] **Dado** que não respondo no prazo, **então** a contraproposta expira e a oferta retorna ao valor anterior.

## Regras de Negócio

- Só o vendedor autor da oferta responde à contraproposta.
- Cada resposta consome uma rodada do limite compartilhado com o comprador.
- O histórico de valores fica visível para as duas partes durante a negociação.
- Aceitar a contraproposta não conclui a venda, tratada em [Concluir a venda](concluir-venda.md).

## Fora de Escopo (nesta história)

- Contraproposta automática por regra de preço mínimo.
- Conversa livre entre as partes.
- Cobrança de comissão sobre o valor acordado.

## Prioridade

Alta. Sem ela a barganha não tem desfecho.
