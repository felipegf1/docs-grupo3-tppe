# Cadastrar-se na plataforma

## Descrição

**Como** visitante,
**Eu quero** criar uma conta informando meus dados e minha localização,
**Para que** eu possa publicar anúncios de "procura-se" como comprador ou ofertar produtos como vendedor.

## Contexto

O raio de busca em KM só funciona se comprador e vendedor tiverem localização conhecida. O cadastro é o ponto de entrada de todos os outros fluxos.

## Critérios de Aceite

- [ ] **Dado** que sou visitante, **quando** informo nome, e-mail e senha válidos, **então** minha conta é criada.
- [ ] **Dado** que informo um e-mail já usado por outra conta, **então** o cadastro é recusado e o conflito é indicado.
- [ ] **Dado** que informo minha localização (CEP, cidade ou coordenadas), **então** ela é vinculada à conta e passa a ser usada nos cálculos de raio.
- [ ] **Dado** que a senha não atende aos requisitos mínimos, **então** o cadastro não é concluído e os requisitos são exibidos.
- [ ] **Dado** que concluí o cadastro, **então** posso atuar como comprador e como vendedor com a mesma conta.

## Regras de Negócio

- O e-mail é o identificador único da conta.
- Não existem cadastros separados por papel: a mesma conta atua nos dois.
- A localização pode ser preenchida depois, mas é obrigatória para publicar anúncio ou enviar oferta.
- Senhas são persistidas apenas como hash.

## Fora de Escopo (nesta história)

- Cadastro via Google, Facebook ou outro provedor OAuth.
- Verificação de identidade e documentos.
- Recuperação de senha, tratada em [Autenticar-se na plataforma](autenticar-se-na-plataforma.md).

## Prioridade

Alta. Pré-requisito de todas as outras histórias.
