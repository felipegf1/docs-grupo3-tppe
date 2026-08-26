# :material-swap-horizontal-bold: Plataforma para E-Commerce

**Uma "OLX reversa" para produtos usados e seminovos.**

Em vez do vendedor anunciar o que tem à venda, é o **comprador** quem publica um anúncio de *"procura-se"* descrevendo o que deseja. São os vendedores que encontram essa demanda e oferecem seus produtos.

<div class="grid cards" markdown>

-   :material-flag-outline:{ .lg .middle } **Estado atual**

    ---

    Ideia, em fase de definição de escopo e histórias de usuário.

-   :material-puzzle-outline:{ .lg .middle } **Maior dificuldade**

    ---

    Algoritmo para dar **match** entre anúncios de "procura-se" e produtos dos vendedores.

-   :material-cash-multiple:{ .lg .middle } **Modelo de ganhos**

    ---

    Links de afiliado, percentual sobre a venda ou assinatura.

</div>

## :material-format-list-checks: MVP

<div class="grid cards" markdown>

-   :material-store-outline:{ .lg .middle } **Vendedor**

    ---

    Procura usuários para ofertar seu produto e pode anunciá-lo em sua loja.

-   :material-magnify:{ .lg .middle } **Comprador**

    ---

    Cria um anúncio de *"procura-se"* com detalhes do produto e um **raio de busca em KM**.

-   :material-cellphone:{ .lg .middle } **App**

    ---

    Permite barganhar e negociar diretamente entre comprador e vendedor.

</div>

## :material-sitemap-outline: Como funciona o fluxo

```mermaid
flowchart LR
    A(["🧑 Comprador"]) -->|Cria anúncio de<br/>procura-se + raio em KM| B["📢 Anúncio publicado"]
    B -->|Notifica vendedores<br/>dentro do raio| C(["🏪 Vendedor"])
    C -->|Envia oferta com<br/>detalhes do produto| D["💬 Oferta recebida"]
    D -->|Comprador avalia<br/>e barganha| E["🤝 Negociação"]
    E --> F["✅ Venda concluída"]

    style A fill:#5c6bc0,stroke:#3949ab,color:#fff
    style C fill:#5c6bc0,stroke:#3949ab,color:#fff
    style F fill:#43a047,stroke:#2e7d32,color:#fff
```

!!! tip "Por que "OLX reversa"?"
    Em marketplaces tradicionais o vendedor cria o anúncio e o comprador procura. Aqui a lógica se inverte: **o comprador anuncia a intenção de compra** e o mercado responde a ela, reduzindo o tempo de busca e ligando demanda a oferta de forma mais direta.

## :material-book-open-page-variant-outline: Documentação

<div class="grid cards" markdown>

-   :material-clipboard-text-outline:{ .lg .middle } **[Histórias de Usuário](historias-de-usuario/index.md)**

    ---

    As 20 histórias do MVP, do cadastro à avaliação pós-venda, com critérios de aceite e regras de negócio.

-   :material-docker:{ .lg .middle } **[Ambiente com Docker](ambiente/docker.md)**

    ---

    Como subir banco, backend, frontend e documentação com um único `docker compose up`.

</div>
