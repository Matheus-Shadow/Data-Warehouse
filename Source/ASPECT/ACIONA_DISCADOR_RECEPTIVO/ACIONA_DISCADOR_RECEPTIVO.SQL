SELECT
    CAST(DateAdd(HOUR, - 3, A.CallStartDt) AS DATE) AS DATA,
    CAST(REPLACE(C.Param3, '.', '') AS VARCHAR(20)) AS ID_KEY,
    CAST(C.Param6 AS VARCHAR(20)) AS CPF,
    CAST(A.User_Id AS NVARCHAR(60)) AS ID_AGENTE,
    CAST(CONCAT(E.User_F_Name, ' ', E.User_L_Name) AS NVARCHAR(205)) AS AGENTE,
    CAST(CONCAT(A.SeqNum, A.CallId) AS BIGINT) AS CALL_ID,
    CAST(D.Service_Id AS BIGINT) AS ID_CAMPANHA,
    CAST(D.Service_c AS NVARCHAR(600)) AS NOME_CAMPANHA,
    CAST(F.Disp_Id AS BIGINT) AS ID_TABULACAO,
    CAST(F.Disposition_Desc AS NVARCHAR(200)) AS NOME_TABULACAO,
    CAST(C.Param8 AS VARCHAR(500)) AS MAILING,
    CAST(G.ResourceGroupDesc AS VARCHAR(260)) AS ROTA,
    CAST(DateAdd(HOUR, - 3, A.CallStartDt) AS DATETIME2) AS INICIO_CHAMADA,
    CAST(DateAdd(HOUR, - 3, A.EndGaurdDt) AS DATETIME2) AS FIM_CHAMADA,
    CAST(DateAdd(HOUR, - 3, B.ConnClearDt) AS DATETIME2) AS INICIO_POS,
    CAST(DateAdd(HOUR, - 3, B.WrapEndDt) AS DATETIME2) AS FIM_POS,
    CAST(DateAdd(HOUR, - 3, B.QueueStartDt) AS DATETIME2) AS INICIO_FILA,
    CAST(DateAdd(HOUR, - 3, B.QueueEndDt) AS DATETIME2) AS FIM_FILA,
    CAST(A.ANI AS VARCHAR(25)) AS TELEFONE,
    CAST('10.12.101.21' AS VARCHAR(20)) AS INSTANCIA,
    CAST('detail_epro' AS VARCHAR(20)) AS BANCO,
    CAST('ASPECT' AS VARCHAR(30)) AS ORIGEM

FROM detail_epro..Calldetail A WITH (NOLOCK)
INNER JOIN detail_epro..ACDCallDetail B WITH (NOLOCK) ON A.CallId = B.CallId AND A.SeqNum = B.SeqNum
LEFT JOIN detail_epro..MediaDataDetail C WITH (NOLOCK) ON A.CallId = C.CallId AND A.SeqNum = C.SeqNum
LEFT JOIN config_epro.dbo.Service D WITH (NOLOCK) ON A.Service_Id = D.Service_Id
LEFT JOIN config_epro..Users E WITH (NOLOCK) ON A.User_Id = E.User_Id
LEFT JOIN config_epro..Disposition F WITH (NOLOCK) ON F.Disp_Id = B.AgentDispId
LEFT JOIN resource..ResourceGroup G WITH (NOLOCK) ON A.ResourceGroup_Id = G.ResourceGroup_Id
WHERE CAST(DateAdd(HOUR, - 3, A.CallStartDt) AS DATE) = 
CAST(GETDATE() AS DATE) AND CAST(CONCAT(CAST(A.SeqNum AS VARCHAR(10)), CAST(A.CallId AS VARCHAR(10))) AS BIGINT) > ?