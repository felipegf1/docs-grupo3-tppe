# Criar anúncio de "procura-se"

!!! abstract "QRO-04 · Épico 2 — Comprador: publicar a demanda"
    **Ator:** Comprador &nbsp;·&nbsp; **Prioridade:** Alta &nbsp;·&nbsp; **Estimativa:** 8 pontos &nbsp;·&nbsp; **Sprint:** 2 &nbsp;·&nbsp; **Depende de:** QRO-02, QRO-03

    [:material-format-list-checks: Tarefas desta história no backlog](../backlog/comprador.md#qro-04)

## Descrição

**Como** comprador,
**Eu quero** criar um anúncio de "procura-se" descrevendo o produto que estou buscando,
**Para que** vendedores da minha região sejam notificados e possam me ofertar o produto.

## Contexto

Base do modelo de compra reversa do **Quero.**: em vez de o vendedor publicar o que tem à venda, o comprador publica sua demanda e o mercado responde a ela.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado como comprador, **quando** preencho nome do produto, categoria, descrição e faixa de preço desejada, **então** o anúncio é criado e publicado.
- [ ] **Dado** que estou criando o anúncio, **quando** informo um raio de busca em KM, **então** o anúncio fica visível apenas a vendedores dentro desse raio.
- [ ] **Dado** que não informo um raio de busca, **então** o sistema aplica um raio padrão pré-definido.
- [ ] **Dado** um anúncio publicado, **quando** um vendedor acessa a plataforma, **então** o anúncio aparece na lista de demandas próximas a ele.
- [ ] **Dado** um anúncio publicado, **quando** o comprador o edita ou encerra, **então** ele deixa de ser exibido para novos vendedores.

## Regras de Negócio

- O raio de busca é sempre expresso em quilômetros (KM).
- Título, categoria e descrição são obrigatórios para publicar.
- O anúncio permanece ativo até ser encerrado pelo comprador, ter uma negociação concluída ou expirar.

## Fora de Escopo (nesta história)

- Algoritmo de match automático entre anúncios e produtos.
- Chat e negociação entre comprador e vendedor.
- Notificações push e e-mail.

## Prioridade

Alta. Funcionalidade central do MVP.
