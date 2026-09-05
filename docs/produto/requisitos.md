# Requisitos

Requisitos funcionais e não funcionais do **Quero.**, extraídos das [19 histórias de usuário](../historias-de-usuario/index.md). Cada requisito funcional aponta para a história que o originou; nenhum requisito existe aqui sem história correspondente.

## :material-check-circle-outline: Requisitos Funcionais

### Conta e acesso

| ID | Requisito | História |
| :--- | :--- | :--- |
| **RF-01** | O sistema deve permitir o cadastro de conta com nome, e-mail e senha, sendo o e-mail o identificador único. | [QRO-01](../historias-de-usuario/cadastrar-se-na-plataforma.md) |
| **RF-02** | O sistema deve vincular uma localização de referência à conta a partir de CEP, cidade ou coordenadas. | [QRO-01](../historias-de-usuario/cadastrar-se-na-plataforma.md) |
| **RF-03** | O sistema deve permitir que a mesma conta atue como comprador e como vendedor. | [QRO-01](../historias-de-usuario/cadastrar-se-na-plataforma.md) |
| **RF-04** | O sistema deve autenticar o usuário por e-mail e senha e permitir o encerramento da sessão. | [QRO-02](../historias-de-usuario/autenticar-se-na-plataforma.md) |
| **RF-05** | O sistema deve oferecer redefinição de senha por link temporário de uso único. | [QRO-02](../historias-de-usuario/autenticar-se-na-plataforma.md) |
| **RF-06** | O sistema deve redirecionar ao login o acesso não autenticado a área restrita e retornar ao destino original após a entrada. | [QRO-02](../historias-de-usuario/autenticar-se-na-plataforma.md) |
| **RF-07** | O sistema deve permitir a edição de nome, foto, telefone, e-mail e localização, recalculando os anúncios visíveis. | [QRO-03](../historias-de-usuario/gerenciar-perfil-e-localizacao.md) |

### Demanda do comprador

| ID | Requisito | História |
| :--- | :--- | :--- |
| **RF-08** | O sistema deve permitir a publicação de anúncio de "procura-se" com título, categoria, descrição e faixa de preço. | [QRO-04](../historias-de-usuario/criar-anuncio-procura-se.md) |
| **RF-09** | O sistema deve limitar a visibilidade do anúncio aos vendedores dentro do raio em KM informado, aplicando raio padrão na ausência de valor. | [QRO-04](../historias-de-usuario/criar-anuncio-procura-se.md) |
| **RF-10** | O sistema deve listar os anúncios do comprador com status e quantidade de ofertas recebidas. | [QRO-05](../historias-de-usuario/gerenciar-meus-anuncios.md) |
| **RF-11** | O sistema deve permitir editar, pausar, reativar e encerrar anúncios, respeitando as transições válidas. | [QRO-05](../historias-de-usuario/gerenciar-meus-anuncios.md) |

### Oferta do vendedor

| ID | Requisito | História |
| :--- | :--- | :--- |
| **RF-12** | O sistema deve exibir ao vendedor os anúncios cujo raio contém sua localização. | [QRO-06](../historias-de-usuario/ofertar-produto-em-anuncio.md) |
| **RF-13** | O sistema deve permitir o envio de oferta com descrição, estado de conservação e preço, limitada a uma oferta ativa por vendedor em cada anúncio. | [QRO-06](../historias-de-usuario/ofertar-produto-em-anuncio.md) |
| **RF-14** | O sistema deve permitir editar ou retirar a oferta enquanto ela não for aceita. | [QRO-06](../historias-de-usuario/ofertar-produto-em-anuncio.md) |
| **RF-15** | O sistema deve oferecer busca textual e filtros por categoria, faixa de preço e distância, com ordenação e paginação. | [QRO-07](../historias-de-usuario/buscar-e-filtrar-anuncios.md) |
| **RF-16** | O sistema deve permitir salvar e reaplicar conjuntos de filtros. | [QRO-07](../historias-de-usuario/buscar-e-filtrar-anuncios.md) |
| **RF-17** | O sistema deve manter um catálogo de produtos por vendedor, com status disponível, reservado e vendido. | [QRO-08](../historias-de-usuario/cadastrar-produtos-na-loja.md) |
| **RF-18** | O sistema deve preencher o formulário de oferta a partir de um produto do catálogo, preservando os dados enviados em ofertas anteriores. | [QRO-08](../historias-de-usuario/cadastrar-produtos-na-loja.md) |

### Descoberta

