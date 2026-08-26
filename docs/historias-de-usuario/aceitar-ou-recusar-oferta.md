# Aceitar ou recusar uma oferta

## Descrição

**Como** comprador,
**Eu quero** aceitar a oferta escolhida e recusar as demais,
**Para que** a negociação siga com um único vendedor e as outras propostas sejam liberadas.

## Contexto

Fecha o lado do comprador no fluxo de [comparação de ofertas](comparar-ofertas-recebidas.md) e da barganha. É o ponto em que o anúncio deixa de receber propostas e passa a uma negociação única.

## Critérios de Aceite

- [ ] **Dado** um anúncio meu com ofertas, **quando** aceito uma delas, **então** ela vira a oferta vigente e o vendedor é notificado.
- [ ] **Dado** que aceitei uma oferta, **então** o anúncio é marcado como "em negociação" e não recebe novas ofertas.
- [ ] **Dado** que aceitei uma oferta, **então** as demais ofertas são recusadas automaticamente e seus vendedores são notificados.
- [ ] **Dado** uma oferta que não me interessa, **quando** a recuso, **então** o vendedor é notificado e ela sai da lista de ofertas ativas.
- [ ] **Dado** que a negociação com o vendedor aceito não avança, **quando** a cancelo, **então** o anúncio volta a aceitar ofertas.

## Regras de Negócio

- Só é possível aceitar uma oferta por anúncio de cada vez.
- Aceitar registra o valor final acordado, que passa a ser o valor de referência da venda.
- Recusar é definitivo para aquela oferta: o vendedor precisa enviar uma nova se quiser voltar a concorrer.
- O motivo da recusa é opcional e só é exibido ao vendedor recusado.

## Fora de Escopo (nesta história)

- Pagamento dentro da plataforma.
- Entrega e logística.
- Registro da venda concluída, tratado em [Concluir a venda](concluir-venda.md).

## Prioridade

Alta. É o desfecho do fluxo principal do comprador.
