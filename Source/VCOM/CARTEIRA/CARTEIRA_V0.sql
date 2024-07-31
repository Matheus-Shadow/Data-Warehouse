SELECT TOP 10 
  CAST(GETDATE() AS DATE) AS DATA,
  230 AS ID_CRM, 
  CONCAT(D.CPFCGC_PES,A.CODIGO_CLIENTE ) as ID_CLI,
  D.CPFCGC_PES AS CPF,
  A.CODIGO_CLIENTE AS DEVEDOR_ID,
  T.COD_DEV AS IDENTIFICADOR_ID,
  NULL AS TITULO_ID,
  T.CONTRATO_TIT AS CONTRATO_ID,
  A.NUMERO_DOCUMENTO_CLIENTE AS DOCUMENTO_ID,
  PE.NOME_PES AS NOME,
  CV.UF AS UF,
  CV.CIDADE AS CIDADE,
  PE.BAIRRO_PES AS BAIRRO,
  PE.CEP_PES AS CEP,
  PE.SEXO_PES AS SEXO,
  PE.DT_NASC AS DATA_NASCIMENTO,
  NULL AS TIPO_TITULO,
  A.CRITERIO_CYBER AS SEGMENTO,
  A.NUMERO_PARC AS NUMERO_PRESTACAO,
  NULL AS QTD_PRESTACAO,
  NULL AS NUMERO_BANCO,
  NULL AS SETOR,
  SP.TOTAL AS VALOR,
  A.VR_ORIG_PARC AS VALOR_ORIGINAL,
  NULL AS LOTE,
  SP.MENOR_VCTO AS DATA_VENCIMENTO,
  NULL AS DATA_VENCIMENTO_ORIGINAL,
  I.DATA_IMP AS DATA_IMPORTACAO,
  NULL AS OBSE,
  NULL AS DATA_DEVOLUCAO,
  A.DATA_ATIVACAO_CLIENTE AS DATA_INCLUSAO,
  I.DATA_IMP AS DATA_ALTERACAO,
  NULL AS USUARIO_INCLUSAO,
  NULL AS USUARIO_ALTERACAO,
  NULL AS IMP_ID,
  NULL AS ACORDO_ID,
  A.TIPO_PRODUTO,
  '52.179.19.141' AS INSTANCIA,
  'MF_cobsystems' AS BANCO ,
  'VCOM' AS ORIGEM
FROM TITULOS T WITH (NOLOCK)
INNER JOIN _SOMA_PARC SP WITH (NOLOCK) ON SP.COD_TIT = T.COD_TIT
INNER JOIN v_devedores D WITH (NOLOCK) ON T.COD_DEV = D.COD_DEV
INNER JOIN (
  SELECT 
    P.COD_TIT,
    MAX(A.CUSTOMER_ID) AS CUSTOMER_ID,
    MAX(A.CRITERIO_CYBER) AS CRITERIO_CYBER,
    MAX(A.NUMERO_DOCUMENTO_CLIENTE) AS NUMERO_DOCUMENTO_CLIENTE,
    MAX(A.CODIGO_CLIENTE) AS CODIGO_CLIENTE,
    MAX(A.DATA_ATIVACAO_CLIENTE) AS DATA_ATIVACAO_CLIENTE,
    MAX(A.TIPO_PRODUTO) AS TIPO_PRODUTO,
    MAX(P.NUMERO_PARC) AS NUMERO_PARC,
    MAX(P.VR_ORIG_PARC) AS VR_ORIG_PARC
  FROM PARCELAS P WITH (NOLOCK)
  INNER JOIN AUX_TIM_CYBER A WITH (NOLOCK) ON A.COD_PARC = P.COD_PARC
  WHERE P.DEVOLVIDO_PARC = '0'
  GROUP BY P.COD_TIT, A.TIPO_PRODUTO
) A ON A.COD_TIT = T.COD_TIT
INNER JOIN (
  SELECT 
    H.COD_TIT,
    MAX(I.DATA_IMP) AS DATA_IMP
  FROM IMPORTACAO_HISTORICO H WITH (NOLOCK)
  INNER JOIN IMPORTACAO I WITH (NOLOCK) ON I.COD_IMP = H.COD_IMP
  WHERE H.COD_SITUACAO IN (1, 3, 4)
  GROUP BY H.COD_TIT
) I ON I.COD_TIT = T.COD_TIT
LEFT JOIN PESSOAS PE WITH (NOLOCK) ON D.COD_PES = PE.COD_PES
LEFT JOIN CV_PESSOAS_ENDERECOS CV WITH (NOLOCK) ON D.COD_PES = CV.COD_PES
WHERE CV.COD_STATE = 2


  --SELECT * FROM V_COLUNAS WHERE TABELA = 'AUX_TIM_CYBER'


























