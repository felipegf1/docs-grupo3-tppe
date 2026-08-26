# Ofertar produto em um anúncio de "procura-se"

## Descrição

**Como** vendedor,
**Eu quero** encontrar anúncios de "procura-se" compatíveis com o que tenho disponível e responder com uma oferta,
**Para que** eu consiga vender meu produto usado/seminovo diretamente para quem já está procurando por ele.

## Contexto

Complementa a história [Criar anúncio de "procura-se"](criar-anuncio-procura-se.md): depois que o comprador publica sua demanda, o vendedor precisa conseguir localizá-la e responder com uma proposta de venda. Esse é o segundo pilar do fluxo invertido do MVP.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado como vendedor, **quando** navego pela plataforma, **então** vejo os anúncios de "procura-se" cujo raio de busca inclui minha localização.
- [ ] **Dado** um anúncio de "procura-se" que corresponde a um produto que tenho, **quando** envio uma oferta, **então** informo detalhes do produto (descrição, condição/estado, preço) e a oferta é associada ao anúncio.
- [ ] **Dado** que enviei uma oferta, **quando** o comprador visualiza o anúncio, **então** ele consegue ver minha oferta entre as recebidas.
- [ ] **Dado** múltiplos vendedores ofertando no mesmo anúncio, **então** o comprador consegue visualizar e comparar todas as ofertas recebidas.
- [ ] **Dado** uma oferta enviada, **quando** o vendedor deseja, **então** ele pode editar ou retirar a oferta antes de ela ser aceita pelo comprador.

## Regras de Negócio

- Uma oferta só pode ser enviada para um anúncio de "procura-se" ativo.
- Uma oferta deve conter, no mínimo: descrição do produto, estado de conservação e preço proposto.
- Um vendedor pode enviar apenas uma oferta ativa por anúncio (pode editá-la em vez de duplicar).

## Fora de Escopo (nesta história)

- Barganha/negociação de preço via chat.
- Algoritmo de match automático (sugestão proativa de anúncios ao vendedor).
- Pagamento e fechamento da venda.

## Prioridade

Alta — funcionalidade central do MVP, complementar à criação do anúncio de "procura-se".
