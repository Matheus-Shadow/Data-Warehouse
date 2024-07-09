# Metadados - Acionamentos do Discador Outbound

## Colunas

| Nome da Coluna       | Tipo de Dados | Descrição                                          | Restrições | Relacionamento |
|----------------------|---------------|----------------------------------------------------|------------|----------------|
| EVENTO_ID            | BIGINT (19)   | ID do acionamento no DW                            |PK,IDENTITY |                |
| DATA                 | DATE (10)     | Data da discagem                                   |            |                |
| ID_KEY               | NVARCHAR (20) | Número de identificação do cliente                 |            |                |
| CPF                  | NVARCHAR (20) | CPF do cliente                                     |            |                |
| ID_AGENTE            | NVARCHAR (30) | ID do operador ou login                            |            |                |
| AGENTE               | NVARCHAR (100)| Nome do operador ou login                          |            |                |
| CALL_ID              | BIGINT (19)   | ID da chamada                                      |            |                |
| ID_CAMPANHA          | BIGINT (19)   | ID da campanha discada                             |            |                |
| NOME_CAMPANHA        | NVARCHAR (200)| Nome da campanha discada                           |            |                |
| ID_TABULACAO         | BIGINT (19)   | ID da tabulação                                    |            |                |
| NOME_TABULACAO       | NVARCHAR (200)| Nome da tabulação                                  |            |                |
| MAILING              | NVARCHAR (250)| Mailing registrado atrelado à campanha             |            |                |
| ROTA                 | NVARCHAR (50) | Rota atrelada à discagem                           |            |                |
| INICIO_CHAMADA       | DATETIME2 (19)| Início da discagem                                 |            |                |
| FIM_CHAMADA          | DATETIME2 (19)| Fim da discagem                                    |            |                |
| INICIO_POS           | DATETIME2 (19)| Início do pós atendimento                          |            |                |
| FIM_POS              | DATETIME2 (19)| Fim do pós atendimento                             |            |                |
| TELEFONE             | NVARCHAR (20) | Telefone discado                                   |            |                |
| ORIGEM               | NVARCHAR (30) | Plataforma ou fonte origem do dado                 |            |                |
| DATA_INSERT          | DATETIME2 (19)| Momento que o dado foi inserido na tabela          |            |                |
