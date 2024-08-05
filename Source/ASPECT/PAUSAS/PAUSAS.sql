SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

DECLARE @dinicio DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10), DATEADD(DAY,-1,GETDATE()) , 121) + ' 00:00:00');
DECLARE @dfim DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()) , 121) + ' 23:59:00');

-- Common Table Expression (CTE) para calcular os tempos de pausa
WITH PausasCTE
AS (
	SELECT CAST(DATEADD(HOUR, - 3, pausas.LoginDt) AS DATE) AS DATA
		,SER.Service_Id AS ID_CAMPANHA
		,SER.Service_c AS CAMPANHA
		,t1.WorkGroup_Id AS ID_DISCADOR_OPERADOR
		,pausas.User_Id AS LOGIN_DISCADOR_OPERADOR
		,USR.User_F_Name + ' ' + USR.User_L_Name AS NOME_DISCADOR_OPERADOR
		,CONVERT(TIME, DATEADD(HOUR, - 3, pausas.NotReadyStartDt), 108) AS INICIO_PAUSA
		,CONVERT(TIME, DATEADD(HOUR, - 3, pausas.NotReadyEndDt), 108) AS FIM_PAUSA
		,SUM(CASE 
				WHEN pausas.NotReadyEndDt <= @dfim
					THEN pausas.NotReadyTime
				ELSE DATEDIFF(SECOND, pausas.NotReadyStartDt, @dfim)
				END) AS TEMPO_PAUSA
		,ISNULL(p.[Description], 'OUTRAS') AS NOME_PAUSA
		,COUNT(pausas.NotReadyStartDt) AS QTD_PAUSA
		,p.ReasonId AS ID_PAUSA
		
		,DENSE_RANK() OVER (
			PARTITION BY pausas.User_Id ORDER BY SER.Service_c
			) AS ID_NOVO
	FROM summary_epro..[AgentNotReadySummary] pausas WITH (NOLOCK)
	LEFT JOIN config_epro..AgentStatusReason p ON p.ReasonId = pausas.ReasonId
	LEFT JOIN summary_epro..[AgentSignInSummary] AS t1 WITH (NOLOCK) ON t1.User_Id = pausas.User_Id
		AND DATEADD(HOUR, - 3, t1.LoginDt) BETWEEN @dinicio
			AND @dfim
	LEFT JOIN config_epro..Service_Group SERG ON SERG.User_Id = pausas.User_Id
	LEFT JOIN config_epro..Service SER ON SERG.Service_Id = SER.Service_Id
	INNER JOIN config_epro..Users USR ON USR.User_Id = pausas.User_Id
	WHERE DATEADD(HOUR, - 3, pausas.LoginDt) BETWEEN @dinicio
			AND @dfim
	GROUP BY CAST(DATEADD(HOUR, - 3, pausas.LoginDt) AS DATE)
		,t1.WorkGroup_Id
		,pausas.User_Id
		,p.[Description]
		,p.ReasonId
		,CONVERT(TIME, DATEADD(HOUR, - 3, pausas.NotReadyStartDt), 108)
		,CONVERT(TIME, DATEADD(HOUR, - 3, pausas.NotReadyEndDt), 108)
		,SER.Service_c
		,USR.User_F_Name
		,USR.User_L_Name
		,SER.Service_Id
	)
SELECT [DATA]
	,ID_CAMPANHA
	,CAMPANHA
	,ID_DISCADOR_OPERADOR
	,LOGIN_DISCADOR_OPERADOR
	,NOME_DISCADOR_OPERADOR
	,INICIO_PAUSA
	,FIM_PAUSA
    ,TEMPO_PAUSA
    ,NOME_PAUSA
	,QTD_PAUSA
	,ID_PAUSA
	, '10.12.101.21' as INSTANCIA 
	, 'detail_epro' AS BANCO
	, 'ASPECT' AS ORIGEM
FROM PausasCTE
WHERE LOGIN_DISCADOR_OPERADOR != 'rstaspectagent'
	AND ID_NOVO = 1
    AND [DATA] = CAST(@dinicio  AS date)
