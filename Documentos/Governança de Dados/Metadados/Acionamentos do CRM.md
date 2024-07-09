# Metadados - Acionamentos do CRM

## Colunas

| Nome da Coluna    | Tipo de Dados | Descrição                                                                                     | Restrições    | Relacionamento               |
|-------------------|---------------|-----------------------------------------------------------------------------------------------|---------------|------------------------------|
| EVENTO_ID         | BIGINT (19)   | ID do acionamento no DW                                                                       | PK, IDENTITY  |                              |
| DATA              | DATE (10)     | Data do acionamento no CRM                                                                    |               |                              |
| CARTEIRA          | NVARCHAR (20) | Nome da carteira                                                                              |               |                              |
| OPERAÇÃO          | NVARCHAR (100)| Nome da operação                                                                              |               |                              |
| COD_CARTEIRA      | INT (8)       | Código do MIS criado para a carteira                                                          |               |                              |
| COD_OP            | INT (8)       | Código do MIS criado para a operação                                                          |               |                              |
| COD_CRM           | INT (8)       | Código do CRM implantado                                                                      |               |                              |
| ACIONAMENTO_ID    | BIGINT (19)   | Código único do acionamento no CRM                                                            |               |                              |
| ID_KEY            | NVARCHAR (20) | Número do CPF, devedor_id, identificador_id ou título_id que estiver presente na base de dados do discador |               | CARTEIRA (ID_KEY)            |
| ID_CRM_OPERADOR   | BIGINT (19)   | ID do operador cadastrado no CRM                                                              |               |                              |
| NOME_CRM_OPERADOR | NVARCHAR (100)| Nome do operador cadastrado no CRM                                                            |               |                              |
| ID_AC             | BIGINT (19)   | Código do acionamento cadastrado                                                              |               | DEXPARA (ID_AC)              |
| NOME_AC           | NVARCHAR (200)| Nome do acionamento cadastrado                                                                |               |                              |
| ID_SUB_AC         | BIGINT (19)   | Código do sub acionamento cadastrado                                                          |               |                              |
| NOME_SUB_AC       | NVARCHAR (200)| Nome do sub acionamento cadastrado                                                            |               |                              |
| INICIO_CHAMADA    | DATETIME2 (19)| Início do atendimento                                                                         |               |                              |
| FIM_CHAMADA       | DATETIME2 (19)| Fim do atendimento                                                                            |               |                              |
| TELEFONE          | NVARCHAR (20) | Telefone acionado                                                                             |               |                              |
| ORIGEM            | NVARCHAR (30) | Plataforma ou fonte origem do dado                                                            |               |                              |
| DATA_INSERT       | DATETIME2 (19)| Momento que o dado foi inserido na tabela                                                     |               |                              |
