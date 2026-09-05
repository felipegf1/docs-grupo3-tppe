# Negociar por chat

!!! abstract "QRO-14 · Épico 5 — Negociação"
    **Ator:** Comprador e Vendedor &nbsp;·&nbsp; **Prioridade:** Alta &nbsp;·&nbsp; **Estimativa:** 8 pontos &nbsp;·&nbsp; **Sprint:** 6 &nbsp;·&nbsp; **Depende de:** QRO-06

    [:material-format-list-checks: Tarefas desta história no backlog](../backlog/negociacao.md#qro-14)

## Descrição

**Como** comprador ou vendedor,
**Eu quero** conversar com a outra parte dentro da plataforma,
**Para que** eu esclareça dúvidas e combine detalhes sem sair para outro canal.

## Contexto

O MVP prevê que o app permita barganhar entre comprador e vendedor. A contraproposta trata do valor; o chat trata de tudo que não cabe em um número, como estado do produto, garantia, entrega e forma de pagamento.

## Critérios de Aceite

- [ ] **Dado** uma oferta enviada em um anúncio meu, **quando** abro a conversa, **então** troco mensagens com a outra parte no contexto daquela oferta.
- [ ] **Dado** uma conversa aberta, **quando** recebo uma mensagem, **então** sou notificado e vejo o indicador de não lida.
- [ ] **Dado** uma conversa, **então** o histórico de mensagens e de valores propostos fica disponível para as duas partes.
- [ ] **Dado** que o anúncio foi encerrado ou a negociação concluída, **então** a conversa vira somente leitura.
- [ ] **Dado** um comportamento abusivo, **quando** denuncio a conversa, **então** ela é registrada para análise e posso bloquear o usuário.

## Regras de Negócio

- A conversa existe apenas entre comprador e vendedor de uma oferta específica.
- O chat só é liberado depois que uma oferta é enviada ao anúncio.
- Mensagens não podem ser editadas nem apagadas, garantindo o histórico da negociação.
- O histórico é preservado após a conclusão para servir de evidência em disputas.

## Fora de Escopo (nesta história)

- Chamadas de voz e vídeo.
- Envio de arquivos além de imagens.
- Moderação automática de conteúdo.

## Prioridade

Alta. É a barganha qualitativa prevista no MVP.
