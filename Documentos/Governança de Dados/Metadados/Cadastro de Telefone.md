# Metadados - CLIENTES_TELEFONE

## Colunas

| Nome da Coluna             | Tipo de Dados  | Descrição                                           | Restrições | Relacionamento |
|----------------------------|----------------|-----------------------------------------------------|------------|----------------|
| TELEFONE_ID                | BIGINT (19)    | ID do telefone criado no DW                         |PK, IDENTITY|                |
| DATA_INCLUSAO              | DATETIME2 (19) | Data da inclusão do fone no CRM                     |            |                |
| DATA_ALTERACAO             | DATETIME2 (19) | Data de alteração de informações vinculadas ao fone |            |                |
| CARTEIRA                   | NVARCHAR (20)  | Nome da carteira                                    |            |                |
| OPERAÇÃO                   | NVARCHAR (100) | Nome da operação                                    |            |                |
| COD_CARTEIRA               | INT (8)        | Código do MIS criado para a carteira                |            |                |
| COD_OP                     | INT (8)        | Código do MIS criado para a operação                |            |                |
| ID_KEY                     | NVARCHAR (20)  | Número de identificação do cliente                  |            |                |
| TELEFONE                   | NVARCHAR (20)  | Telefone cadastrado                                 |            |                |
| TIPO_FONE                  | NVARCHAR (30)  | Tipo de telefone, como: móvel, fixo etc.            |            |                |
| ORIGEM_FONE                | NVARCHAR (30)  | Origem cadastral do telefone                        |            |                |
| STATUS                     | NVARCHAR (30)  | Status do telefone                                  |            |                |
| PERCENTUAL_LOCALIZACAO     | INT (8)        | Percentual de localização do telefone               |            |                |
| WHATSAPP                   | SMALLINT (2)   | Se o telefone possui confirmação de WhatsApp        |            |                |
| ORIGEM                     | NVARCHAR (30)  | Plataforma ou fonte origem do dado                  |            |                |
| DATA_INSERT                | DATETIME2 (19) | Momento que o dado foi inserido na tabela           |            |                |
