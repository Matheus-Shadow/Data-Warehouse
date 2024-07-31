SELECT
    CAST(DateAdd(HOUR, - 3, A.CallStartDt) AS DATE) AS DATA,
    CAST(Replace([C].[Param3], '.', '') as [varchar](20)) AS ID_KEY,
    CAST(C.Param2 AS varchar(20)) AS CPF,
    A.User_Id AS ID_AGENTE,
    CONCAT(E.User_F_Name,' ',E.User_L_Name) AS AGENTE,
    CAST(CONCAT(CAST(A.SeqNum AS VARCHAR(10)), CAST(A.CallId AS VARCHAR(10))) AS BIGINT) AS CALL_ID,
    D.Service_Id AS ID_CAMPANHA,
    D.Service_c AS NOME_CAMPANHA,
    F.Disp_Id AS ID_TABULACAO,
    F.Disposition_Desc AS NOME_TABULACAO,
    CAST(C.Param8 AS varchar(500)) AS MAILING,
    CAST(G.ResourceGroupDesc  as varchar(260))AS ROTA,
    DateAdd(HOUR, - 3, A.CallStartDt) AS INICIO_CHAMADA,
    DateAdd(HOUR, - 3, A.EndGaurdDt) AS FIM_CHAMADA,
    DateAdd(HOUR, - 3, B.ConnClearDt) AS INICIO_POS,
    DateAdd(HOUR, - 3, B.WrapEndDt) AS FIM_POS,
    CAST(A.DialedNum as varchar(20)) AS TELEFONE,
    '10.12.101.21' AS INSTANCIA,
    'detail_epro' AS BANCO,
   Cast('ASPECT' as varchar(30)) AS ORIGEM


FROM detail_epro..Calldetail A WITH (NOLOCK)
INNER JOIN detail_epro..AODCallDetail B WITH (NOLOCK) ON A.CallId = B.CallId AND A.SeqNum = B.SeqNum
LEFT JOIN detail_epro..MediaDataDetail C WITH (NOLOCK) ON A.CallId = C.CallId AND A.SeqNum = C.SeqNum
LEFT JOIN config_epro.dbo.Service D WITH (NOLOCK) ON A.Service_Id = D.Service_Id
LEFT JOIN config_epro..Users E WITH (NOLOCK) ON A.User_Id = E.User_Id
LEFT JOIN config_epro..Disposition F WITH (NOLOCK) ON F.Disp_Id = B.AgentDispId
LEFT JOIN resource..ResourceGroup G WITH (NOLOCK) ON A.ResourceGroup_Id = G.ResourceGroup_Id 
WHERE CAST(DateAdd(HOUR, - 3, A.CallStartDt) AS DATE) = 
CAST(GETDATE() AS DATE) AND CAST(CONCAT(CAST(A.SeqNum AS VARCHAR(10)), CAST(A.CallId AS VARCHAR(10))) AS BIGINT) > ?