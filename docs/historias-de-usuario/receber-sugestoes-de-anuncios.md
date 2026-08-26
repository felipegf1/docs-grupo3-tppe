# Receber sugestões de anúncios compatíveis

## Descrição

**Como** vendedor,
**Eu quero** receber sugestões automáticas de anúncios que combinam com os produtos do meu catálogo,
**Para que** eu não precise procurar demanda manualmente.

## Contexto

É o algoritmo de match no sentido vendedor, a maior dificuldade técnica do projeto. Cruza os produtos cadastrados em [Cadastrar produtos na minha loja](cadastrar-produtos-na-loja.md) com os anúncios ativos no raio.

## Critérios de Aceite

- [ ] **Dado** que tenho produtos cadastrados, **quando** acesso a plataforma, **então** vejo anúncios sugeridos com o produto correspondente indicado.
- [ ] **Dado** uma sugestão, **então** ela exibe o grau de compatibilidade e os critérios que geraram o match.
- [ ] **Dado** uma sugestão, **quando** a aceito, **então** o formulário de oferta abre já preenchido com os dados do produto.
- [ ] **Dado** uma sugestão irrelevante, **quando** a descarto, **então** ela não reaparece e o feedback ajusta as próximas.
- [ ] **Dado** um novo anúncio compatível publicado no meu raio, **então** recebo uma notificação da sugestão.

## Regras de Negócio

- O match considera categoria, palavras-chave, faixa de preço do anúncio e distância entre as partes.
- Só entram anúncios ativos cujo raio inclui a localização do vendedor.
- Anúncios em que o vendedor já tem oferta ativa não são sugeridos de novo.
- O grau de compatibilidade é um percentual calculado pelos mesmos critérios, exibido de forma transparente.

## Fora de Escopo (nesta história)

- Envio automático de oferta sem ação do vendedor.
- Modelos de aprendizado de máquina.
- Priorização paga nas sugestões.

## Prioridade

Média. É o diferencial do produto, mas depende do catálogo e dos anúncios em volume.
