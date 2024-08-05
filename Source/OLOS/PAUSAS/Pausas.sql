SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

DECLARE @dinicio DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10), GETDATE(), 121) + ' 00:00:00');
DECLARE @dfim DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10), GETDATE(), 121) + ' 23:59:00');

;WITH TEMPOS AS (
    SELECT 
        CAST(A.StartState AS DATE) AS DATA,
        B.Campaignld AS ID_CAMPANHA,
        B.[Description] AS CAMPANHA,
        A.Agentld AS ID_DISCADOR_OPERADOR,
        E.[Login] AS LOGIN_DISCADOR_OPERADOR,
        E.UserName AS NOME_DISCADOR_OPERADOR,
        CONVERT(TIME, A.StartState, 108) AS INICIO_PAUSA,
        CONVERT(TIME, A.EndState, 108) AS FIM_PAUSA,
        D.[Description] AS NOME_PAUSA,
        DATEDIFF(SECOND, A.StartState, A.EndState) AS TEMPO_PAUSA,
        1 AS QTD_PAUSA,
        A.Reason AS ID_PAUSA,
        CASE 
            WHEN LAG(DATEDIFF(SECOND, A.StartState, A.EndState)) OVER (
                    PARTITION BY A.Agentld, D.[Description] 
                    ORDER BY A.AgentStateRawDatalD ASC) - DATEDIFF(SECOND, A.StartState, A.EndState) = 0
                THEN 0
            ELSE 1
        END AS id_onovo,
        '10.10.220.101' AS INSTANCIA,
        DB_NAME() AS BANCO,
        'OLOS' AS ORIGEM
    FROM AgentStateRawData A WITH (NOLOCK)
    INNER JOIN Campaign B ON A.Campaignld = B.Campaignld
    INNER JOIN Info_AgentStatus C ON A.AgentStatus = C.AgentStatusId
    LEFT JOIN Reason D ON A.Reason = D.Reasonld
    INNER JOIN Users E ON A.Agentld = E.Agentld
    WHERE A.StartState BETWEEN @dinicio AND @dfim
        AND D.[Description] IS NOT NULL
)

SELECT 
    DATA,
    ID_CAMPANHA,
    CAMPANHA,
    ID_DISCADOR_OPERADOR,
    LOGIN_DISCADOR_OPERADOR,
    NOME_DISCADOR_OPERADOR,
    INICIO_PAUSA,
    FIM_PAUSA,
    NOME_PAUSA,
    TEMPO_PAUSA,
    QTD_PAUSA,
    ID_PAUSA,
    INSTANCIA,
    BANCO,
    ORIGEM
FROM TEMPOS WITH (NOLOCK)
WHERE id_onovo = 1;