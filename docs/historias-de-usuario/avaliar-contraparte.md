# Avaliar a contraparte

!!! abstract "QRO-18 · Épico 6 — Confiança e histórico"
    **Ator:** Comprador e Vendedor &nbsp;·&nbsp; **Prioridade:** Média &nbsp;·&nbsp; **Estimativa:** 5 pontos &nbsp;·&nbsp; **Sprint:** 8 &nbsp;·&nbsp; **Depende de:** QRO-16

    [:material-format-list-checks: Tarefas desta história no backlog](../backlog/confianca-e-historico.md#qro-18)

## Descrição

**Como** comprador ou vendedor,
**Eu quero** avaliar a outra parte depois da negociação concluída,
**Para que** a plataforma tenha reputação confiável e os próximos negócios sejam mais seguros.

## Contexto

Negociação entre desconhecidos, com pagamento e entrega fora da plataforma, depende de confiança. A reputação gerada aqui aparece na comparação de ofertas, nas recomendações e na loja do vendedor.

## Critérios de Aceite

- [ ] **Dado** uma negociação concluída, **quando** acesso o histórico, **então** posso avaliar a outra parte com nota e comentário.
- [ ] **Dado** que avaliei, **então** a nota entra no cálculo da reputação da outra parte.
- [ ] **Dado** que as duas partes avaliaram ou o prazo acabou, **então** as avaliações são publicadas ao mesmo tempo.
- [ ] **Dado** que recebi uma avaliação, **quando** quero me posicionar, **então** posso responder publicamente uma única vez.
- [ ] **Dado** um comentário ofensivo, **quando** o denuncio, **então** ele é enviado para análise.

## Regras de Negócio

- Só é possível avaliar após negociação concluída, uma vez por negociação e por parte.
- As avaliações ficam ocultas até as duas partes avaliarem ou o prazo expirar, evitando retaliação.
- A nota é de 1 a 5 e o comentário é opcional.
- Avaliações não podem ser editadas nem apagadas pelo autor.

## Fora de Escopo (nesta história)

- Selo de vendedor verificado.
- Recurso ou disputa formal sobre avaliação.
- Peso diferente por valor da negociação.

## Prioridade

Média. Essencial para a confiança, mas posterior ao fluxo de venda.
