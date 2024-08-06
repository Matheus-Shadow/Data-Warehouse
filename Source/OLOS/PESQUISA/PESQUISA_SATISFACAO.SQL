SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

DECLARE @dinicio DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10), DATEADD(DAY,-1 ,GETDATE()), 121) + ' 00:00:00');
DECLARE @dfim DATETIME = CONVERT(DATETIME, CONVERT(VARCHAR(10), DATEADD(DAY,-1 ,GETDATE()), 121) + ' 23:59:00');


SELECT 
    a.id AS EVENTO_ID_PLATAFORMA,
    CAST(c.StartDate AS DATE) AS DATA,
    CAST(
        CASE
            WHEN CHARINDEX('<NUMERO_CONTRATO>', c.CampaignData) > 0 THEN 
                REPLACE(
                    SUBSTRING(
                        c.CampaignData,
                        CHARINDEX('<NUMERO_CONTRATO>', c.CampaignData) + LEN('<NUMERO_CONTRATO>'),
                        CASE 
                            WHEN CHARINDEX('</NUMERO_CONTRATO>', c.CampaignData) > 0 THEN 
                                CHARINDEX('</NUMERO_CONTRATO>', c.CampaignData) - 
                                (CHARINDEX('<NUMERO_CONTRATO>', c.CampaignData) + LEN('<NUMERO_CONTRATO>'))
                            ELSE 
                                LEN(c.CampaignData)
                        END
                    ), '.', ''
                )
            ELSE NULL 
        END AS BIGINT
    ) AS ID_KEY,
    CAST(c.CallId AS BIGINT) AS CALL_ID,
    b.Campaignld AS ID_CAMPANHA,
    CAST(b.Description AS NVARCHAR(100) )AS CAMPANHA,
    c.OriginalPhoneNumber AS TELEFONE,
    NULL AS INTEGRACAO_ID,
    CAST( a.MileStoneDescription AS VARCHAR(20)) AS PERGUNTAS,
    CAST(
        CASE 
            WHEN PATINDEX('%[0-9]%', REVERSE(a.MileStoneDescription)) > 0
                THEN REVERSE(SUBSTRING(REVERSE(a.MileStoneDescription), 1, PATINDEX('%[^0-9]%', REVERSE(a.MileStoneDescription) + 't') - 1))
            ELSE NULL
        END AS INT
    ) AS RESPOSTAS,
    'OLOS' AS INTEGRACAO_PLATAFORMA,
    CAST('10.10.220.101' AS VARCHAR(13)) AS INSTANCIA,
    'RPL_OLOS' AS BANCO,
    'OLOS' AS ORIGEM
FROM AttemptsRawData c WITH (NOLOCK)
INNER JOIN milestonerawdata a WITH (NOLOCK) ON a.CallidTelecom = c.CallIdTelecom
INNER JOIN Campaign b WITH (NOLOCK) ON a.Campaignld = b.Campaignld
WHERE StartDate BETWEEN @dinicio AND @dfim