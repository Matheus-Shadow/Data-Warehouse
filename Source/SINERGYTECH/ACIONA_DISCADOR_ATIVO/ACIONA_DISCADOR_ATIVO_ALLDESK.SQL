SELECT
    CAST(Data_Hora AS DATE) AS DATA,
    CAST(CPF_CNPJ AS varchar(20)) as ID_KEY,
    CAST(CPF_CNPJ AS varchar(20)) AS CPF,
    Cast(ID_Agente as nvarchar(60)) AS ID_AGENTE,
    Cast(Agente as nvarchar(60)) AS AGENTE,
    Cast(Identificador_Chamada as bigint) AS CALL_ID,
    Id_Campanha AS ID_CAMPANHA,
    CAST(Campanha AS NVARCHAR(600)) AS NOME_CAMPANHA,
    Id_Ultima_Interacao AS ID_TABULACAO,
    CAST(
            CASE
                WHEN Acionamentos_alldesk.Ultima_Interacao = '' THEN Acionamentos_alldesk.Resultado
             ELSE Acionamentos_alldesk.Ultima_Interacao
    END AS VARCHAR(20)) AS NOME_TABULACAO,
    Lote AS MAILING,
    Rota AS ROTA,
    CAST(Data_Hora AS datetime2) AS INICIO_CHAMADA,
    CAST(Data_Hora AS datetime2) AS FIM_CHAMADA,
    CAST(''AS datetime2) AS INICIO_POS,
    CAST('' AS datetime2) AS FIM_POS,
    DDD_Telefone AS TELEFONE,
    CAST('187.32.251.237' AS varchar(20)) AS INSTANCIA,
    CAST('MMeireles_freitas_all' AS varchar(20)) AS BANCO,
    CAST('SINERGYTECH' AS varchar(30)) AS ORIGEM

FROM Acionamentos_alldesk WITH (NOLOCK)
WHERE
CAST(Data_Hora AS DATE) = CAST(GETDATE() AS DATE) AND Cast(Identificador_Chamada as bigint) > ?