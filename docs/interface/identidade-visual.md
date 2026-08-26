# Identidade visual

A interface da plataforma usa **laranja abóbora dessaturado** como cor principal e **teal** como cor complementar de destaque. A tipografia junta **Bricolage Grotesque** nos títulos com **Inter** no texto corrido.

Esta documentação usa exatamente a mesma paleta e as mesmas fontes, então o site serve de referência viva do tema.

## Cor principal: laranja abóbora

Um laranja quente e terroso, propositalmente dessaturado. O laranja vivo cansa em telas grandes e compete com o conteúdo; o tom abóbora mantém a identidade sem gritar.

<div class="paleta" markdown>
<div class="amostra" style="background:#fbf1ea;color:#3f2011"><strong>50</strong>#fbf1ea</div>
<div class="amostra" style="background:#f5dfcf;color:#3f2011"><strong>100</strong>#f5dfcf</div>
<div class="amostra" style="background:#e9be9e;color:#3f2011"><strong>200</strong>#e9be9e</div>
<div class="amostra" style="background:#db9c70;color:#3f2011"><strong>300</strong>#db9c70</div>
<div class="amostra" style="background:#c97b49;color:#241a14"><strong>400</strong>#c97b49</div>
<div class="amostra" style="background:#b4602f;color:#fff"><strong>500</strong>#b4602f</div>
<div class="amostra" style="background:#984e26;color:#fff"><strong>600</strong>#984e26</div>
<div class="amostra" style="background:#7b3e1f;color:#fff"><strong>700</strong>#7b3e1f</div>
<div class="amostra" style="background:#5e2f18;color:#fff"><strong>800</strong>#5e2f18</div>
<div class="amostra" style="background:#3f2011;color:#fff"><strong>900</strong>#3f2011</div>
</div>

O tom **500 (`#b4602f`)** é a referência da marca. Os tons 600 e 700 existem porque o 500 fica no limite do contraste quando recebe texto branco.

## Cor complementar: teal

Teal é o complementar do laranja no círculo cromático. É o que destaca links, botões e estados ativos sem introduzir uma terceira família de cor.

<div class="paleta" markdown>
<div class="amostra" style="background:#a8e6ea;color:#0d585e"><strong>200</strong>#a8e6ea</div>
<div class="amostra" style="background:#6fd0d6;color:#0d585e"><strong>300</strong>#6fd0d6</div>
<div class="amostra" style="background:#35aeb6;color:#0d585e"><strong>400</strong>#35aeb6</div>
<div class="amostra" style="background:#0f8a92;color:#fff"><strong>500</strong>#0f8a92</div>
<div class="amostra" style="background:#0f6e75;color:#fff"><strong>600</strong>#0f6e75</div>
<div class="amostra" style="background:#0d585e;color:#fff"><strong>700</strong>#0d585e</div>
</div>

## Modo claro e modo escuro

| Papel | Modo claro | Modo escuro |
|---|---|---|
| Fundo da página | `#ffffff` | `#17130f` (preto quente) |
| Texto | `#241a14` | `#ede4dc` |
| Cabeçalho | abóbora 600 `#984e26` | abóbora 800 `#5e2f18` |
| Títulos | abóbora 800 `#5e2f18` | abóbora 200 `#e9be9e` |
| Links e destaques | teal 600 `#0f6e75` | teal 300 `#6fd0d6` |
| Código | fundo abóbora 50 | fundo `#221c16` |

O fundo escuro é um preto quente, e não um cinza neutro. Cinza azulado deixa o laranja com aparência suja; o preto puxado para o marrom mantém o tom limpo.

## Contraste

Todas as combinações de texto atingem no mínimo **AA (4.5:1)** da WCAG:

| Combinação | Razão |
|---|---|
| Branco sobre abóbora 600 | 6.08:1 |
| Teal 600 sobre branco | 5.99:1 |
| Texto `#241a14` sobre branco | 17.03:1 |
| Texto `#ede4dc` sobre `#17130f` | 14.72:1 |
| Teal 300 sobre `#17130f` | 10.27:1 |
| Abóbora 300 sobre `#17130f` | 7.92:1 |

!!! warning "Teal nunca vai sobre laranja"
    Laranja e teal têm luminância parecida: juntos dão apenas 1.33:1. A oposição entre eles funciona como contraste de matiz, não de luminosidade. Texto sobre laranja é sempre **branco**; teal só aparece sobre fundos neutros.

## Tipografia

| Uso | Fonte | Peso |
|---|---|---|
| Títulos e navegação | **Bricolage Grotesque** | 600 a 800 |
| Texto corrido, tabelas, listas | **Inter** | 400 e 600 |
| Código | **JetBrains Mono** | 400 |

Bricolage Grotesque é uma grotesca variável de largura irregular: dá personalidade aos títulos e combina com o tom terroso do laranja. Como é expressiva demais para textos longos, o corpo fica com Inter, que é neutra e legível em tamanho pequeno.

Títulos usam `letter-spacing: -0.02em`, já que grotescas em peso alto pedem um encaixe mais fechado.

## Aplicação na plataforma

| Elemento | Cor |
|---|---|
| Botão primário (criar anúncio, enviar oferta) | abóbora 600, texto branco |
| Botão secundário (palpitar preço, ver detalhes) | contorno teal 600, texto teal 600 |
| Etiqueta de anúncio ativo | teal 500 |
| Etiqueta de anúncio encerrado | abóbora 300 |
| Valor acordado e venda concluída | teal 600 |
| Alertas e prazos de contraproposta | abóbora 500 |

## Como o tema é montado

As cores ficam em [`docs/stylesheets/extra.css`](https://github.com/felipegf1/docs-grupo3-tppe/blob/main/docs/stylesheets/extra.css) como variáveis CSS, sobrescrevendo os tokens do Material for MkDocs:

```css
:root {
  --pumpkin-500: #b4602f;
  --teal-600: #0f6e75;
}

[data-md-color-scheme="default"] {
  --md-primary-fg-color: var(--pumpkin-600);
  --md-accent-fg-color:  var(--teal-600);
  --md-typeset-a-color:  var(--teal-600);
}

[data-md-color-scheme="slate"] {
  --md-primary-fg-color: var(--pumpkin-700);
  --md-accent-fg-color:  var(--teal-300);
  --md-default-bg-color: #17130f;
}
```

No `mkdocs.yml`, a paleta é declarada como `custom` nos dois esquemas, para que o Material use as variáveis acima em vez das cores dele:

```yaml
theme:
  font:
    text: Inter
    code: JetBrains Mono
  palette:
    - media: "(prefers-color-scheme: light)"
      scheme: default
      primary: custom
      accent: custom
    - media: "(prefers-color-scheme: dark)"
      scheme: slate
      primary: custom
      accent: custom

extra_css:
  - stylesheets/extra.css
```

O botão no canto superior direito alterna entre os dois modos, e o padrão acompanha a preferência do sistema.
