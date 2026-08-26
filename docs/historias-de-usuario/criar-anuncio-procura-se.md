# Criar anúncio de "procura-se"

## Descrição

**Como** comprador,
**Eu quero** criar um anúncio de "procura-se" descrevendo o produto que estou buscando,
**Para que** vendedores da minha região sejam notificados e possam me ofertar o produto.

## Contexto

Esta história inverte a lógica tradicional de marketplace: em vez do vendedor publicar um anúncio de venda, é o **comprador** quem publica sua demanda. É a base do modelo "OLX reversa" descrito no MVP do projeto.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado como comprador, **quando** preencho nome do produto, categoria, descrição/detalhes e faixa de preço desejada, **então** o anúncio de "procura-se" é criado e publicado.
- [ ] **Dado** que estou criando o anúncio, **quando** informo um raio de busca em KM, **então** o sistema restringe a visibilidade do anúncio a vendedores localizados dentro desse raio.
- [ ] **Dado** que não informo um raio de busca, **então** o sistema aplica um raio padrão pré-definido.
- [ ] **Dado** um anúncio publicado, **quando** um vendedor visualiza a plataforma, **então** o anúncio aparece na lista de demandas próximas a ele.
- [ ] **Dado** um anúncio já publicado, **quando** o comprador edita ou encerra o anúncio, **então** ele deixa de ser exibido para novos vendedores.

## Regras de Negócio

- O raio de busca é sempre expresso em quilômetros (KM).
- Um anúncio de "procura-se" deve ter pelo menos: título, categoria e descrição para ser publicado.
- O anúncio permanece ativo até ser encerrado pelo comprador, receber uma negociação concluída, ou expirar (regra de expiração a definir).

## Fora de Escopo (nesta história)

- Algoritmo de match automático entre anúncios e produtos de vendedores.
- Chat/negociação entre comprador e vendedor.
- Notificações push/e-mail.

## Prioridade

Alta — funcionalidade central do MVP.
