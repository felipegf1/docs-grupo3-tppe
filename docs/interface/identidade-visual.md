# Identidade Visual

Guia de marca, estilos e métricas visuais do **Quero.**, a plataforma de compras reversa. Vale para o produto e para esta documentação.

---

## 🏷️ A marca

| Elemento | Definição |
| :--- | :--- |
| **Nome** | **Quero.** — sempre com o ponto final, que é parte do logotipo |
| **Grafia** | `quero.` em minúsculas no logotipo; **Quero.** com maiúscula inicial em texto corrido |
| **Descritor** | Plataforma de compras reversa |
| **Assinatura** | *Você anuncia o que quer. Os vendedores te encontram.* |
| **Símbolo** | Lupa branca sobre quadrado arredondado laranja abóbora |

### Por que "Quero."

O nome é a própria ação do usuário no modelo reverso: o anúncio começa com alguém dizendo o que quer. O ponto final fecha a frase e transforma o desejo em declaração — é afirmação, não busca.

### Tom de voz

- **Direto.** Frases curtas, verbo na frente: "Publique sua demanda", "Anunciar agora".
- **Sem jargão.** "Anúncio de procura-se", nunca "requisição de demanda".
- **Segunda pessoa.** Fala-se com o usuário: "Perto de você", "Recomendados para você".
- **Sem promessa vazia.** Números concretos em vez de superlativos.

---

## 🎨 Paleta de Cores

### Cores Principais

| Nome | Hex | Uso |
| :--- | :--- | :--- |
| **Laranja Abóbora (Primário)** | `#D97338` | Cor da marca, botões principais, preços de venda, destaques |
| **Laranja Escuro (Hover)** | `#C25F27` | Estado pressionado e bordas de elementos primários |
| **Laranja Claro (Superfície)** | `#FBF1EA` | Fundo do hero, badges e áreas de destaque suave |
| **Branco (Fundo Light)** | `#FFFFFF` | Fundo principal no modo claro |
| **Preto (Fundo Dark)** | `#0F0F0F` | Fundo principal no modo escuro |

<div class="paleta" markdown>
<div class="amostra" style="background:#D97338;color:#FFFFFF"><strong>#D97338</strong>Laranja Abóbora</div>
<div class="amostra" style="background:#C25F27;color:#FFFFFF"><strong>#C25F27</strong>Laranja Hover</div>
<div class="amostra" style="background:#FBF1EA;color:#1A1A1A;border:1px solid #E8E8E8"><strong>#FBF1EA</strong>Laranja Claro</div>
<div class="amostra" style="background:#FFFFFF;color:#1A1A1A;border:1px solid #E8E8E8"><strong>#FFFFFF</strong>Fundo Light</div>
<div class="amostra" style="background:#0F0F0F;color:#FFFFFF"><strong>#0F0F0F</strong>Fundo Dark</div>
</div>

---

### Hierarquia de Texto (Light Mode)

| Nível | Hex | Aplicação |
| :--- | :--- | :--- |
| **Primário** | `#1A1A1A` | Títulos, ênfases e texto principal |
| **Secundário** | `#666666` | Metadados, labels e subtítulos |
| **Terciário** | `#999999` | Dicas (*hints*), placeholders e textos auxiliares |

### Hierarquia de Texto (Dark Mode)

| Nível | Hex | Aplicação |
| :--- | :--- | :--- |
| **Primário** | `#EDEDED` | Títulos e texto principal |
| **Secundário** | `#A0A0A0` | Metadados e subtítulos |
| **Terciário** | `#707070` | Dicas e placeholders |

---

### Neutros e Superfícies

| Nome | Hex (Light) | Hex (Dark) | Aplicação |
| :--- | :--- | :--- | :--- |
| **Neutro** | `#F8F8F8` | `#1A1A1A` | Fundo de cards, seções e áreas agrupadas |
| **Bordas / Divisores** | `#E8E8E8` | `#2A2A2A` | Linhas divisórias, bordas de cards e tabelas |

---

### Cores Funcionais

| Função | Hex | Cor | Aplicação no Quero. |
| :--- | :--- | :--- | :--- |
| **Sucesso** | `#34C759` | Verde | Faixa de **Orçamento** nos cards, preço acordado, status ativo |
| **Erro / Aviso** | `#FF3B30` | Vermelho | Validações, recusa de oferta, cancelamentos |
| **Info** | `#007AFF` | Azul | Badge **Procurando**, palpites de preço e links contextuais |

<div class="paleta" markdown>
<div class="amostra" style="background:#34C759;color:#FFFFFF"><strong>#34C759</strong>Sucesso</div>
<div class="amostra" style="background:#FF3B30;color:#FFFFFF"><strong>#FF3B30</strong>Erro / Aviso</div>
<div class="amostra" style="background:#007AFF;color:#FFFFFF"><strong>#007AFF</strong>Info</div>
</div>

