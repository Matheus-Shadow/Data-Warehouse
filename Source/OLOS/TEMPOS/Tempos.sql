SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

DECLARE @dinicio DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10), DATEADD(DAY, - 1, GETDATE()), 121) + ' 00:00:00');
DECLARE @dfim DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10), DATEADD(DAY, - 1, GETDATE()), 121) + ' 23:59:00');
DECLARE @AuxiliarCampanhas TABLE (
	Agentld INT
	,Campaignld INT
	,INDICE INT
	);

INSERT INTO @AuxiliarCampanhas
SELECT DISTINCT Agentld
	,Campaignld
	,DENSE_RANK() OVER (
		PARTITION BY LOG.Agentld ORDER BY LOG.Campaignld
		) AS ID_NOVO
FROM LoginRawData LOG WITH (NOLOCK)
WHERE CAST(StartLogin AS DATE) = CAST(@dinicio AS DATE);


DECLARE @WORK TABLE (
	DATA DATE
	,ID_DISCADOR_OPERADOR INT
	,LOGIN_DISCADOR_OPERADOR VARCHAR(40)
	,NOME_DISCADOR_OPERADOR VARCHAR(80)
	,LOGIN_DISCADOR_SUPERVISOR VARCHAR(80)
	,LOGIN TIME
	,LOGOUT TIME
	,QTD_LOGIN INT
	,QTD_LOGOUT INT
	,TEMPO_LOGADO INT
	,TEMPO_DESLOGADO INT
    -- , ID_NOVO INT
    -- , ID_CAMPANHA INT
    -- , CAMPANHA VARCHAR(100)
	);


;WITH Working as (
SELECT CAST(StartLogin AS DATE) AS DATA
	,A.Agentld AS ID_DISCADOR_OPERADOR
	,E.LOGIN AS LOGIN_DISCADOR_OPERADOR
	,E.UserName AS NOME_DISCADOR_OPERADOR
	,C_user.UserName AS LOGIN_DISCADOR_SUPERVISOR
	,MIN(CONVERT(TIME, StartLogin, 108)) AS LOGIN
	,MAX(CONVERT(TIME, EndLogin, 108)) AS LOGOUT
	,COUNT(StartLogin) AS QTD_LOGIN
	,COUNT(EndLogin) AS QTD_LOGOUT
	,CASE 
		WHEN DATEDIFF(SECOND, LAG(EndLogin) OVER (
					PARTITION BY E.LOGIN ORDER BY StartLogin
						,EndLogin
					), StartLogin) >= 0
			THEN DATEDIFF(SECOND, LAG(EndLogin) OVER (
						PARTITION BY E.LOGIN ORDER BY StartLogin
							,EndLogin
						), StartLogin)
		ELSE 0
		END AS TEMPO_DESLOGADO
	-- ,DENSE_RANK() OVER (
	-- 	PARTITION BY A.Agentld ORDER BY A.Campaignld
	-- 	) AS ID_NOVO,
    --     A.Campaignld as ID_CAMPANHA,
    --     c.[Description] as CAMPANHA
FROM LoginRawData A
INNER JOIN Users E WITH (NOLOCK) ON A.Agentld = E.Agentld
INNER JOIN AgentSupervisor Sup WITH (NOLOCK) ON Sup.AgentId = E.Agentld
INNER JOIN Users C_user WITH (NOLOCK) ON Sup.SupervisorId = C_user.Agentld
--INNER JOIN Campaign C WITH (NOLOCK) ON C.Campaignld = A.Campaignld
WHERE StartLogin BETWEEN @dinicio
		AND @dfim
GROUP BY CAST(StartLogin AS DATE)
	,A.Agentld
	,E.LOGIN
	,E.UserName
	,C_user.UserName ,StartLogin, EndLogin

)


INSERT INTO @WORK

SELECT  
    W.[DATA]
    ,W.ID_DISCADOR_OPERADOR
    ,W.LOGIN_DISCADOR_OPERADOR
    ,W.NOME_DISCADOR_OPERADOR
    ,W.LOGIN_DISCADOR_SUPERVISOR
    ,MIN(W.[LOGIN]) AS LOGIN
    ,MAX(W.LOGOUT) AS LOGOUT 
    ,SUM(W.QTD_LOGIN) AS QTD_LOGIN
    ,SUM(QTD_LOGOUT) AS QTD_LOGOUT
    ,DATEDIFF(SECOND, MIN(W.[LOGIN]),MAX(W.LOGOUT)) AS TEMPO_LOGADO
    ,SUM(TEMPO_DESLOGADO) AS TEMPO_DESLOGADO

FROM Working W 

GROUP BY W.[DATA]
    ,W.ID_DISCADOR_OPERADOR
    ,W.LOGIN_DISCADOR_OPERADOR
    ,W.NOME_DISCADOR_OPERADOR
    ,W.LOGIN_DISCADOR_SUPERVISOR;


DECLARE @Ligacoes TABLE (
    Agentld INT,
    TEMPO_FALADO INT,
    TEMPO_IDLE INT,
    TEMPO_POS INT,
    TEMPO_DISPONIVEL INT,
    TEMPO_PAUSA INT,
    ATENDIDAS INT
);

