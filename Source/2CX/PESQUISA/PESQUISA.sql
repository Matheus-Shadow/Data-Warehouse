-- Definindo variáveis de data em MySQL
SET @dinicio = DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 DAY), '%Y-%m-%d 00:00:00');
SET @dfim = DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 DAY), '%Y-%m-%d 23:59:59');

SELECT 
    EVENTO_ID_PLATAFORMA, -- Alterado para UNSIGNED
    DATA,
    ID_KEY,
    CALL_ID,
    ID_CAMPANHA,
    CAST(CAMPANHA AS NCHAR(200)) AS CAMPANHA,
    TELEFONE,
    INTEGRACAO_ID,
    PERGUNTAS,
    RESPOSTAS,
    INTEGRACAO_PLATAFORMA,
    INSTANCIA,
    BANCO,
    ORIGEM
FROM (
    SELECT 
        CAST(REPLACE(extras.uniqueid, '.', '') AS UNSIGNED) AS EVENTO_ID_PLATAFORMA,
        CAST(extras.calldate AS DATE) AS DATA,
        CAST(REPLACE(extras.valor4,'.','')AS UNSIGNED) AS ID_KEY,
        CAST(REPLACE(extras.uniqueid,'.','') AS UNSIGNED) AS CALL_ID,
        extras.identificador4 AS ID_CAMPANHA,
        q.nome AS CAMPANHA,
        c.origem AS TELEFONE,
        CAST(REPLACE(extras.valor3,'.','') AS UNSIGNED) AS INTEGRACAO_ID,
        extras.info AS PERGUNTAS,
        CASE 
            WHEN extras.valor IS NULL OR extras.valor = '' THEN NULL
            WHEN CAST(extras.valor AS UNSIGNED) > 10 AND LEFT(extras.valor, 2) = '10' THEN 10
            WHEN CAST(extras.valor AS UNSIGNED) > 10 THEN CAST(LEFT(extras.valor, 1) AS UNSIGNED)
            ELSE CAST(extras.valor AS UNSIGNED)
        END AS RESPOSTAS,
        CASE 
            WHEN extras.valor5 = 45100 THEN 'Humano ASPECT' 
            WHEN extras.valor5 = 45200 THEN 'Humano OLOS' 
            WHEN extras.valor5 = 45300 THEN 'AGV OLOS' 
            ELSE 'AGV 2CX' 
        END AS INTEGRACAO_PLATAFORMA,
        CAST('10.13.101.41' AS CHAR(40)) AS INSTANCIA,
        CAST('replica_mfrflab1' AS NCHAR(100)) AS BANCO,
        CAST('2CX' AS CHAR(20)) AS ORIGEM
    FROM `chamadas_extra_info` extras
    LEFT JOIN chamadas c ON extras.uniqueid = c.uniqueid 
    LEFT JOIN queues q ON extras.identificador4 = q.fila
    WHERE identificador3 = "Pesquisa de Satisfacao"
      AND extras.calldate BETWEEN @dinicio AND @dfim
    
    UNION ALL
    
    SELECT 
        CAST(REPLACE(extras.uniqueid, '.', '') AS UNSIGNED) AS EVENTO_ID_PLATAFORMA,
        CAST(extras.calldate AS DATE) AS DATA,
        CAST(REPLACE(extras.valor4,'.','')AS UNSIGNED) AS ID_KEY,
        CAST(REPLACE(extras.uniqueid,'.','') AS UNSIGNED) AS CALL_ID,
        extras.identificador4 AS ID_CAMPANHA,
        q.nome AS CAMPANHA,
        c.origem AS TELEFONE,
        CAST(REPLACE(extras.valor3,'.','') AS UNSIGNED) AS INTEGRACAO_ID,
        extras.info2 AS PERGUNTAS,  -- Alterado para info2
        CASE 
            WHEN extras.valor2 IS NULL OR extras.valor2 = '' THEN NULL
            WHEN CAST(extras.valor2 AS UNSIGNED) > 10 AND LEFT(extras.valor2, 2) = '10' THEN 10
            WHEN CAST(extras.valor2 AS UNSIGNED) > 10 THEN CAST(LEFT(extras.valor2, 1) AS UNSIGNED)
            ELSE CAST(extras.valor2 AS UNSIGNED)
        END AS RESPOSTAS,
        CASE 
            WHEN extras.valor5 = 45100 THEN 'Humano ASPECT' 
            WHEN extras.valor5 = 45200 THEN 'Humano OLOS' 
            WHEN extras.valor5 = 45300 THEN 'AGV OLOS' 
            ELSE 'AGV 2CX' 
        END AS INTEGRACAO_PLATAFORMA,
        CAST('10.13.101.41' AS CHAR(40)) AS INSTANCIA,
        CAST('replica_mfrflab1' AS NCHAR(100)) AS BANCO,
        CAST('2CX' AS CHAR(20)) AS ORIGEM
    FROM `chamadas_extra_info` extras
    LEFT JOIN chamadas c ON extras.uniqueid = c.uniqueid 
    LEFT JOIN queues q ON extras.identificador4 = q.fila
    WHERE identificador3 = "Pesquisa de Satisfacao"
      AND extras.calldate BETWEEN @dinicio AND @dfim
) AS CombinedResults;
