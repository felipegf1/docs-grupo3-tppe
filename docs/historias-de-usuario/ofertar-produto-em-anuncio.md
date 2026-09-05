# Ofertar produto em um anúncio de "procura-se"

!!! abstract "QRO-06 · Épico 3 — Vendedor: encontrar e ofertar"
    **Ator:** Vendedor &nbsp;·&nbsp; **Prioridade:** Alta &nbsp;·&nbsp; **Estimativa:** 8 pontos &nbsp;·&nbsp; **Sprint:** 3 &nbsp;·&nbsp; **Depende de:** QRO-04

    [:material-format-list-checks: Tarefas desta história no backlog](../backlog/vendedor.md#qro-06)

## Descrição

**Como** vendedor,
**Eu quero** encontrar anúncios de "procura-se" compatíveis com o que tenho disponível e responder com uma oferta,
**Para que** eu venda meu produto usado ou seminovo direto para quem já está procurando por ele.

## Contexto

Segundo pilar do fluxo invertido. Depois que o comprador publica a demanda em [Criar anúncio de "procura-se"](criar-anuncio-procura-se.md), o vendedor precisa localizá-la e responder com uma proposta.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado como vendedor, **quando** navego pela plataforma, **então** vejo os anúncios cujo raio de busca inclui minha localização.
- [ ] **Dado** um anúncio compatível com um produto que tenho, **quando** envio uma oferta com descrição, estado de conservação e preço, **então** ela é associada ao anúncio.
- [ ] **Dado** que enviei uma oferta, **quando** o comprador acessa o anúncio, **então** ele vê minha oferta entre as recebidas.
- [ ] **Dado** múltiplos vendedores ofertando no mesmo anúncio, **então** o comprador consegue ver e comparar todas as ofertas.
- [ ] **Dado** uma oferta enviada, **quando** quero alterá-la, **então** posso editá-la ou retirá-la enquanto não for aceita.

## Regras de Negócio

- Uma oferta só pode ser enviada para um anúncio ativo.
- A oferta exige, no mínimo: descrição do produto, estado de conservação e preço proposto.
- Cada vendedor tem no máximo uma oferta ativa por anúncio.

## Fora de Escopo (nesta história)

- Barganha de preço.
- Match automático com sugestão proativa de anúncios ao vendedor.
- Pagamento e fechamento da venda.

## Prioridade

Alta. Funcionalidade central do MVP.
