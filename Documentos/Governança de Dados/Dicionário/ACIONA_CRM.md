# Dicionário de Dados - ACIONA_CRM

## Descrição
Registros de interações com clientes registradas no CRM.

## Colunas
| Nome da Coluna    | Tipo de Dados | Descrição                                  | Restrições        |
|-------------------|---------------|--------------------------------------------|-------------------|
| id_acionamento    | Inteiro       | Identificador único do acionamento         | PK, não nulo      |
| id_cliente        | Inteiro       | Identificador único do cliente             | FK, não nulo      |
| data_acionamento  | Data          | Data e hora do acionamento                 | não nulo          |
| tipo_acionamento  | String        | Tipo de interação (chamada, email, etc.)   | não nulo          |
| descricao_acao    | String        | Descrição detalhada da ação realizada      |                   |
