SELECT
    DATE(A.calldate) as DATA,
    A.doc AS ID_KEY,
    A.doc as CPF,
    B.user AS ID_AGENTE,
    B.nome AS AGENTE,
    CAST(REPLACE(A.uniqueid, '.', '') AS UNSIGNED) AS CALL_ID,
    A.fila AS ID_CAMPANHA,
    C.NOME AS NOME_CAMPANHA,
    A.id_statusdenegocio AS ID_TABULACAO,
    A.statusnegocio AS NOME_TABULACAO,
    A.mailing AS MAILING,
    A.terminator AS ROTA,
    COALESCE(A.dtini, A.calldate) AS INICIO_CHAMADA,
COALESCE(A.dtfim, A.calldate)  AS FIM_CHAMADA,
    '' AS INICIO_POS,
    '' AS FIM_POS,
    A.origem AS TELEFONE,
    '10.13.101.41' AS INSTANCIA,
    'replica_mfrfl2b1' AS BANCO,
    '2CX' AS ORIGEM
FROM chamadas A 
LEFT JOIN agents B ON A.agente = B.user
LEFT JOIN queues C ON A.fila = C.fila
WHERE A.calldate >= CURDATE() 
  AND A.calldate < CURDATE() + INTERVAL 1 DAY 
  AND CAST(REPLACE(A.uniqueid, '.', '') AS UNSIGNED) > 0