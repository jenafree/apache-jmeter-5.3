# Contribuindo

Obrigado por considerar contribuir! Este projeto é material de estudo sobre testes de API e performance.

## Como começar

1. Abra uma issue descrevendo o problema/ideia
2. Fork o repositório e crie uma branch descritiva
3. Faça commits pequenos seguindo Conventional Commits (ex.: `docs:`, `feat:`, `fix:`, `test:`, `chore:`)
4. Garanta que os testes passam e que o relatório do JMeter é gerado
5. Abra um Pull Request referenciando a issue

## Executando localmente

- Java/Rest Assured:
  - `cd tests/rest-assured && mvn test`
- JS/Jest:
  - `cd tests/js && npm ci && npm test`
- JMeter (relatório):
  - `bash scripts/run.sh -t tests/jmeter/reqres.jmx`

## Código de conduta

Seja respeitoso, acolhedor e claro nas comunicações.
