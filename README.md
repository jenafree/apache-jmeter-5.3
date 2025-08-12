# Testes de API e Performance (JMeter + Rest Assured + Jest)

Este repositório demonstra, de ponta a ponta, como testar APIs de forma funcional (contrato) e como medir desempenho (carga/estresse) reutilizando os mesmos cenários.

## O que você encontra aqui

- **Funcional/Contrato**: testes em Java (Rest Assured) e JavaScript (Jest + Supertest)
- **Performance**: plano JMeter que consome os mesmos cenários via CSV e gera relatório HTML
- **Automação simples**: scripts para executar tudo por linha de comando

---

## Conceitos rápidos (API REST)

- **Endpoint**: URL de um recurso (ex.: `GET https://reqres.in/api/users?page=2`)
- **Contrato**: o que esperamos receber (status code, campos, tipos)
- **Idempotência**: requisições que podem ser repetidas com o mesmo resultado
- **Teste funcional**: valida o contrato sem concorrência pesada
- **Teste de performance**: mede latências (P95/P99), throughput e erros sob carga

---

## Metodologia

- **Pilar 1 – Contrato**: Rest Assured (Java) e Jest/Supertest (JS)
- **Pilar 2 – Fluxos**: encadeiam endpoints (ex.: criar → consultar)
- **Pilar 3 – Performance**: JMeter aplica concorrência e mede métricas
- **Fonte única**: `tests/specs/endpoints.csv` e `tests/specs/bodies/*.json`

---

## Estrutura do repositório

- `apache-jmeter-5.3/`: distribuição do JMeter
- `scripts/`: utilitários para executar testes
- `tests/specs/endpoints.csv`: lista de cenários (método, URL, body, status)
- `tests/specs/bodies/`: payloads JSON
- `tests/rest-assured/`: testes Java (Maven/JUnit5/Rest Assured)
- `tests/js/`: testes JS (Jest/Supertest)
- `tests/jmeter/reqres.jmx`: plano JMeter (CSV/JSON)
- `results/` e `reports/`: saídas geradas (gitignored)

---

## Pré‑requisitos

- Java 11+ (ou 8+) no PATH
- Maven (para os testes Java)
- Node.js 18+ (para os testes JS)

---

## Como executar

### 1) Testes funcionais (Java + JS)

Windows (PowerShell):

```powershell
./scripts/run-functional.ps1
```

Linux/macOS:

```bash
bash scripts/run-functional.sh
```

Esse passo executa Java/Rest Assured (`tests/rest-assured`) e JS/Jest (`tests/js`).

### 2) Teste de performance (JMeter)

Windows (PowerShell):

```powershell
./scripts/run.ps1 -Test ./tests/jmeter/reqres.jmx
```

Linux/macOS:

```bash
bash scripts/run.sh -t tests/jmeter/reqres.jmx
```

Saídas geradas:

- `.jtl` em `results/AAAAmmdd-HHMMSS.jtl`
- HTML em `reports/AAAAmmdd-HHMMSS/index.html`

Abra o relatório para analisar P50/P90/P95/P99, throughput e taxa de erro.

---

## Cenários (CSV compartilhado)

Arquivo: `tests/specs/endpoints.csv`

```csv
name,method,url,bodyFile,expectedStatus
list_users,GET,https://reqres.in/api/users?page=2,,200
create_user,POST,https://reqres.in/api/users,create_user.json,201
user_details,GET,https://reqres.in/api/users/2,,200
```

- `bodyFile` aponta para JSONs em `tests/specs/bodies/`
- Rest Assured, Jest e JMeter usam esse mesmo CSV/JSON

### Adicionar um novo cenário

1) Crie (se necessário) o payload em `tests/specs/bodies/novo.json`

2) Adicione a linha no `endpoints.csv`

3) Rode os testes funcionais; se passar, rode o JMeter

---

## Boas práticas

- Idempotência e isolamento de dados
- Parametrização por ambiente (URLs, tokens)
- Validação de contrato (schema) quando fizer sentido
- SLAs claros (ex.: erro < 1%, P95 < 500 ms)

---

## Dúvidas comuns

PowerShell bloqueou scripts? Rode:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Falta Maven/Node? Verifique:

```bash
mvn -v
node -v
npm -v
```

---

## Objetivo do repositório e contribuições

Este repositório é **material de estudo e referência prática** sobre testes de API e performance.

Feedbacks e contribuições são muito bem‑vindos!

- Abra um issue com dúvidas, ideias ou problemas
- Envie um PR com melhorias, novos cenários, correções ou docs
- Siga (se possível) Conventional Commits (`docs:`, `test:`, `feat:`, `fix:`, `chore:`)
- Antes do PR, rode os testes funcionais e gere o relatório do JMeter

---

## Histórico do projeto

- 2025-08: Estrutura unificada de testes (Java/JS) e carga (JMeter) com CSV compartilhado; guia em português; scripts de execução.
- 2025-08: Limpeza de submódulos antigos e organização do repositório.
- 2023–2024: Uso do JMeter 5.3 como base de experimentos e estudos (exemplos e templates).
