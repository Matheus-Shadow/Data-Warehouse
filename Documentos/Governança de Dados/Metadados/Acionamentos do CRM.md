# Metadados - Acionamentos do CRM

## Colunas

| Nome da Coluna    | Tipo de Dados | Descrição                                                                                     | Restrições   | Relacionamento               |
|-------------------|---------------|-----------------------------------------------------------------------------------------------|--------------|------------------------------|
| EVENTO_ID         | BIGINT        | Id do acionamento no DW                                                                       |              |                              |
| DATA              | DATE          | Data do acionamento no CRM                                                                    |              |                              |
| CARTEIRA          | NVARCHAR      | Nome da carteira                                                                              |              |                              |
| OPERAÇÃO          | NVARCHAR      | Nome da operação                                                                              |              |                              |
| COD_CARTEIRA      | INT           | Código do DW criado para a carteira                                                           |              |                              |
| COD_OP            | INT           | Código do DW criado para a operação                                                           |              |                              |
| COD_CRM           | INT           | Código do CRM implantado                                                                      |              |                              |
| ACIONAMENTO_ID    | BIGINT        | Código único do acionamento no CRM                                                            | PK           |                              |
| ID_KEY            | NVARCHAR      | Número de identificação do cliente                                                            |              | CARTEIRA (ID_KEY)            |
| ID_CRM_OPERADOR   | BIGINT        | ID do operador cadastrado no CRM                                                              |              |                              |
| NOME_CRM_OPERADOR | NVARCHAR      | Nome do operador cadastrado no CRM                                                            |              |                              |
| ID_AC             | BIGINT        | Código do acionamento cadastrado                                                              |              | DEXPARA (ID_AC)              |
| NOME_AC           | NVARCHAR      | Nome do acionamento cadastrado                                                                |              |                              |
| ID_SUB_AC         | BIGINT        | Código do sub acionamento cadastrado                                                          |              |                              |
| NOME_SUB_AC       | NVARCHAR      | Nome do sub acionamento cadastrado                                                            |              |                              |
| INICIO_CHAMADA    | DATETIME2     | Início do atendimento                                                                         |              |                              |
| FIM_CHAMADA       | DATETIME2     | Fim do atendimento                                                                            |              |                              |
| TELEFONE          | NVARCHAR      | Telefone acionado                                                                             |              |                              |
| ORIGEM            | NVARCHAR      | Plataforma ou fonte origem do dado                                                            |              |                              |
| DATA_INSERT       | DATETIME2     | Momento que o dado foi inserido na tabela                                                     |              |                              |
