# Gerenciar meus anúncios de "procura-se"

## Descrição

**Como** comprador,
**Eu quero** ver, editar, pausar, reativar e encerrar os anúncios que publiquei,
**Para que** fiquem visíveis apenas as demandas que ainda tenho.

## Contexto

Desdobra a regra de [Criar anúncio de "procura-se"](criar-anuncio-procura-se.md) que mantém o anúncio ativo até o comprador encerrá-lo. Sem uma área de gestão, vendedores perdem tempo ofertando para demandas que já não existem.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado como comprador, **quando** acesso "Meus anúncios", **então** vejo todos eles com status (ativo, pausado, encerrado) e a quantidade de ofertas recebidas.
- [ ] **Dado** um anúncio ativo, **quando** edito título, categoria, descrição, faixa de preço ou raio, **então** a alteração vale para os vendedores que o visualizarem a partir dali.
- [ ] **Dado** um anúncio ativo, **quando** o pauso, **então** ele deixa de ser exibido e não aceita novas ofertas, mas as ofertas já recebidas continuam acessíveis.
- [ ] **Dado** um anúncio pausado, **quando** o reativo, **então** ele volta a aparecer para vendedores dentro do raio.
- [ ] **Dado** um anúncio encerrado, **então** ele não recebe novas ofertas nem pode ser reativado, ficando apenas no histórico.

## Regras de Negócio

- Editar um anúncio não invalida as ofertas já recebidas, mas notifica os vendedores da alteração.
- Não é possível encerrar um anúncio com negociação em andamento.
- O encerramento é definitivo: para retomar a demanda, cria-se um novo anúncio.

## Fora de Escopo (nesta história)

- Expiração automática de anúncios.
- Duplicar um anúncio encerrado.
- Métricas de visualização.

## Prioridade

Alta. Completa o ciclo de vida do anúncio.
