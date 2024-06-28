
## Colunas

| Nome da Coluna    | Tipo de Dados | Descrição                                  | Restrições        |
|-------------------|---------------|--------------------------------------------|-------------------|
| id                | Inteiro       | Identificador único do registro            | PK, não nulo      |
| id_acionamento    | Inteiro       | Identificador do acionamento               | não nulo          |
| id_cliente        | Inteiro       | Identificador único do cliente             | FK, não nulo      |
| data_acionamento  | Data          | Data e hora do acionamento                 | não nulo          |
| tipo_acionamento  | String        | Tipo de interação (chamada, email, etc.)   | não nulo          |
| descricao_acao    | String        | Descrição detalhada da ação realizada      |                   |
