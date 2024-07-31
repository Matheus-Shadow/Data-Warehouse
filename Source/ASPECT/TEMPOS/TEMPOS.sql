SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;


DECLARE @dinicio DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10), GETDATE(), 121) + ' 00:00:00');

DECLARE @dfim  DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10), GETDATE(), 121) + ' 23:59:00');


DECLARE @ligacoes TABLE (
    DATA DATE
    ,LOGIN VARCHAR(30)
    ,TotalAgentCalls INT
    ,TotalAgentTime INT
    ,PreviewTime INT
    ,PreviewQt INT
    ,ActiveTime INT
    ,WrapTime INT
    )

INSERT INTO @ligacoes
SELECT cast(DATEADD(HOUR, - 3, BeginTimePeriodDt) AS DATE) AS DATA
    ,user_id AS LOGIN
    ,Sum([TotalAgentCalls])
    ,Sum([TotalAgentTime])
    ,Sum([PreviewTime])
    ,Sum(CASE 
            WHEN [PreviewTime] > 0
                THEN 1
            ELSE 0
            END) AS PreviewQt
    ,Sum([ActiveTime])
    ,Sum([WrapTime])
FROM summary_epro..[MediaAgentSummary] WITH (NOLOCK)
WHERE DATEADD(HOUR, - 3, BeginTimePeriodDt) BETWEEN @dinicio
        AND @dfim
GROUP BY cast(DATEADD(HOUR, - 3, BeginTimePeriodDt) AS DATE)
    ,user_id

-- Criação da tabela temporária
DECLARE @work TABLE (
    DATA DATE
    ,ID_DISCADOR_OPERADOR VARCHAR(30)
    ,LOGIN_DISCADOR_OPERADOR VARCHAR(100)
    ,NOME_DISCADOR_OPERADOR VARCHAR(100)
    ,LOGIN_DISCADOR_SUPERVISOR VARCHAR(100)
    ,LOGIN TIME
    ,LOGOUT TIME
    ,QTD_LOGIN INT
    ,QTD_LOGOUT INT
    ,TEMPO_LOGADO INT
    ,TEMPO_DISPONIVEL INT
    ,TEMPO_IDLE INT
    , CAMPANHA VARCHAR(20)
    , ID_CAMPANHA INT
    , ID_NOVO INT
    
    );

-- Inserção de dados na tabela temporária
INSERT INTO @work
SELECT CAST(DATEADD(HOUR, - 3, t1.LoginDt) AS DATE) AS DATA
    ,t1.WorkGroup_Id AS ID_DISCADOR_OPERADOR
    ,t1.User_Id AS LOGIN_DISCADOR_OPERADOR
    ,USR.User_F_Name + ' ' + USR.User_L_Name AS NOME_DISCADOR_OPERADOR
    ,[WK].[Workgroup_Name] AS LOGIN_DISCADOR_SUPERVISOR
        
    ,MIN(DATEADD(HOUR, - 3, t1.LoginDt)) AS LOGIN
    ,MAX(DATEADD(HOUR, - 3, ISNULL(t1.LogoutDt, @dfim))) AS LOGOUT
    ,COUNT(t1.LoginDt) AS QTD_LOGIN
    ,COUNT(t1.LogoutDt) AS QTD_LOGOUT
    ,SUM(CASE 
            WHEN t1.LogoutDt IS NOT NULL
                THEN t1.LoginTime
            ELSE DATEDIFF(SECOND, t1.LoginDt, ISNULL(t1.LogoutDt, @dfim))
            END) AS TEMPO_LOGADO
    ,SUM(t1.GapTime) AS TEMPO_DISPONIVEL
    ,SUM(t1.IdleTime) AS TEMPO_IDLE
    ,(SER.Service_c) AS CAMPANHA  
    ,(SER.Service_Id) AS ID_CAMPANHA
    ,DENSE_RANK() OVER (
            PARTITION BY t1.User_Id  ORDER BY SER.Service_c
            ) AS ID_NOVO
