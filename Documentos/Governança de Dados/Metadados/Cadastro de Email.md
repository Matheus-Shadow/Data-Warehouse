# Metadados - CLIENTES_EMAIL

## Colunas

| Nome da Coluna    | Tipo de Dados  | Descrição                                                      | Restrições | Relacionamento |
|-------------------|----------------|----------------------------------------------------------------|------------|----------------|
| EMAIL_ID          | BIGINT (19)    | ID do e-mail criado no DW                                      |PK, IDENTITY|                |
| DATA_INCLUSAO     | DATETIME2 (19) | Data da inclusão do e-mail no CRM                              |            |                |
| DATA_ALTERACAO    | DATETIME2 (19) | Data de alteração de informações vinculadas ao e-mail          |            |                |
| CARTEIRA          | NVARCHAR (20)  | Nome da carteira                                               |            |                |
| OPERAÇÃO          | NVARCHAR (100) | Nome da operação                                               |            |                |
| COD_CARTEIRA      | INT (8)        | Código do MIS criado para a carteira                           |            |                |
| COD_OP            | INT (8)        | Código do MIS criado para a operação                           |            |                |
| COD_CRM           | INT (8)        | Código do CRM implantado                                       |            |                |
| ID_KEY            | NVARCHAR (20)  | Número de identificação do cliente                             |            |                |
| EMAIL             | NVARCHAR (100) | E-mail cadastrado                                              |            |                |
| SITUACAO_EMAIL    | NVARCHAR (30)  | Situação do e-mail                                             |            |                |
| TIPO_EMAIL        | NVARCHAR (20)  | Tipo do e-mail cadastrado                                      |            |                |
| ORIGEM_EMAIL      | NVARCHAR (30)  | Origem cadastral do e-mail                                     |            |                |
| ORIGEM            | NVARCHAR (30)  | Plataforma ou fonte origem do dado                             |            |                |
| DATA_INSERT       | DATETIME2 (19) | Momento que o dado foi inserido na tabela                      |            |                |
