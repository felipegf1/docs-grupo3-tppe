# Glossário

Linguagem única do **Quero.**. Os termos abaixo valem para as histórias de usuário, o backlog, a interface e o código: um mesmo conceito não deve aparecer com dois nomes diferentes.

## Papéis

| Termo | Definição |
| :--- | :--- |
| **Visitante** | Pessoa não autenticada. Navega pelo feed público, mas não publica anúncio nem oferta. |
| **Comprador** | Usuário autenticado no papel de quem publica a demanda. Não é um cadastro separado. |
| **Vendedor** | Usuário autenticado no papel de quem responde a demandas com ofertas. |
| **Contraparte** | A outra pessoa de uma mesma negociação, seja ela compradora ou vendedora. |

!!! note "Papéis não são contas"
    A mesma conta atua como comprador e como vendedor. O papel é o contexto da ação, não um tipo de usuário.

## Objetos do domínio

| Termo | Definição | História de origem |
| :--- | :--- | :--- |
| **Anúncio de "procura-se"** | Publicação do comprador descrevendo o produto desejado, com faixa de preço e raio em KM. No feed aparece com o badge **Procurando**. | [QRO-04](../historias-de-usuario/criar-anuncio-procura-se.md) |
| **Produto** | Item do catálogo do vendedor, com estado de conservação e preço. No feed aparece com o badge **Vendendo**. | [QRO-08](../historias-de-usuario/cadastrar-produtos-na-loja.md) |
| **Oferta** | Resposta formal de um vendedor a um anúncio, com descrição, estado de conservação e preço. | [QRO-06](../historias-de-usuario/ofertar-produto-em-anuncio.md) |
| **Palpite** | Estimativa de preço dada por um vendedor, sem compromisso e sem criar oferta. | [QRO-10](../historias-de-usuario/palpitar-preco-no-anuncio.md) |
| **Contraproposta** | Novo valor proposto por uma das partes sobre uma oferta existente. | [QRO-12](../historias-de-usuario/ofertar-novo-valor.md) |
| **Rodada** | Cada par contraproposta e resposta. O total é limitado e compartilhado entre as duas partes. | [QRO-12](../historias-de-usuario/ofertar-novo-valor.md) |
| **Negociação** | O vínculo entre um anúncio e a oferta aceita, do aceite até a conclusão ou o cancelamento. | [QRO-15](../historias-de-usuario/aceitar-ou-recusar-oferta.md) |
| **Reputação** | Nota agregada de 1 a 5 formada pelas avaliações recebidas, exibida junto ao nome nos cards. | [QRO-18](../historias-de-usuario/avaliar-contraparte.md) |
| **Busca salva** | Conjunto de filtros nomeado que o vendedor reaplica depois. | [QRO-07](../historias-de-usuario/buscar-e-filtrar-anuncios.md) |
| **Recomendação** | Sugestão de produto ou vendedor compatível com um anúncio ativo. Não é oferta. | [QRO-09](../historias-de-usuario/receber-recomendacoes.md) |

## Conceitos de alcance

| Termo | Definição |
| :--- | :--- |
| **Raio de busca** | Distância máxima, sempre em quilômetros, definida pelo comprador ao publicar o anúncio. Delimita quais vendedores enxergam a demanda. |
| **Raio padrão** | Valor aplicado pelo sistema quando o comprador não informa um raio. |
| **Localização de referência** | Ponto único por usuário, derivado de CEP, cidade ou coordenadas, usado como centro de todos os cálculos de distância. |
| **Match** | Compatibilidade calculada entre um anúncio e um produto, considerando categoria, palavras-chave, faixa de preço e distância. |

## Estados

=== "Anúncio"

    | Estado | Significado |
    | :--- | :--- |
    | **Ativo** | Visível no feed e aceitando ofertas. |
    | **Pausado** | Fora do feed e sem novas ofertas; as recebidas continuam acessíveis. |
    | **Em negociação** | Uma oferta foi aceita; não recebe novas ofertas. |
    | **Encerrado** | Definitivo. Vai para o histórico e não pode ser reativado. |

=== "Oferta"

    | Estado | Significado |
    | :--- | :--- |
    | **Enviada** | Aguardando a decisão do comprador; pode ser editada ou retirada. |
    | **Em negociação** | Existe contraproposta em aberto ou conversa em andamento. |
    | **Aceita** | Escolhida pelo comprador; passa a ser a oferta vigente do anúncio. |
    | **Recusada** | Descartada pelo comprador ou recusada automaticamente pelo aceite de outra. |
    | **Retirada** | Cancelada pelo próprio vendedor antes do aceite. |

=== "Produto"

    | Estado | Significado |
    | :--- | :--- |
    | **Disponível** | Pode ser ofertado e aparece nas recomendações. |
    | **Reservado** | Vinculado a uma negociação em andamento; não pode ser ofertado em outro anúncio. |
    | **Vendido** | Sai do catálogo público e das sugestões. |

=== "Negociação"

    | Estado | Significado |
    | :--- | :--- |
    | **Em andamento** | Do aceite da oferta até a confirmação da conclusão. |
    | **Concluída** | Confirmada pelas duas partes ou por vencimento do prazo. Não pode ser reaberta. |
    | **Cancelada** | Interrompida pelo comprador; o anúncio volta a aceitar ofertas. |

## Categorias

Taxonomia usada no feed, nos filtros e no cálculo de match:

`Eletrônicos` · `Veículos` · `Informática` · `Games` · `Esportes` · `Casa & Jardim` · `Instrumentos` · `Outros`

## Estados de conservação

`Novo` · `Seminovo` · `Usado — bom estado` · `Usado — com marcas` · `Para peças`

## Termos a evitar

| Não usar | Usar |
| :--- | :--- |
| "Vendedor cria anúncio" | O vendedor **oferta**; quem cria anúncio de "procura-se" é o comprador |
| "Lance" | Contraproposta |
| "Avaliação do produto" | Estado de conservação (avaliação é sempre sobre a pessoa) |
| "Chat de suporte" | Conversa de negociação |
| "Compra" dentro da plataforma | Negociação — pagamento e entrega acontecem fora do Quero. |
