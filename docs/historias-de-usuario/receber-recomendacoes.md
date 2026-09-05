# Receber recomendações

!!! abstract "QRO-09 · Épico 4 — Descoberta e recomendação"
    **Ator:** Comprador &nbsp;·&nbsp; **Prioridade:** Média &nbsp;·&nbsp; **Estimativa:** 13 pontos &nbsp;·&nbsp; **Sprint:** 9 &nbsp;·&nbsp; **Depende de:** QRO-04, QRO-08

    [:material-format-list-checks: Tarefas desta história no backlog](../backlog/descoberta.md#qro-09)

## Descrição

**Como** comprador,
**Eu quero** receber recomendações de vendedores e produtos compatíveis com o que procuro,
**Para que** eu encontre boas opções sem depender só das ofertas que chegam ao meu anúncio.

## Contexto

Aplica o algoritmo de match, apontado no projeto como a maior dificuldade técnica, no sentido comprador. Enquanto o anúncio espera ofertas, a plataforma sugere ativamente vendedores próximos com produtos aderentes.

## Critérios de Aceite

- [ ] **Dado** que tenho um anúncio ativo, **quando** acesso a plataforma, **então** vejo recomendações de produtos e vendedores compatíveis dentro do meu raio.
- [ ] **Dado** uma recomendação, **então** ela exibe o produto, o preço pedido, a distância e a reputação do vendedor.
- [ ] **Dado** uma recomendação que me interessa, **quando** a seleciono, **então** posso convidar o vendedor a ofertar no meu anúncio.
- [ ] **Dado** uma recomendação irrelevante, **quando** a descarto, **então** ela não é exibida de novo e o feedback ajusta as próximas.
- [ ] **Dado** que não existem produtos compatíveis no raio, **então** a plataforma informa isso e sugere ampliar o raio de busca.

## Regras de Negócio

- A recomendação usa categoria, palavras-chave do anúncio, faixa de preço e distância.
- Só entram produtos de vendedores ativos dentro do raio do anúncio.
- Recomendação não é oferta: o vendedor só entra na negociação se ofertar.
- Produtos já ofertados no anúncio não aparecem como recomendação.

## Fora de Escopo (nesta história)

- Recomendação por histórico de navegação ou perfil de consumo.
- Modelos de aprendizado de máquina.
- Recomendação paga ou patrocinada.

## Prioridade

Média. Aumenta muito o valor da plataforma, mas depende do fluxo básico estar pronto.
