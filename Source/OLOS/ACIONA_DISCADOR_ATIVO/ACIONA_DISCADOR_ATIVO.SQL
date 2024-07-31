SELECT
    CAST(A.StartDate AS DATE) AS DATA,
    CASE
        WHEN CHARINDEX('<NUMERO_CONTRATO>', A.CampaignData) > 0 THEN 
            REPLACE(
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
                ), '.', ''
            )
        ELSE NULL 
    END AS ID_KEY,
    CASE
        WHEN CHARINDEX('<CPF_CNPJ>', A.CampaignData) > 0 THEN 
            REPLACE(
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
                ), '.', ''
            )
        WHEN CHARINDEX('<CPFCNPJ>', A.CampaignData) > 0 THEN 
            REPLACE(
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
                ), '.', ''
            )
        ELSE NULL 
    END AS CPF,
    CAST(A.Agentld AS NVARCHAR(60)) AS ID_AGENTE,
    B.Login  AS AGENTE,
    A.CallId AS CALL_ID,
    A.Campaignld AS ID_CAMPANHA,
    C.Description AS NOME_CAMPANHA,
    A.Dispositionld AS ID_TABULACAO,
    D.Description AS NOME_TABULACAO,
    A.TableName AS MAILING,
    A.Route AS ROTA,
    A.StartDate AS INICIO_CHAMADA,
    A.EndCall AS FIM_CHAMADA,
    A.StartDate AS INICIO_POS,
    A.EndWrap AS FIM_POS,
    A.OriginalPhoneNumber AS TELEFONE,
    '10.10.220.101' AS INSTANCIA,
    'RPL_OLOS' AS BANCO,
    'OLOS' AS ORIGEM

FROM AttemptsRawData A
LEFT JOIN Users B WITH (NOLOCK) ON A.Agentld = B.Agentld
LEFT JOIN Campaign C WITH (NOLOCK) ON A.Campaignld = C.Campaignld
LEFT JOIN Disposition D WITH (NOLOCK) ON A.Dispositionld = D.DispositionId
where CAST(A.StartDate AS DATE) = CAST(GETDATE() AS DATE) and A.CallId > ?