WITH Calls AS (
    SELECT 
        Agent.Agentld,
        CASE WHEN [Description] IN ('Talking') THEN
            DATEDIFF(SECOND, Agent.StartState, Agent.EndState) 
        END AS TEMPO_FALADO,
        CASE WHEN [Description] IN ('Idle') THEN
            DATEDIFF(SECOND, Agent.StartState, Agent.EndState) 
        END AS TEMPO_IDLE,
        CASE WHEN [Description] IN ('Wrap') THEN
            DATEDIFF(SECOND, Agent.StartState, Agent.EndState) 
        END AS TEMPO_POS,
        CASE WHEN [Description] IN ('Pause') THEN
            DATEDIFF(SECOND, Agent.StartState, Agent.EndState) 
        END AS TEMPO_PAUSA,
        CASE WHEN [Description] IN ('Wrap', 'Idle', 'Talking') THEN
            DATEDIFF(SECOND, Agent.StartState, Agent.EndState) 
        END AS TEMPO_DISPONIVEL,
        CASE WHEN ([Description] IN ('Talking') AND Callld != 0) THEN 1 ELSE 0 END AS ATENDIDAS,
        CASE 
            WHEN (
                LAG(DATEDIFF(SECOND, StartState, EndState)) OVER (
                    PARTITION BY Agent.Agentld ORDER BY Agent.AgentStateRawDatalD ASC
                )
            ) - DATEDIFF(SECOND, StartState, EndState) = 0
            THEN 0
            ELSE 1
        END AS ID
    FROM AgentStateRawData Agent WITH (NOLOCK)
    INNER JOIN Info_AgentStatus Info ON Info.AgentStatusId = Agent.AgentStatus
    WHERE CAST(StartState AS DATE) = CAST(@dinicio AS DATE)
    --ORDER BY Agent.AgentStateRawDatalD ASC
)

INSERT INTO @Ligacoes
SELECT 
    Agentld,
    SUM(TEMPO_FALADO) AS TEMPO_FALADO,
    SUM(TEMPO_IDLE) AS TEMPO_IDLE,
    SUM(TEMPO_POS) AS TEMPO_POS,
    SUM(TEMPO_DISPONIVEL) AS TEMPO_DISPONIVEL,
    SUM(TEMPO_PAUSA) AS TEMPO_PAUSA,
    SUM(ATENDIDAS) AS ATENDIDAS
FROM Calls
WHERE ID = 1
GROUP BY Agentld;
--1142

SELECT 
    w.[DATA],
    C.Campaignld AS ID_CAMPANHA,
    C.[Description] AS CAMPANHA,
    w.ID_DISCADOR_OPERADOR,
    w.LOGIN_DISCADOR_OPERADOR,
    w.NOME_DISCADOR_OPERADOR,
    w.LOGIN_DISCADOR_SUPERVISOR,
    w.[LOGIN] AS LOGIN,
    w.LOGOUT AS LOGOUT,
    w.QTD_LOGIN AS QTD_LOGIN,
    w.QTD_LOGOUT AS QTD_LOGOUT,
    Calls.ATENDIDAS AS ATENDIDAS,
    DATEDIFF(SECOND, w.[LOGIN], w.LOGOUT) AS TEMPO_LOGADO,
    Calls.TEMPO_PAUSA AS TEMPO_PAUSA,
    w.TEMPO_DESLOGADO AS TEMPO_DESLOGADO,
    Calls.TEMPO_FALADO AS TEMPO_FALADO,
    Calls.TEMPO_DISPONIVEL AS TEMPO_DISPONIVEL,
    Calls.TEMPO_POS AS TEMPO_POS,
    Calls.TEMPO_IDLE AS TEMPO_IDLE,
    CASE 
        WHEN ISNULL(Calls.ATENDIDAS, 0) = 0 THEN 0
        ELSE ISNULL(Calls.TEMPO_FALADO, 0) / ISNULL(Calls.ATENDIDAS, 0)
    END AS TMA,
    CASE 
        WHEN ISNULL(Calls.ATENDIDAS, 0) = 0 THEN 0
        ELSE ISNULL(Calls.TEMPO_POS, 0) / ISNULL(Calls.ATENDIDAS, 0)
    END AS TMP,
    CASE 
        WHEN ISNULL(Calls.ATENDIDAS, 0) = 0 THEN 0
        ELSE ISNULL(Calls.TEMPO_IDLE, 0) / ISNULL(Calls.ATENDIDAS, 0)
    END AS TME,
    CASE
      WHEN ISNULL(ATENDIDAS,0) = 0
        THEN 0
        ELSE 
    (ISNULL(TEMPO_FALADO, 0) / ISNULL(ATENDIDAS, 0)) + (ISNULL(TEMPO_POS, 0) / ISNULL(ATENDIDAS, 0)) END AS TMO,
	'10.10.220.101' AS INSTANCIA,
    DB_NAME() AS BANCO,
    'OLOS' AS ORIGEM
FROM @WORK w
INNER JOIN @AuxiliarCampanhas AS AC ON AC.Agentld = w.ID_DISCADOR_OPERADOR
INNER JOIN Campaign AS C ON C.Campaignld = AC.Campaignld
INNER JOIN @Ligacoes AS Calls ON Calls.Agentld = w.ID_DISCADOR_OPERADOR
WHERE w.[DATA] = CAST(@dinicio AS DATE)
    AND AC.INDICE = 1;



