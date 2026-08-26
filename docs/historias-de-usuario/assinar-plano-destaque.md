# Assinar um plano de destaque

## Descrição

**Como** vendedor,
**Eu quero** assinar um plano pago,
**Para que** minhas ofertas e minha loja tenham mais visibilidade.

## Contexto

Cobre o modelo de ganhos do projeto, que prevê assinatura, percentual sobre a venda ou links de afiliado. A assinatura é a opção mais simples de validar no MVP.

## Critérios de Aceite

- [ ] **Dado** que sou vendedor, **quando** acesso os planos, **então** vejo os benefícios e o preço de cada um.
- [ ] **Dado** um plano escolhido, **quando** concluo o pagamento, **então** a assinatura é ativada e os benefícios valem de imediato.
- [ ] **Dado** que tenho assinatura ativa, **então** minhas ofertas recebem destaque visual na lista do comprador.
- [ ] **Dado** que tenho assinatura ativa, **quando** acesso minha área, **então** vejo a validade, o histórico de cobranças e a opção de cancelar.
- [ ] **Dado** que a assinatura expira ou é cancelada, **então** volto ao plano gratuito sem perder anúncios, ofertas ou reputação.

## Regras de Negócio

- O plano gratuito permite ofertar sem limite: o plano pago afeta visibilidade, não acesso.
- Ofertas em destaque são sinalizadas como tal para o comprador.
- O destaque nunca altera preço, distância ou reputação exibidos.
- O cancelamento vale ao fim do período já pago, sem reembolso proporcional.

## Fora de Escopo (nesta história)

- Percentual sobre a venda e links de afiliado.
- Emissão de nota fiscal.
- Planos para compradores.

## Prioridade

Baixa. Monetização, posterior à validação do fluxo principal.
