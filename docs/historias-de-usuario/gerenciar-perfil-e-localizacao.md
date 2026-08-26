# Gerenciar perfil e localização

## Descrição

**Como** usuário,
**Eu quero** manter meus dados de perfil e minha localização atualizados,
**Para que** os anúncios e ofertas que eu vejo correspondam à região onde estou.

## Contexto

Localização desatualizada quebra o match: o comprador deixa de ser encontrado por vendedores próximos e o vendedor recebe demandas irrelevantes.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado, **quando** acesso meu perfil, **então** vejo meus dados cadastrais e minha localização atual.
- [ ] **Dado** que estou no perfil, **quando** altero nome, foto, telefone ou localização, **então** as alterações passam a valer imediatamente.
- [ ] **Dado** que altero minha localização, **então** a lista de anúncios visíveis para mim é recalculada com base na nova posição.
- [ ] **Dado** que altero meu e-mail, **então** a mudança só é efetivada após confirmação no novo endereço.
- [ ] **Dado** que informo uma localização inválida, **então** a alteração é recusada e a anterior é mantida.

## Regras de Negócio

- Cada usuário tem uma única localização de referência por vez.
- Alterar a localização muda apenas o ponto central do cálculo, não o raio dos anúncios ativos.
- Alterações de perfil não afetam negociações concluídas nem o histórico de avaliações.

## Fora de Escopo (nesta história)

- Múltiplos endereços por conta.
- Geolocalização automática por GPS.
- Exclusão de conta.

## Prioridade

Média. Necessária para a qualidade do match, mas não bloqueia o fluxo principal.
