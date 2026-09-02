# Buscar e filtrar anúncios de "procura-se"

## Descrição

**Como** vendedor,
**Eu quero** buscar e filtrar os anúncios de "procura-se" da minha região,
**Para que** eu encontre rápido as demandas que consigo atender.

## Contexto

Detalha o primeiro critério de [Ofertar produto em um anúncio](ofertar-produto-em-anuncio.md). Com muitos anúncios no raio, uma lista sem filtros deixa de ser útil.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado como vendedor, **quando** busco por texto, **então** vejo os anúncios cujo título ou descrição correspondem ao termo.
- [ ] **Dado** a lista de anúncios, **quando** filtro por categoria, faixa de preço ou distância máxima, **então** apenas os anúncios correspondentes são exibidos.
- [ ] **Dado** a lista de anúncios, **quando** ordeno por distância, data de publicação ou faixa de preço, **então** a lista é reordenada.
- [ ] **Dado** um conjunto de filtros aplicado, **quando** o salvo como busca favorita, **então** posso reaplicá-lo depois.
- [ ] **Dado** que nenhum anúncio atende aos filtros, **então** a plataforma informa isso e sugere afrouxar os critérios.

## Regras de Negócio

- A busca só retorna anúncios ativos cujo raio inclui a localização do vendedor.
- Anúncios em negociação ou encerrados não aparecem nos resultados.
- Os filtros aplicados persistem durante a sessão.

## Fora de Escopo (nesta história)

- Sugestão automática de anúncios.
- Busca por imagem.
- Alerta por e-mail de novas buscas salvas.

## Prioridade

Alta. Viabiliza o dia a dia do vendedor.