| ID | Requisito | História |
| :--- | :--- | :--- |
| **RF-19** | O sistema deve recomendar ao comprador produtos e vendedores compatíveis com seu anúncio ativo dentro do raio. | [QRO-09](../historias-de-usuario/receber-recomendacoes.md) |
| **RF-20** | O sistema deve permitir convidar um vendedor recomendado a ofertar, sem criar oferta automaticamente. | [QRO-09](../historias-de-usuario/receber-recomendacoes.md) |
| **RF-21** | O sistema deve permitir descartar recomendações e usar esse retorno no ajuste das próximas. | [QRO-09](../historias-de-usuario/receber-recomendacoes.md) |

### Negociação

| ID | Requisito | História |
| :--- | :--- | :--- |
| **RF-22** | O sistema deve registrar palpites de preço sem criar oferta, exibindo ao comprador a faixa mínima, média e máxima de forma anônima. | [QRO-10](../historias-de-usuario/palpitar-preco-no-anuncio.md) |
| **RF-23** | O sistema deve avisar o comprador quando a faixa desejada estiver desalinhada dos palpites recebidos. | [QRO-10](../historias-de-usuario/palpitar-preco-no-anuncio.md) |
| **RF-24** | O sistema deve exibir ao comprador todas as ofertas do anúncio com preço, conservação, distância e reputação, permitindo ordenar e comparar lado a lado. | [QRO-11](../historias-de-usuario/comparar-ofertas-recebidas.md) |
| **RF-25** | O sistema deve permitir contraproposta com justificativa, limitada a uma em aberto por oferta e a um número configurável de rodadas. | [QRO-12](../historias-de-usuario/ofertar-novo-valor.md) |
| **RF-26** | O sistema deve expirar contrapropostas não respondidas no prazo, devolvendo a oferta ao valor anterior. | [QRO-12](../historias-de-usuario/ofertar-novo-valor.md) · [QRO-13](../historias-de-usuario/responder-contraproposta.md) |
| **RF-27** | O sistema deve permitir ao vendedor aceitar, recusar ou responder a contraproposta com novo valor. | [QRO-13](../historias-de-usuario/responder-contraproposta.md) |
| **RF-28** | O sistema deve manter o histórico de valores propostos visível para as duas partes durante a negociação. | [QRO-13](../historias-de-usuario/responder-contraproposta.md) |
| **RF-29** | O sistema deve oferecer conversa entre comprador e vendedor no contexto de uma oferta, com mensagens imutáveis. | [QRO-14](../historias-de-usuario/negociar-por-chat.md) |
| **RF-30** | O sistema deve tornar a conversa somente leitura após o encerramento do anúncio ou a conclusão da negociação. | [QRO-14](../historias-de-usuario/negociar-por-chat.md) |
| **RF-31** | O sistema deve permitir denunciar conversas e bloquear usuários. | [QRO-14](../historias-de-usuario/negociar-por-chat.md) |
| **RF-32** | O sistema deve permitir aceitar uma oferta, movendo o anúncio para "em negociação" e recusando automaticamente as demais. | [QRO-15](../historias-de-usuario/aceitar-ou-recusar-oferta.md) |
| **RF-33** | O sistema deve permitir recusar ofertas individualmente, com motivo opcional visível apenas ao vendedor recusado. | [QRO-15](../historias-de-usuario/aceitar-ou-recusar-oferta.md) |
| **RF-34** | O sistema deve permitir cancelar a negociação, devolvendo o anúncio ao estado ativo. | [QRO-15](../historias-de-usuario/aceitar-ou-recusar-oferta.md) |
| **RF-35** | O sistema deve concluir a venda mediante confirmação das duas partes ou vencimento do prazo, encerrando o anúncio e marcando o produto como vendido. | [QRO-16](../historias-de-usuario/concluir-venda.md) |

### Confiança e histórico

| ID | Requisito | História |
| :--- | :--- | :--- |
| **RF-36** | O sistema deve notificar os eventos da negociação no aplicativo e, conforme preferência, por e-mail. | [QRO-17](../historias-de-usuario/receber-notificacoes.md) |
| **RF-37** | O sistema deve permitir configurar tipos e canais de notificação, exceto avisos de segurança da conta. | [QRO-17](../historias-de-usuario/receber-notificacoes.md) |
| **RF-38** | O sistema deve permitir avaliar a contraparte com nota de 1 a 5 e comentário após a conclusão, publicando as duas avaliações simultaneamente. | [QRO-18](../historias-de-usuario/avaliar-contraparte.md) |
| **RF-39** | O sistema deve calcular e exibir a reputação agregada do usuário nos cards, ofertas e recomendações. | [QRO-18](../historias-de-usuario/avaliar-contraparte.md) |
| **RF-40** | O sistema deve disponibilizar histórico somente leitura das negociações concluídas e canceladas, com filtros por papel e status. | [QRO-19](../historias-de-usuario/historico-de-negociacoes.md) |

