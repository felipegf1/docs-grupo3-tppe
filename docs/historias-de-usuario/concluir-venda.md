# Concluir a venda

## Descrição

**Como** vendedor,
**Eu quero** registrar que a venda foi concluída,
**Para que** o anúncio seja encerrado, o produto saia do meu catálogo e as duas partes possam se avaliar.

## Contexto

Último passo do fluxo do MVP. Depois que o comprador aceita a oferta e as partes combinam entrega e pagamento por fora, alguém precisa confirmar o desfecho na plataforma.

## Critérios de Aceite

- [ ] **Dado** uma oferta aceita, **quando** marco a venda como concluída, **então** o comprador recebe uma solicitação de confirmação.
- [ ] **Dado** que o comprador confirma, **então** o anúncio é encerrado e a negociação registrada como concluída.
- [ ] **Dado** que a venda foi concluída, **então** as duas partes são convidadas a avaliar uma à outra.
- [ ] **Dado** que a venda foi concluída, **então** o produto ofertado sai como disponível do meu catálogo.
- [ ] **Dado** que o comprador nega a conclusão, **então** a negociação volta ao estado anterior e o anúncio segue ativo.

## Regras de Negócio

- Só uma oferta aceita pode ser marcada como concluída.
- A conclusão exige confirmação das duas partes.
- Se o comprador não responder dentro do prazo, a conclusão é confirmada automaticamente.
- Uma negociação concluída não pode ser reaberta.

## Fora de Escopo (nesta história)

- Processamento de pagamento e repasse.
- Cálculo e cobrança de comissão.
- Emissão de nota ou recibo.

## Prioridade

Alta. Fecha o ciclo entre anúncio, oferta e reputação.
