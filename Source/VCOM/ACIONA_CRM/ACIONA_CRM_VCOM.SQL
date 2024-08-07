SELECT 
  CAST(HC.DATA_CAD AS DATE) AS DATA,
  CAST('230' AS INT) AS COD_CRM,
  CAST(HC.COD_HIST_CLI AS bigint) AS ACIONAMENTO_ID,
  CAST(REPLACE(A.CODIGO_CLIENTE, '.', '') AS BIGINT) AS ID_KEY,
  CAST(L.COD_LOGIN AS BIGINT) AS ID_CRM_OPERADOR,
  CAST(L.LOGIN_LOG AS NVARCHAR(100)) AS NOME_CRM_OPERADOR,
  CAST(O.COD_OCOR AS BIGINT) AS ID_AC,
  CAST(O.TITULO_OCOR AS NVARCHAR(200)) AS NOME_AC,
  CAST('' AS BIGINT) AS ID_SUB_AC,
    CAST(CASE 
        WHEN SUBSTRING(HC.COMPLEMENTO_HIST_CLI, 1, CHARINDEX(': ', HC.COMPLEMENTO_HIST_CLI)) LIKE '%Recusa%'
        THEN TRIM(LEFT(SUBSTRING(HC.COMPLEMENTO_HIST_CLI, CHARINDEX('-', HC.COMPLEMENTO_HIST_CLI) + 2, LEN(HC.COMPLEMENTO_HIST_CLI)), CHARINDEX(CASE 
            WHEN CHARINDEX('-', SUBSTRING(HC.COMPLEMENTO_HIST_CLI, CHARINDEX('-', HC.COMPLEMENTO_HIST_CLI) + 2, LEN(HC.COMPLEMENTO_HIST_CLI))) > 0
            THEN '-' ELSE ':' END, SUBSTRING(HC.COMPLEMENTO_HIST_CLI, CHARINDEX('-', HC.COMPLEMENTO_HIST_CLI) + 2, LEN(HC.COMPLEMENTO_HIST_CLI))) - 1))
        WHEN SUBSTRING(HC.COMPLEMENTO_HIST_CLI, 1, CHARINDEX(': ', HC.COMPLEMENTO_HIST_CLI)) NOT LIKE '%Recusa%'
        THEN ''
    END AS NVARCHAR(200)) AS NOME_SUB_AC,
 CAST(HC.DATA_CAD AS DATETIME2(7)) AS INICIO_CHAMADA,
 CAST(HC.DATA_CAD AS DATETIME2(7)) AS FIM_CHAMADA,
 CAST(Cast(PT.DDD_TEL as VARCHAR) + Cast(PT.NR_TEL as VARCHAR) AS NVARCHAR(20)) AS TELEFONE,
 CAST('52.179.19.141' AS VARCHAR(20)) AS INSTANCIA,
 CAST('MF_cobsystems' AS VARCHAR(20)) AS BANCO,
 CAST('VCOM' AS NVARCHAR(30)) AS ORIGEM
from HISTORICOS_CLIENTES HC With(NoLock) 
  inner join HISTORICOS_CLIENTES_TITULOS HCT With(NoLock) on HC.COD_HIST_CLI = HCT.COD_HIST_CLI 
  inner join OCORRENCIAS_CLIENTES O With(NoLock) on O.COD_OCOR = HC.COD_OCOR and O.COD_TIPO_OCORRENCIA is not NULL 
  inner join TITULOS T With(NoLock) on T.COD_TIT = HCT.COD_TIT 
  inner join v_devedores V With(NoLock) on HC.COD_DEV = V.COD_DEV 
  left join PESSOAS_TELEFONES PT With(NoLock) on PT.COD_FONE = HC.COD_FONE 
  left join _SOMA_PARC SP With(NoLock) on SP.COD_TIT = T.COD_TIT 
  inner join LOGIN L With(NoLock) on L.COD_LOGIN = HC.USUARIO_CAD 
  inner join 
  (
  select P.COD_TIT,
    Max(A.CUSTOMER_ID) as CUSTOMER_ID,
    Max(A.CRITERIO_CYBER) as CRITERIO_CYBER,
    Max(A.CODIGO_CLIENTE) as CODIGO_CLIENTE,
    Max(A.DATA_ATIVACAO_CLIENTE) as DATA_ATIVACAO_CLIENTE 
  from PARCELAS P With(NoLock) 
    inner join AUX_TIM_CYBER A With(NoLock) on A.COD_PARC = P.COD_PARC 
  group by P.COD_TIT
  ) A on A.COD_TIT = T.COD_TIT 
  inner join 
  (
  select H.COD_TIT,
    Max(H.COD_IMP) as COD_IMP 
  from IMPORTACAO_HISTORICO H With(NoLock) 
  group by H.COD_TIT
  ) I on I.COD_TIT = T.COD_TIT 
  left join BOLETOS_EM BE With(NoLock) on BE.Cod_BEm = HC.COD_BEM 
  inner join IMPORTACAO IM With(NoLock) on I.COD_IMP = IM.COD_IMP 
where Cast(HC.DATA_CAD as DATE) = CAST(GETDATE() AS date)