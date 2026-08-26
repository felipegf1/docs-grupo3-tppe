# Receber notificações

## Descrição

**Como** usuário,
**Eu quero** ser avisado dos eventos das minhas negociações,
**Para que** eu responda rápido sem precisar abrir a plataforma o tempo todo.

## Contexto

A negociação depende de resposta rápida: oferta parada perde valor e contraproposta expira. As demais histórias apontam vários momentos em que a outra parte "é notificada"; esta define como isso acontece.

## Critérios de Aceite

- [ ] **Dado** que sou comprador, **quando** meu anúncio recebe uma oferta, **então** sou notificado.
- [ ] **Dado** que sou vendedor, **quando** minha oferta recebe contraproposta, aceite ou recusa, **então** sou notificado.
- [ ] **Dado** que sou vendedor, **quando** um anúncio compatível é publicado no meu raio, **então** sou notificado.
- [ ] **Dado** que estou na plataforma, **quando** acesso a central de notificações, **então** vejo o histórico e o que ainda não li.
- [ ] **Dado** que estou nas preferências, **quando** escolho os canais e tipos de notificação, **então** passo a receber apenas o que selecionei.

## Regras de Negócio

- Todo evento gera notificação no aplicativo; e-mail e push seguem a preferência do usuário.
- Notificações do mesmo tipo em curto intervalo são agrupadas.
- Eventos com prazo, como contraproposta prestes a expirar, geram lembrete antes do vencimento.
- O usuário pode desativar tudo, menos avisos de segurança da conta.

## Fora de Escopo (nesta história)

- SMS e WhatsApp.
- Resumo diário por e-mail.
- Notificações de marketing.

## Prioridade

Média. Sustenta o tempo de resposta da negociação.
