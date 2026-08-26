# Cadastrar produtos na minha loja

## Descrição

**Como** vendedor,
**Eu quero** cadastrar os produtos que tenho disponíveis,
**Para que** eu oferte com poucos cliques e apareça nas sugestões de match.

## Contexto

O MVP prevê que o vendedor "pode anunciar seu produto em sua loja". O catálogo evita redigitar os dados a cada oferta e alimenta [as sugestões de anúncios compatíveis](receber-sugestoes-de-anuncios.md).

## Critérios de Aceite

- [ ] **Dado** que estou autenticado como vendedor, **quando** cadastro um produto com nome, categoria, descrição, estado de conservação, preço e fotos, **então** ele é salvo no meu catálogo.
- [ ] **Dado** um produto cadastrado, **quando** o edito ou removo, **então** as ofertas já enviadas com ele mantêm os dados do momento do envio.
- [ ] **Dado** um produto no catálogo, **quando** vou ofertar em um anúncio, **então** posso selecioná-lo e os campos da oferta são preenchidos automaticamente.
- [ ] **Dado** um produto vendido, **então** ele é marcado como indisponível e sai das sugestões.
- [ ] **Dado** que não informo nome, categoria ou estado de conservação, **então** o cadastro não é concluído.

## Regras de Negócio

- Nome, categoria, descrição e estado de conservação são obrigatórios.
- Cada produto tem status disponível, reservado ou vendido.
- Um produto reservado em uma negociação não pode ser ofertado em outro anúncio.
- Fotos têm limite de quantidade e tamanho por produto.

## Fora de Escopo (nesta história)

- Controle de estoque com múltiplas unidades.
- Importação de catálogo por planilha ou integração.
- Precificação sugerida pela plataforma.

## Prioridade

Média. Acelera a oferta e habilita o match, mas ofertar avulso já funciona sem ela.
