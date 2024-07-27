SELECT
    CAST(A.CallStart AS DATE) AS DATA,
    CAST(CASE
        WHEN CHARINDEX('<NUMERO_CONTRATO>', A.CampaignData) > 0 THEN 
            SUBSTRING(
                A.CampaignData,
                CHARINDEX('<NUMERO_CONTRATO>', A.CampaignData) + LEN('<NUMERO_CONTRATO>'),
                CASE 
                    WHEN CHARINDEX('</NUMERO_CONTRATO>', A.CampaignData) > 0 THEN 
                        CHARINDEX('</NUMERO_CONTRATO>', A.CampaignData) - 
                        (CHARINDEX('<NUMERO_CONTRATO>', A.CampaignData) + LEN('<NUMERO_CONTRATO>'))
                    ELSE 
                        LEN(A.CampaignData)
                END
            )
        ELSE NULL 
    END AS VARCHAR(20)) AS ID_KEY,
    CAST(CASE
        WHEN CHARINDEX('<CPF_CNPJ>', A.CampaignData) > 0 THEN 
            SUBSTRING(
                A.CampaignData,
                CHARINDEX('<CPF_CNPJ>', A.CampaignData) + LEN('<CPF_CNPJ>'),
                CASE 
                    WHEN CHARINDEX('</CPF_CNPJ>', A.CampaignData) > 0 THEN 
                        CHARINDEX('</CPF_CNPJ>', A.CampaignData) - 
                        (CHARINDEX('<CPF_CNPJ>', A.CampaignData) + LEN('<CPF_CNPJ>'))
                    ELSE 
                        LEN(A.CampaignData)
                END
            )
        WHEN CHARINDEX('<CPFCNPJ>', A.CampaignData) > 0 THEN 
            SUBSTRING(
                A.CampaignData,
                CHARINDEX('<CPFCNPJ>', A.CampaignData) + LEN('<CPFCNPJ>'),
                CASE 
                    WHEN CHARINDEX('</CPFCNPJ>', A.CampaignData) > 0 THEN 
                        CHARINDEX('</CPFCNPJ>', A.CampaignData) - 
                        (CHARINDEX('<CPFCNPJ>', A.CampaignData) + LEN('<CPFCNPJ>'))
                    ELSE 
                        LEN(A.CampaignData)
                END
            )
        ELSE NULL 
    END AS VARCHAR(20)) AS CPF,
    CAST(A.Agentld AS NVARCHAR(60)) AS ID_AGENTE,
    CAST(B.Login AS NVARCHAR(205)) AS AGENTE,
    CAST(A.Callld AS BIGINT) AS CALL_ID,
    CAST(A.Campaignld AS BIGINT) AS ID_CAMPANHA,
    CAST(C.Description AS NVARCHAR(200)) AS NOME_CAMPANHA,
    CAST(A.Dispositionld AS BIGINT) AS ID_TABULACAO,
    CAST(D.Description AS NVARCHAR(200)) AS NOME_TABULACAO,
    CAST('' AS VARCHAR(500)) AS MAILING,
    CAST(A.Dnis AS NVARCHAR(50)) AS ROTA,
    CAST(A.CallStart AS DATETIME2(7)) AS INICIO_CHAMADA,
    CAST(A.CallEnd AS DATETIME2(7)) AS FIM_CHAMADA,
    CAST(A.CallEnd AS DATETIME2(7)) AS INICIO_POS,
    CAST(A.WrapEnd AS DATETIME2(7)) AS FIM_POS,
    CAST(A.QueueStart AS DATETIME2(7)) AS INICIO_FILA,
    CAST(A.QueueEnd AS DATETIME2(7)) AS FIM_FILA,
    CAST(A.Ani AS NVARCHAR(20)) AS TELEFONE,
    CAST('10.10.220.101' AS VARCHAR(20)) AS INSTANCIA,
    CAST('RPL_OLOS' AS VARCHAR(20)) AS BANCO,
    CAST('OLOS' AS NVARCHAR(30)) AS ORIGEM
FROM InboundRawData A
LEFT JOIN Users B WITH (NOLOCK) ON A.Agentld = B.Agentld
LEFT JOIN Campaign C WITH (NOLOCK) ON A.Campaignld = C.Campaignld
LEFT JOIN Disposition D WITH (NOLOCK) ON A.Dispositionld = D.DispositionId;