## :material-shield-check-outline: Requisitos Não Funcionais

### Segurança e privacidade

| ID | Requisito | Origem |
| :--- | :--- | :--- |
| **RNF-01** | Senhas devem ser persistidas apenas como hash gerado por algoritmo de derivação lento. | [QRO-01](../historias-de-usuario/cadastrar-se-na-plataforma.md) |
| **RNF-02** | Mensagens de erro de autenticação não podem revelar se um e-mail existe na base. | [QRO-02](../historias-de-usuario/autenticar-se-na-plataforma.md) |
| **RNF-03** | Contas devem ser bloqueadas temporariamente após um número configurável de tentativas malsucedidas. | [QRO-02](../historias-de-usuario/autenticar-se-na-plataforma.md) |
| **RNF-04** | Um vendedor não pode acessar, por nenhuma via, o conteúdo ou o valor das ofertas concorrentes. | [QRO-11](../historias-de-usuario/comparar-ofertas-recebidas.md) |
| **RNF-05** | Palpites de preço devem ser anônimos e só agregados a partir de três registros. | [QRO-10](../historias-de-usuario/palpitar-preco-no-anuncio.md) |
| **RNF-06** | Avaliações devem permanecer ocultas até a publicação simultânea, impedindo retaliação. | [QRO-18](../historias-de-usuario/avaliar-contraparte.md) |
| **RNF-07** | Cada usuário deve acessar apenas o próprio histórico e as próprias conversas. | [QRO-19](../historias-de-usuario/historico-de-negociacoes.md) |

### Desempenho e escala

| ID | Requisito |
| :--- | :--- |
| **RNF-08** | O feed filtrado por raio deve responder em até 1 segundo no percentil 95 para uma base de 100 mil anúncios ativos. |
| **RNF-09** | Consultas por distância devem usar índice geoespacial e pré-filtro por cidade, nunca varredura completa da tabela. |
| **RNF-10** | Listagens devem ser paginadas, com carregamento incremental na interface. |
| **RNF-11** | As recomendações devem ser pré-calculadas de forma assíncrona, sem bloquear o carregamento do feed. |

### Integridade e rastreabilidade

| ID | Requisito |
| :--- | :--- |
| **RNF-12** | Mensagens de conversa e avaliações são imutáveis após o envio. |
| **RNF-13** | Toda transição de estado de anúncio, oferta e negociação deve ser registrada com data, autor e valor. |
| **RNF-14** | Uma negociação concluída não pode ser reaberta por nenhuma operação do sistema. |
| **RNF-15** | Dados de produto usados em uma oferta devem ser congelados no momento do envio. |

### Usabilidade e interface

| ID | Requisito |
| :--- | :--- |
| **RNF-16** | A interface deve seguir a [identidade visual](../interface/identidade-visual.md) do Quero. em modo claro e escuro. |
| **RNF-17** | Todas as telas devem funcionar em telas a partir de 360 px de largura. |
| **RNF-18** | Distâncias devem ser sempre exibidas em quilômetros e valores em reais. |
| **RNF-19** | Toda listagem deve ter estado vazio explicando o que fazer em seguida. |
| **RNF-20** | O contraste de texto deve atender ao nível AA da WCAG 2.1. |

### Operação

| ID | Requisito |
| :--- | :--- |
| **RNF-21** | O ambiente de desenvolvimento deve subir por Docker Compose, sem instalação manual de dependências. |
| **RNF-22** | A documentação deve ser publicada automaticamente a cada push na branch principal. |
| **RNF-23** | Prazos, limites de rodadas e raio padrão devem ser configuráveis sem alteração de código. |

## :material-cancel: Fora de escopo do MVP

Decisões conscientes, registradas nas seções "Fora de Escopo" das histórias:

- Pagamento, entrega e logística dentro da plataforma.
- Cálculo e cobrança de comissão sobre a venda.
- Login social, SSO e autenticação em dois fatores.
- Modelos de aprendizado de máquina no match.
- Notificações por SMS e WhatsApp.
- Verificação de identidade e selo de vendedor verificado.
- Exportação de histórico e relatórios de desempenho.
