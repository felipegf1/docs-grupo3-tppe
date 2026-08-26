# Comparar ofertas recebidas

## Descrição

**Como** comprador,
**Eu quero** ver e comparar todas as ofertas recebidas em um anúncio,
**Para que** eu escolha a proposta mais vantajosa antes de negociar.

## Contexto

Como o modelo é invertido, o comprador recebe várias propostas concorrentes para a mesma demanda e precisa de apoio para decidir.

## Critérios de Aceite

- [ ] **Dado** um anúncio meu com ofertas, **quando** o acesso, **então** vejo cada oferta com preço, estado de conservação, distância e reputação do vendedor.
- [ ] **Dado** que estou vendo as ofertas, **quando** ordeno por preço, distância ou reputação, **então** a lista é reordenada.
- [ ] **Dado** que estou vendo as ofertas, **quando** seleciono duas ou mais, **então** consigo compará-las lado a lado nos mesmos atributos.
- [ ] **Dado** que uma oferta foi editada pelo vendedor, **então** a lista exibe o valor atualizado e sinaliza a alteração.
- [ ] **Dado** que uma oferta foi retirada, **então** ela deixa de aparecer entre as disponíveis.

## Regras de Negócio

- Apenas o comprador dono do anúncio vê a lista completa de ofertas.
- Um vendedor não vê o conteúdo nem o valor das ofertas concorrentes.
- Ofertas retiradas ou recusadas saem da comparação, mas permanecem no histórico do anúncio.

## Fora de Escopo (nesta história)

- Ranking automático de "melhor oferta".
- Aceite da oferta, tratado em [Aceitar ou recusar uma oferta](aceitar-ou-recusar-oferta.md).
- Barganha, tratada em [Ofertar um novo valor em um anúncio](ofertar-novo-valor.md).

## Prioridade

Alta. É o momento de decisão do comprador.