### Uso semântico da cor

| Situação | Cor | Motivo |
| :--- | :--- | :--- |
| Anúncio de "procura-se" | Azul `#007AFF` | Demanda em aberto, ainda sem preço fechado |
| Produto à venda | Laranja `#D97338` | Oferta concreta, ação principal da marca |
| Faixa de orçamento | Verde `#34C759` | Valor acordável, sinal positivo de viabilidade |
| Oferta recusada ou expirada | Vermelho `#FF3B30` | Fim de caminho na negociação |

!!! warning "A cor nunca é o único sinal"
    Todo estado indicado por cor precisa de um rótulo textual ou ícone equivalente — os badges **Procurando** e **Vendendo** existem justamente para isso.

---

## 🔤 Tipografia

- **Títulos, Cabeçalhos e Botões:** `Space Grotesk` (600 / 700) — *Bold, geométrica e moderna.*
- **Corpo, Descrições e Metadados:** `Inter` (400 / 500) — *Limpa, neutra e altamente legível.*
- **Código e Dados Técnicos:** `JetBrains Mono` (400)

### Escala Tipográfica

| Elemento | Tamanho | Fonte | Peso |
| :--- | :--- | :--- | :--- |
| **H1 (Título de Página)** | `32px` | Space Grotesk | 700 (Bold) |
| **H2 (Seções)** | `18px` | Space Grotesk | 600 (Semi-Bold) |
| **H3 / Subtítulos** | `16px` | Space Grotesk | 600 (Semi-Bold) |
| **Preço em destaque** | `20px` | Space Grotesk | 700 (Bold) |
| **Body Padrão** | `14px` | Inter | 400 (Regular) |
| **Pequeno / Meta** | `12px` | Inter | 500 (Medium) |

---

## 📐 Métricas de Layout

| Propriedade | Valor | Aplicação |
| :--- | :--- | :--- |
| **Grade do feed** | 3 colunas em telas largas, 2 em médias, 1 em pequenas | Listagem de anúncios |
| **Raio de borda — card** | `12px` | Cards de anúncio e de produto |
| **Raio de borda — botão** | `8px` | Botões e campos de formulário |
| **Raio de borda — chip / badge** | `999px` | Categorias, estados e badges de tipo |
| **Espaçamento base** | `8px` | Múltiplos de 8 para todo espaçamento interno |
| **Espaço entre cards** | `16px` | Grade do feed e carrosséis |
| **Largura máxima de conteúdo** | `1280px` | Centralizada, com respiro lateral de `24px` |
| **Altura do cabeçalho** | `64px` | Fixo no topo com busca sempre visível |
| **Breakpoint mínimo** | `360px` | Largura mínima suportada |

---

## 🧩 Componentes

### Botões

| Variante | Fundo | Texto | Uso |
| :--- | :--- | :--- | :--- |
| **Primário** | `#D97338` | `#FFFFFF` | **+ Anunciar**, **Cadastrar**, ações que avançam o fluxo |
| **Secundário** | Transparente com borda `#E8E8E8` | `#1A1A1A` | **Entrar**, **Ofertar**, **Carregar mais anúncios** |
| **Texto** | Nenhum | `#D97338` | **Explorar** e links de navegação |
| **Flutuante** | `#D97338` | `#FFFFFF` | Atalho persistente de **+ Anunciar** no canto inferior |

### Badges

| Badge | Cor | Significado |
| :--- | :--- | :--- |
| **🛒 Procurando** | Azul `#007AFF` | Anúncio de demanda publicado por um comprador |
| **🏷️ Vendendo** | Laranja `#D97338` | Produto do catálogo de um vendedor |
| **Categoria** | Neutro com texto secundário | Taxonomia do anúncio |
| **Estado de conservação** | Fundo escuro translúcido sobre a foto | Novo, Seminovo, Usado |

### Cards

A anatomia completa dos cards de anúncio está descrita na página de [protótipo](prototipo.md#anatomia-dos-cards). Regras gerais:

- Fundo neutro, borda de `1px` e sem sombra em repouso.
- No *hover*, a borda assume o laranja da marca e o card sobe `2px`.
- A descrição é truncada em duas linhas; o título, em duas.
- Todo card mostra distância em KM e reputação de quem publicou.

---

## ♿ Acessibilidade

- Contraste mínimo **AA da WCAG 2.1** para todo texto, nos dois temas.
- Laranja `#D97338` sobre branco é usado apenas em texto de `18px` ou maior, ou com peso 600 para tamanhos menores.
- Estados de foco visíveis em todos os elementos interativos.
- Emoji dos badges é decorativo: o rótulo textual carrega o significado.
