# Épico 4 — Descoberta e recomendação

O match, apontado no projeto como a maior dificuldade técnica, aplicado no sentido comprador: enquanto o anúncio espera ofertas, o **Quero.** sugere ativamente quem pode atendê-lo.

| Item | História | Pontos | Sprint |
| :--- | :--- | :---: | :---: |
| [QRO-09](#qro-09) | Receber recomendações | 13 | 9 |
| | **Total do épico** | **13** | |

---

## QRO-09 — Receber recomendações { #qro-09 }

> **Como** comprador, **eu quero** receber recomendações de vendedores e produtos compatíveis com o que procuro, **para que** eu encontre boas opções sem depender só das ofertas que chegam ao meu anúncio.

**História:** [Receber recomendações](../historias-de-usuario/receber-recomendacoes.md) · **Pontos:** 13 · **Sprint:** 9 · **Depende de:** `QRO-04`, `QRO-08`

| # | Tarefa | Camada | Est. |
| :--- | :--- | :--- | :---: |
| QRO-09.1 | Especificar a função de compatibilidade entre anúncio e produto com pesos por categoria, palavras-chave, faixa de preço e distância | Modelagem | 8h |
| QRO-09.2 | Modelar `Recomendacao` com anúncio, produto, pontuação e estado descartado | Modelagem | 3h |
| QRO-09.3 | Implementar o cálculo de compatibilidade por regras, sem aprendizado de máquina | Backend | 10h |
| QRO-09.4 | Restringir candidatos a produtos disponíveis de vendedores ativos dentro do raio do anúncio | Backend | 4h |
| QRO-09.5 | Excluir da lista produtos já ofertados naquele anúncio | Backend | 2h |
| QRO-09.6 | Implementar `POST /recomendacoes/{id}/descartar` alimentando os pesos das próximas | Backend | 5h |
| QRO-09.7 | Implementar o convite ao vendedor para ofertar no anúncio, sem criar oferta automaticamente | Backend | 5h |
| QRO-09.8 | Pré-calcular recomendações em rotina assíncrona para não penalizar o carregamento do feed | Infra | 6h |
| QRO-09.9 | Construir o carrossel "Recomendados para você" com produto, preço, distância e reputação | Frontend | 8h |
| QRO-09.10 | Construir o carrossel "Perto de você" baseado na cidade de referência do usuário | Frontend | 5h |
| QRO-09.11 | Construir o estado vazio que sugere ampliar o raio quando não há compatíveis | Frontend | 2h |
| QRO-09.12 | Avaliar a qualidade do match com um conjunto de anúncios e produtos de referência | QA | 6h |

**Critérios de pronto específicos**

- [ ] Recomendação nunca é oferta: o vendedor só entra na negociação se enviar uma.
- [ ] Um item descartado não volta a aparecer para aquele anúncio.
- [ ] Sem compatíveis no raio, a plataforma explica o motivo e sugere ampliar a distância.

!!! warning "Item de maior risco do backlog"
    `QRO-09` é o único item de 13 pontos e concentra a incerteza técnica do projeto. A versão 1 é deliberadamente baseada em regras: se a qualidade do match for insuficiente, o ajuste é de pesos, não de arquitetura. Modelos de aprendizado de máquina estão explicitamente fora de escopo da história.
