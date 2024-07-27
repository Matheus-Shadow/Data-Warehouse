WITH RankedData AS (
    SELECT 
        P.COD_TIT,
        A.CUSTOMER_ID,
        A.CRITERIO_CYBER,
        A.CODIGO_CLIENTE,
        A.DATA_VENCIMENTO,
        A.DATA_ATIVACAO_CLIENTE,
        ROW_NUMBER() OVER (PARTITION BY P.COD_TIT ORDER BY A.DATA_VENCIMENTO DESC) AS rn
    FROM PARCELAS P WITH (NOLOCK)
    WHERE P.[DEVOLVIDO_PARC] = '0' 
    INNER JOIN AUX_TIM_CYBER A WITH (NOLOCK) ON A.COD_PARC = P.COD_PARC
),
CTE_UNION  (CUST_CODE, INICIO_LIGACAO, DATA_FIM, USUARIO_INCLUSAO, TABULACAO, CAMPO_CHAVE, TELEFONE_ACIONADO,VALOR_CLIENTE,VALOR_ACORDO,PRODUTO,SEGMENTO,AGIN,PERFIL,ATIVACAO, COD_DEV, CPF) AS (
    select 
        A.CODIGO_CLIENTE as 'cust code',
        HC.DATA_CAD as 'Inicio da ligação',
        HC.DATA_CAD as 'Data  Hora Fim',
        L.LOGIN_LOG as 'Usuario de inclusão',
        O.TITULO_OCOR as 'Tabulação',
        CASE 
            WHEN SUBSTRING(HC.COMPLEMENTO_HIST_CLI, 1, CHARINDEX(': ', HC.COMPLEMENTO_HIST_CLI)) LIKE '%Recusa%' 
            THEN TRIM(LEFT(SUBSTRING(HC.COMPLEMENTO_HIST_CLI, CHARINDEX('-', HC.COMPLEMENTO_HIST_CLI) + 2, LEN(HC.COMPLEMENTO_HIST_CLI)), CHARINDEX(
                CASE 
                    WHEN CHARINDEX('-', SUBSTRING(HC.COMPLEMENTO_HIST_CLI, CHARINDEX('-', HC.COMPLEMENTO_HIST_CLI) + 2, LEN(HC.COMPLEMENTO_HIST_CLI))) > 0 THEN '-' 
                    ELSE ':' 
                END, SUBSTRING(HC.COMPLEMENTO_HIST_CLI, CHARINDEX('-', HC.COMPLEMENTO_HIST_CLI) + 2, LEN(HC.COMPLEMENTO_HIST_CLI))) - 1)) 
            WHEN SUBSTRING(HC.COMPLEMENTO_HIST_CLI, 1, CHARINDEX(': ', HC.COMPLEMENTO_HIST_CLI)) NOT LIKE '%Recusa%' 
            THEN '' 
        END AS CAMPO_CHAVE,
        Cast(PT.DDD_TEL as VARCHAR) + Cast(PT.NR_TEL as VARCHAR) as 'Telefone Acionado',
        SP.TOTAL as 'Valor cliente',
        BE.ValorVencimento as 'Valor acordo/Promessa',
        case 
            when Substring(A.CRITERIO_CYBER, 1, 1) = 'C' then 'Consumer' 
            when Substring(A.CRITERIO_CYBER, 1, 1) = 'B' then 'Business' 
            else Substring(A.CRITERIO_CYBER, 1, 1) + ' Não Mapeado' 
        end as 'Produto',
        case 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'PP' then 'Pós Puro' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'CT' then 'Controle' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'FX' then 'Fixo' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'OU' then 'Outros' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'WB' then 'Web' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'LV' then 'Live' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'OL' then 'Live Outros' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'OI' then 'Oi Last' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'OT' then 'Oi First' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'T5' then 'Ultra fibra Alto Valor' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'HN' then 'Churn' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'WT' then 'WTTx' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'TC' then 'Top Cliente' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'SC' then 'Small Business Controle' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'SP' then 'Small Business Pós Puro' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'T1' then 'Controle - 31 a 60 - Digital' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'T2' then 'Pós - 31 a 60 - Digital' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'U2' then 'Piloto Vencimento 7' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'U3' then 'Piloto Vencimento 7' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'V1' then 'Ação Blindagem Fibra' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'CA' then 'Controle 61 a 90 - Alto risco' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'CB' then 'Controle 61 a 90 - Baixo risco' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'PA' then 'Pós Pago 5 a 30 - Alto risco' 
            when Substring(A.CRITERIO_CYBER, 3, 2) = 'PB' then 'Pós Pago 5 a 30 - Baixo risco' 
            else Substring(A.CRITERIO_CYBER, 3, 2) + ' Não Mapeado' 
        end as 'Segmento',
        case 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'A' then 'A - 0 a 4 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'B' then 'B - 5 a 30 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'C' then 'C - 31 a 60 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'D' then 'D - 61 a 90 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'E' then 'E - 91 a 120 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'F' then 'F - 121 a 150 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'G' then 'G - 151 a 180 dias'
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'H' then 'H - 181 a 210 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'I' then 'I - 211 a 360 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'J' then 'J - 361 a 720 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'K' then 'K - 721 a 1080 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'L' then 'L - 1081 a 1800 dias' 
            when Substring(A.CRITERIO_CYBER, 2, 1) = 'M' then 'M - Maior 1800 dias' 
            else Substring(A.CRITERIO_CYBER, 2, 1) + ' Não Mapeado' 
        end as 'Agin',
        case 
            when A.CRITERIO_CYBER in ('CBCT', 'CBLV', 'CBPP', 'CCT1', 'CCT2', 'CBPA', 'CBPB') then 'Digital' 
            when A.CRITERIO_CYBER in ('CCT2', 'CBPA', 'CBPB') then 'Digital' 
            when A.CRITERIO_CYBER like '%HF%' then 'Fiber' 
            when A.CRITERIO_CYBER like '%V1%' then 'Blindagem' 
            when A.CRITERIO_CYBER like '%PA%' then 'Pré Pago' 
            when A.CRITERIO_CYBER like '%A%' then 'Pré Pago' 
            when A.CRITERIO_CYBER like '%B%' then 'Banda Larga' 
            else '' 
        end as 'Perfil',
        case 
            when A.DATA_ATIVACAO_CLIENTE <= DATEADD(day, -180, GETDATE()) then 'Sim' 
            when A.DATA_ATIVACAO_CLIENTE >= DATEADD(day, -179, GETDATE()) then 'Não' 
            else '' 
        end as 'Ativacao',
        HC.COD_DEV,
        V.CPFCGC_PES 
    from HISTORICOS_CLIENTES HC With(NoLock) 
    inner join HISTORICOS_CLIENTES_TITULOS HCT With(NoLock) on HC.COD_HIST_CLI = HCT.COD_HIST_CLI 
    inner join OCORRENCIAS_CLIENTES O With(NoLock) on O.COD_OCOR = HC.COD_OCOR and O.COD_TIPO_OCORRENCIA is not NULL 
    inner join TITULOS T With(NoLock) on T.COD_TIT = HCT.COD_TIT 
    inner join v_devedores V With(NoLock) on HC.COD_DEV = V.COD_DEV 
    left join PESSOAS_TELEFONES PT With(NoLock) on PT.COD_FONE = HC.COD_FONE 
    left join _SOMA_PARC SP With(NoLock) on SP.COD_TIT = T.COD_TIT 
    inner join LOGIN L With(NoLock) on L.COD_LOGIN = HC.USUARIO_CAD 
    inner join RankedData A on A.COD_TIT = T.COD_TIT 
    inner join (
        select H.COD_TIT,
            Max(H.COD_IMP) as COD_IMP 
        from IMPORTACAO_HISTORICO H With(NoLock) 
        group by H.COD_TIT
    ) I on I.COD_TIT = T.COD_TIT 
    left join BOLETOS_EM BE With(NoLock) on BE.Cod_BEm = HC.COD_BEM 
    inner join IMPORTACAO IM With(NoLock) on I.COD_IMP = IM.COD_IMP 
    where Cast(HC.DATA_CAD as DATE) = cast(getdate() as date)
)
select * from CTE_UNION
