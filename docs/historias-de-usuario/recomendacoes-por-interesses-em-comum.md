# Recomendações por interesses em comum

## Descrição

**Como** comprador ou vendedor,
**Eu quero** ser aproximado de pessoas cujos interesses coincidem com os meus,
**Para que** eu encontre parceiros recorrentes de negociação, e não só um produto isolado.

## Contexto

As recomendações atuais comparam um anúncio com um produto. Esta história olha para as pessoas: quando um comprador procura sempre nas mesmas categorias e um vendedor atua justamente nelas, os dois tendem a negociar mais de uma vez. A afinidade entra como mais um sinal do algoritmo de match.

## Critérios de Aceite

- [ ] **Dado** que estou autenticado, **quando** acesso a plataforma, **então** vejo pessoas recomendadas com os interesses que temos em comum destacados.
- [ ] **Dado** que sou comprador, **quando** um vendedor próximo atua nas categorias que costumo procurar, **então** ele aparece nas minhas recomendações.
- [ ] **Dado** que sou vendedor, **quando** um comprador próximo busca com frequência as categorias do meu catálogo, **então** ele aparece nas minhas recomendações.
- [ ] **Dado** uma pessoa recomendada, **quando** abro seu perfil, **então** vejo os anúncios ou produtos ativos dela que se encaixam nos meus interesses.
- [ ] **Dado** que não quero aparecer nessas listas, **quando** desativo a opção nas preferências, **então** deixo de ser recomendado e de receber recomendações.

## Regras de Negócio

- Os interesses vêm das categorias declaradas no perfil e do histórico de anúncios, ofertas e negociações.
- Só entram pessoas dentro do raio de atuação, com conta ativa e pelo menos uma categoria em comum.
- A recomendação exibe apenas as categorias em comum, nunca o histórico de negociações da outra pessoa.
- A participação é opcional e pode ser desligada a qualquer momento.
- Pessoas bloqueadas ou denunciadas nunca são recomendadas.

## Fora de Escopo (nesta história)

- Seguir usuários e feed social.
- Mensagem direta fora de uma negociação.
- Modelos de aprendizado de máquina.

## Prioridade

Média. Reforça o algoritmo de match, que é a maior dificuldade do projeto.
