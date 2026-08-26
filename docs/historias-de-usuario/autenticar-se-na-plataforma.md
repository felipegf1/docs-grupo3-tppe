# Autenticar-se na plataforma

## Descrição

**Como** usuário cadastrado,
**Eu quero** entrar na plataforma com minhas credenciais e encerrar a sessão quando quiser,
**Para que** somente eu tenha acesso aos meus anúncios, ofertas e negociações.

## Contexto

Todas as ações do MVP são atribuídas a um usuário identificado. Esta história garante essa precondição.

## Critérios de Aceite

- [ ] **Dado** que tenho conta, **quando** informo e-mail e senha corretos, **então** sou autenticado e direcionado à página inicial.
- [ ] **Dado** que informo credenciais inválidas, **então** o acesso é negado com mensagem genérica, sem indicar qual campo está errado.
- [ ] **Dado** que estou autenticado, **quando** escolho sair, **então** minha sessão é encerrada.
- [ ] **Dado** que esqueci a senha, **quando** solicito redefinição, **então** recebo por e-mail um link temporário para cadastrar uma nova.
- [ ] **Dado** que acesso uma área restrita sem estar autenticado, **então** vou para a tela de login e, após entrar, retorno ao destino original.

## Regras de Negócio

- A mensagem de erro de login não revela se o e-mail existe na base.
- Após um número configurável de tentativas malsucedidas, a conta fica bloqueada temporariamente.
- A sessão expira por inatividade e exige nova autenticação.
- O link de redefinição de senha é de uso único e tem validade limitada.

## Fora de Escopo (nesta história)

- Autenticação em dois fatores.
- Login social e SSO.
- Permissões administrativas.

## Prioridade

Alta. Pré-requisito de todas as outras histórias.
