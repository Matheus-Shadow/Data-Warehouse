# Metadados - Acordos

## Colunas

| Nome da Coluna              | Tipo de Dados | Descrição                                                      | Restrições   | Relacionamento          |
|-----------------------------|---------------|----------------------------------------------------------------|--------------|-------------------------|
| EVENTO_ID                   | BIGINT (19)   | ID do acordo no DW                                             |PK, IDENTITY  |                         |
| DATA                        | DATETIME2 (19)| Data da criação do acordo                                      |              |                         |
| CARTEIRA                    | NVARCHAR (20) | Nome da carteira                                               |              |                         |
| OPERAÇÃO                    | NVARCHAR (100)| Nome da operação                                               |              |                         |
| COD_CARTEIRA                | INT (8)       | Código do MIS criado para a carteira                           |              |                         |
| COD_OP                      | INT (8)       | Código do MIS criado para a operação                           |              |                         |
| COD_CRM                     | INT (8)       | Código do CRM implantado                                       |              |                         |
| ID_ACORDO                   | BIGINT (19)   | ID do acordo criado no momento de seu cravamento no CRM        |              |                         |
| ID_KEY                      | NVARCHAR (20) | Número do CPF, devedor_id, identificador_id ou titulo_id       |              |                         |
| USUARIO_ACORDO              | NVARCHAR (50) | Usuário responsável pelo cadastro do acordo                    |              |                         |
| DATA_VENCIMENTO_ORIGINAL    | DATETIME2 (19)| Data do primeiro vencimento do acordo                          |              |                         |
| DATA_VENCIMENTO_ATUAL       | DATETIME2 (19)| Data do vencimento atualizado do acordo                        |              |                         |
| QTD_PRESTACAO               | INT (8)       | Quantidade de prestações do acordo                             |              |                         |
| VALOR_ACORDO                | NUMERIC (9,2) | Valor do acordo cravado no CRM                                 |              |                         |
| ORIGEM                      | NVARCHAR (30) | Plataforma ou fonte origem do dado                             |              |                         |
| DATA_INSERT                 | DATETIME2 (19)| Momento que o dado foi inserido na tabela                      |              |                         |
