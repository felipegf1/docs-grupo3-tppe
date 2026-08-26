# Ofertar um novo valor em um anúncio

## Descrição

**Como** comprador,
**Eu quero** propor um valor diferente do pedido pelo vendedor,
**Para que** eu barganhe até um preço que atenda aos dois lados.

## Contexto

Implementa o item do MVP "o app permite barganhar entre comprador e vendedor". Depois de [comparar as ofertas](comparar-ofertas-recebidas.md), o comprador responde com uma contraproposta.

## Critérios de Aceite

- [ ] **Dado** que recebi uma oferta, **quando** envio uma contraproposta com um novo valor, **então** o vendedor é notificado e a oferta passa a "em negociação".
- [ ] **Dado** que envio a contraproposta, **quando** incluo uma justificativa, **então** ela é exibida ao vendedor junto do novo valor.
- [ ] **Dado** que o vendedor recusou minha contraproposta, **então** posso enviar um novo valor até o limite de rodadas.
- [ ] **Dado** que atingi o limite de rodadas, **então** só restam as opções de aceitar ou recusar a última oferta.
- [ ] **Dado** que informo um valor igual ou maior que o preço do vendedor, **então** o sistema avisa que não é uma barganha e sugere aceitar a oferta.

## Regras de Negócio

- A contraproposta exige oferta ativa em anúncio ativo.
- Existe apenas uma contraproposta em aberto por oferta: enviar outra substitui a anterior.
- O número de rodadas de negociação é limitado e configurável.
- A contraproposta expira se não for respondida no prazo, devolvendo a oferta ao valor anterior.

## Fora de Escopo (nesta história)

- Conversa livre entre as partes, tratada em [Negociar por chat](negociar-por-chat.md).
- Resposta do vendedor, tratada em [Responder a uma contraproposta](responder-contraproposta.md).
- Pagamento e formalização da venda.

## Prioridade

Alta. É a barganha prevista no MVP.
