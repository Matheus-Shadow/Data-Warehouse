# Metadados - CADASTRO

## Colunas

| Nome da Coluna        | Tipo de Dados | Descrição                                                  | Restrições   | Relacionamento          |
|-----------------------|---------------|------------------------------------------------------------|--------------|-------------------------|
| ID_CADASTRO           | INT (8)       | Campo de auto incremento                                   |PK, IDENTITY  |                         |
| EMPRESA               | NVARCHAR (20) | Nome da empresa do grupo que a carteira pertence           |              |                         |
| CLIENTE               | NVARCHAR (30) | Nome do cliente (empresa contratante)                      |              |                         |
| COD_CLIENTE           | INT (8)       | Código do cliente (empresa contratante)                    |              |                         |
| COD_CARTEIRA          | INT (8)       | Código do MIS criado para a carteira                       |              |                         |
| COD_OP                | INT (8)       | Código do MIS criado para a operação                       |              |                         |
| COD_CRM               | INT (8)       | ID da carteira no CRM implantado                           |              |                         |
| CARTEIRA              | NVARCHAR (20) | Nome da carteira                                           |              |                         |
| OPERAÇÃO              | NVARCHAR (100)| Nome da operação                                           |              |                         |
| CRM                   | NVARCHAR (15) | Nome do CRM cadastrado                                     |              |                         |
| SERVIDOR_CRM          | NVARCHAR (20) | Host IP da instância do banco de dados                     |              |                         |
| BANCO_CRM             | NVARCHAR (30) | Nome do banco de dados                                     |              |                         |
| TIPO_CRM              | NVARCHAR (15) | Tipo do SGBD                                               |              |                         |
| STATUS                | CHAR (7)      | Declara se está ativa ou inativa                           |              |                         |
| DATA_CADASTRO         | DATETIME2 (19)| Data e hora do cadastro no DW                              |              |                         |
| DATA_ATUALIZAÇÃO      | DATETIME2 (19)| Data e hora da atualização do cadastro no DW               |              |                         |
