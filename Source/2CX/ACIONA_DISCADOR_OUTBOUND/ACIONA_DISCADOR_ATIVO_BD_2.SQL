select TOP 50
DATE(A.calldate) as DATA,
A.doc AS ID_KEY,
A.doc as CPF,
B.user AS ID_AGENTE,
B.nome AS AGENTE,
A.uniqueid AS CALL_ID,
A.fila AS ID_CAMPANHA,
C.NOME AS NOME_CAMPANHA,
A.id_statusdenegocio AS ID_TABULACAO,
A.statusnegocio AS NOME_TABULACAO,
A.mailing AS MAILING,
A.terminator AS ROTA,
A.dtini AS INICIO_CHAMADA,
A.dtfim AS FIM_CHAMADA,
'' AS INICIO_POS,
'' AS FIM_POS,
A.origem AS TELEFONE,
'10.13.101.169' AS INSTANCIA,
'replica_mfrfl2b1' AS BANCO,
'2CX' AS ORIGEM


FROM chamadas A 
LEFT JOIN agents B ON A.agente = B.user
LEFT JOIN queues C ON A.fila = C.fila
WHERE calldate BETWEEN '2024-07-15 08:00:00' AND '2024-07-15 08:59:59'