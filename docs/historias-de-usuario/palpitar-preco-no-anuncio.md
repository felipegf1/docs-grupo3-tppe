# Palpitar preço no anúncio

!!! abstract "QRO-10 · Épico 5 — Negociação"
    **Ator:** Vendedor &nbsp;·&nbsp; **Prioridade:** Média &nbsp;·&nbsp; **Estimativa:** 5 pontos &nbsp;·&nbsp; **Sprint:** 4 &nbsp;·&nbsp; **Depende de:** QRO-04

    [:material-format-list-checks: Tarefas desta história no backlog](../backlog/negociacao.md#qro-10)

## Descrição

**Como** vendedor,
**Eu quero** dar um palpite de preço em um anúncio de "procura-se",
**Para que** o comprador saiba quanto o produto costuma valer antes de receber ofertas formais.

## Contexto

O comprador publica o anúncio com uma faixa de preço desejada, mas nem sempre sabe quanto o produto vale de fato no mercado de usados. O palpite é um sinal rápido e sem compromisso: o vendedor diz por quanto aquilo costuma sair, sem precisar montar uma oferta completa.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado como vendedor e vejo um anúncio, **quando** envio um palpite de preço, **então** ele é registrado sem criar uma oferta.
- [ ] **Dado** um anúncio com palpites, **quando** o comprador o acessa, **então** vê a faixa estimada pelo mercado com valor mínimo, médio e máximo.
- [ ] **Dado** que dei um palpite, **quando** decido ofertar de verdade, **então** o formulário de oferta abre com o valor do palpite preenchido.
- [ ] **Dado** que a faixa de preço do anúncio está muito abaixo dos palpites, **então** o comprador é avisado de que a expectativa está fora do mercado.
- [ ] **Dado** que já palpitei em um anúncio, **quando** palpito de novo, **então** o valor anterior é substituído.

## Regras de Negócio

- O palpite não é uma oferta e não gera nenhum compromisso de venda.
- Cada vendedor tem no máximo um palpite por anúncio.
- A faixa estimada só é exibida ao comprador a partir de três palpites, para não expor o valor de um vendedor específico.
- Os palpites são anônimos para o comprador: ele vê a faixa, não quem palpitou.
- O comprador não palpita no próprio anúncio.

## Fora de Escopo (nesta história)

- Estimativa automática de preço a partir de vendas anteriores.
- Histórico de variação de preço por categoria.
- Palpite em produtos da loja do vendedor.

## Prioridade

Média. Ajuda o comprador a calibrar a expectativa e aumenta a chance de a negociação avançar.
