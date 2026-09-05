# Épico 1 — Conta e acesso

Todo o resto do **Quero.** depende deste épico: sem conta identificada e sem localização de referência não existe raio, não existe match e não existe negociação.

| Item | História | MoSCoW | Pontos | Sprint |
| :--- | :--- | :---: | :---: | :---: |
| [QRO-01](#qro-01) | Cadastrar-se na plataforma | M | 5 | 1 |
| [QRO-02](#qro-02) | Autenticar-se na plataforma | M | 5 | 1 |
| [QRO-03](#qro-03) | Gerenciar perfil e localização | S | 3 | 2 |
| | **Total do épico** | | **13** | |

---

## QRO-01 — Cadastrar-se na plataforma { #qro-01 }

> **Como** visitante, **eu quero** criar uma conta informando meus dados e minha localização, **para que** eu possa publicar anúncios de "procura-se" como comprador ou ofertar produtos como vendedor.

**História:** [Cadastrar-se na plataforma](../historias-de-usuario/cadastrar-se-na-plataforma.md) · **Prioridade:** Alta · **Pontos:** 5 · **Sprint:** 1 · **Depende de:** —

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-01.1 | Modelar a entidade `Usuario` com e-mail único, hash de senha, nome, telefone, foto e data de criação | Modelagem | 3h |
| QRO-01.2 | Modelar `Localizacao` (CEP, cidade, UF, latitude, longitude) vinculada ao usuário | Modelagem | 3h |
| QRO-01.3 | Implementar `POST /usuarios` com validação de e-mail duplicado e política de senha | Backend | 5h |
| QRO-01.4 | Integrar serviço de geocodificação para converter CEP/cidade em coordenadas | Backend | 5h |
| QRO-01.5 | Persistir senha apenas como hash com algoritmo de derivação lento | Backend | 2h |
| QRO-01.6 | Construir a tela de cadastro conforme o botão **Cadastrar** do protótipo | Frontend | 5h |
| QRO-01.7 | Exibir requisitos de senha e erro de e-mail em uso sem recarregar a página | Frontend | 3h |
| QRO-01.8 | Testar duplicidade de e-mail, senha fraca, localização inválida e cadastro válido | QA | 4h |

**Critérios de pronto específicos**

- [ ] A mesma conta atua como comprador e vendedor, sem escolha de papel no cadastro.
- [ ] A localização pode ficar vazia no cadastro, mas bloqueia publicar anúncio e enviar oferta.
- [ ] Nenhuma resposta da API retorna o hash da senha.

---

## QRO-02 — Autenticar-se na plataforma { #qro-02 }

> **Como** usuário cadastrado, **eu quero** entrar na plataforma com minhas credenciais e encerrar a sessão quando quiser, **para que** somente eu tenha acesso aos meus anúncios, ofertas e negociações.

**História:** [Autenticar-se na plataforma](../historias-de-usuario/autenticar-se-na-plataforma.md) · **Prioridade:** Alta · **Pontos:** 5 · **Sprint:** 1 · **Depende de:** `QRO-01`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-02.1 | Implementar `POST /sessoes` com emissão de token de sessão e expiração por inatividade | Backend | 5h |
| QRO-02.2 | Padronizar mensagem genérica de credencial inválida, sem revelar se o e-mail existe | Backend | 1h |
| QRO-02.3 | Implementar bloqueio temporário após N tentativas malsucedidas, com N configurável | Backend | 4h |
| QRO-02.4 | Implementar fluxo de redefinição de senha com token de uso único e validade limitada | Backend | 6h |
| QRO-02.5 | Configurar envio de e-mail transacional para o link de redefinição | Infra | 3h |
| QRO-02.6 | Construir telas de login, logout e "esqueci minha senha" a partir do botão **Entrar** | Frontend | 5h |
| QRO-02.7 | Proteger rotas privadas e retornar ao destino original após o login | Frontend | 4h |
| QRO-02.8 | Testar bloqueio por tentativas, expiração de token e reuso de link de redefinição | QA | 4h |

**Critérios de pronto específicos**

- [ ] O token de redefinição não pode ser usado duas vezes nem após a validade.
- [ ] O acesso a `/meus-anuncios` sem sessão leva ao login e volta para `/meus-anuncios` depois.

---

## QRO-03 — Gerenciar perfil e localização { #qro-03 }

> **Como** usuário, **eu quero** manter meus dados de perfil e minha localização atualizados, **para que** os anúncios e ofertas que eu vejo correspondam à região onde estou.

**História:** [Gerenciar perfil e localização](../historias-de-usuario/gerenciar-perfil-e-localizacao.md) · **Prioridade:** Média · **Pontos:** 3 · **Sprint:** 2 · **Depende de:** `QRO-01`, `QRO-02`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-03.1 | Implementar `GET /perfil` e `PATCH /perfil` com validação de campos alteráveis | Backend | 4h |
| QRO-03.2 | Exigir confirmação no novo endereço antes de efetivar a troca de e-mail | Backend | 4h |
| QRO-03.3 | Recalcular a lista de anúncios visíveis ao alterar a localização | Backend | 3h |
| QRO-03.4 | Rejeitar localização inválida mantendo a anterior, sem estado intermediário | Backend | 2h |
| QRO-03.5 | Implementar upload e recorte da foto de perfil usada no avatar dos cards | Frontend | 4h |
| QRO-03.6 | Construir a tela de perfil com dados cadastrais e cidade de referência | Frontend | 4h |
| QRO-03.7 | Testar troca de e-mail sem confirmação, localização inválida e recálculo do raio | QA | 3h |

**Critérios de pronto específicos**

- [ ] Alterar a localização move o ponto central do cálculo, sem alterar o raio dos anúncios ativos.
- [ ] O avatar atualizado aparece imediatamente nos cards de anúncio e oferta.
