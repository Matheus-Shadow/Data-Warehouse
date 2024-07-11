# Metadados - PAGAMENTOS

## Colunas

| Nome da Coluna        | Tipo de Dados  | Descrição                                                       | Restrições | Relacionamento |
|-----------------------|----------------|-----------------------------------------------------------------|------------|----------------|
| EVENTO_ID             | BIGINT (19)    | ID do pagamento no DW                                           |PK, IDENTITY|                |
| DATA                  | DATETIME2 (19) | Data da realização do pagamento                                 |            |                |
| CARTEIRA              | NVARCHAR (20)  | Nome da carteira                                                |            |                |
| OPERAÇÃO              | NVARCHAR (100) | Nome da operação                                                |            |                |
| COD_CARTEIRA          | INT (8)        | Código do MIS criado para a carteira                            |            |                |
| COD_OP                | INT (8)        | Código do MIS criado para a operação                            |            |                |
| COD_CRM               | INT (8)        | Código do CRM implantado                                        |            |                |
| ID_ACORDO             | BIGINT (19)    | ID do acordo no CRM                                             |            |                |
| ID_KEY                | NVARCHAR (20)  | Número de identificação do cliente                              |            |                |
| USUARIO_PAGAMENTO     | NVARCHAR (50)  | Usuário responsável pelo cadastro do pagamento                  |            |                |
| OPERADOR              | NVARCHAR (150) | Operador vinculado ao pagamento                                 |            |                |
| TIPO_PAGAMENTO        | INT (8)        | Código do tipo de pagamento                                     |            |                |
| TIPO_PAGAMENTO_NOME   | NVARCHAR (100) | Nome do tipo de pagamento                                       |            |                |
| VALOR_PAGAMENTO       | NUMERIC (9,2)  | Valor do pagamento cravado no CRM                               |            |                |
| ORIGEM                | NVARCHAR (30)  | Plataforma ou fonte origem do dado                              |            |                |
| DATA_INSERT           | DATETIME2 (19) | Momento que o dado foi inserido na tabela                       |            |                |