FROM summary_epro..[AgentSignInSummary] t1 WITH (NOLOCK)
INNER JOIN config_epro..[Workgroup] wk WITH (NOLOCK) ON t1.Workgroup_Id = wk.Workgroup_Id
INNER JOIN [config_epro]..[Service_Group] AS [SERG] WITH (NOLOCK) ON [SERG].[User_Id] = t1.User_Id
INNER  JOIN [config_epro]..[Service] AS SER  WITH (NOLOCK) ON SER.Service_Id = SERG.Service_Id
JOIN [config_epro]..[Users] AS [USR] WITH (NOLOCK) ON [SERG].[User_Id] = [USR].[User_Id]
WHERE DATEADD(HOUR, - 3, t1.LoginDt) BETWEEN @dinicio
        AND @dfim
GROUP BY CAST(DATEADD(HOUR, - 3, t1.LoginDt) AS DATE)
    ,t1.User_Id
    ,t1.WorkGroup_Id
    ,wk.Workgroup_Name
    ,USR.User_F_Name + ' ' + USR.User_L_Name 
    ,(SER.Service_c) 
    ,(SER.Service_Id)

-- Consulta dos dados na tabela temporária
SELECT w.DATA
    ,w.ID_CAMPANHA
    ,w.CAMPANHA
    ,w.ID_DISCADOR_OPERADOR
    ,w.LOGIN_DISCADOR_OPERADOR
    ,w.NOME_DISCADOR_OPERADOR
    ,w.LOGIN_DISCADOR_SUPERVISOR
    ,w.LOGIN
    ,w.LOGOUT
    ,w.QTD_LOGIN
    ,w.QTD_LOGOUT
    ,isnull(l.TotalAgentCalls, 0) AS ATENDIDAS
    ,w.TEMPO_LOGADO
    ,
    -- Calcula o total de segundos
    DATEDIFF(SECOND, w.LOGIN, w.LOGOUT) - IIF(DATEDIFF(SECOND, w.LOGIN, w.LOGOUT) - w.TEMPO_LOGADO > 0, w.TEMPO_LOGADO, 0) AS TEMPO_DESLOGADO
    ,ISNULL(l.ActiveTime, 0) + ISNULL(l.WrapTime, 0) + w.TEMPO_IDLE AS TEMPO_DISPONIVEL
    ,
    -- Tempo de pausa em segundos
    w.TEMPO_LOGADO - (ISNULL(l.ActiveTime, 0) + ISNULL(l.WrapTime, 0) + w.TEMPO_IDLE) AS TEMPO_PAUSA
    ,
    -- Tempo falado em segundos
    ISNULL(l.ActiveTime, 0) AS TEMPO_FALADO
    ,
    -- Tempo de pós-atendimento em segundos
    ISNULL(l.WrapTime, 0) AS TEMPO_POS
    ,
    -- Calcula o tempo deslogado em segundos
    w.TEMPO_IDLE,
    ISNULL(l.ActiveTime, 0)  /  isnull(l.TotalAgentCalls, 0)  AS TMA ,
    ISNULL(l.WrapTime, 0)  /  isnull(l.TotalAgentCalls, 0)  AS TMP ,
    w.TEMPO_IDLE /  isnull(l.TotalAgentCalls, 0)  AS TME ,
   ( ISNULL(l.ActiveTime, 0)  /  isnull(l.TotalAgentCalls, 0)) + (ISNULL(l.WrapTime, 0)  /  isnull(l.TotalAgentCalls, 0) ) AS TMO
    , '10.12.101.21' as INSTANCIA 
    , 'detail_epro' AS BANCO
    , 'ASPECT' AS ORIGEM
  
FROM @work w
LEFT JOIN @ligacoes l ON (
        l.DATA = w.DATA
        AND l.LOGIN = w.LOGIN_DISCADOR_OPERADOR
        )

WHERE w.ID_NOVO = 1
AND w.LOGIN_DISCADOR_OPERADOR != 'rstaspectagent'
and w.DATA = cast(@dinicio as date)