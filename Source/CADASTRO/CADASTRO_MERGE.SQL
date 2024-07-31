MERGE INTO CADASTRO AS target
USING (
    SELECT 
        ? as ID_CADASTRO, -- Adicione esta linha para a coluna de identificação
        ? as EMPRESA,
        ? as CLIENTE,
        ? as COD_CLIENTE,
        ? as COD_CARTEIRA,
        ? as COD_OP,
        ? as COD_CRM,
        ? as CARTEIRA,
        ? as OPERAÇÃO,
        ? as CRM,
        ? as SERVIDOR_CRM,
        ? as BANCO_CRM,
        ? as TIPO_CRM,
        ? as STATUS,
        ? as DATA_CADASTRO,
        ? as DATA_ATUALIZAÇÃO
) AS source
ON target.ID_CADASTRO = source.ID_CADASTRO
WHEN MATCHED THEN
    UPDATE SET
        EMPRESA = source.EMPRESA,
        CLIENTE = source.CLIENTE,
        COD_CLIENTE = source.COD_CLIENTE,
        COD_CARTEIRA = source.COD_CARTEIRA,
        COD_OP = source.COD_OP,
        COD_CRM = source.COD_CRM,
        CARTEIRA = source.CARTEIRA,
        OPERAÇÃO = source.OPERAÇÃO,
        CRM = source.CRM,
        SERVIDOR_CRM = source.SERVIDOR_CRM,
        BANCO_CRM = source.BANCO_CRM,
        TIPO_CRM = source.TIPO_CRM,
        STATUS = source.STATUS
WHEN NOT MATCHED THEN
    INSERT (
        EMPRESA, CLIENTE, COD_CLIENTE, COD_CARTEIRA, COD_OP, COD_CRM, CARTEIRA, OPERAÇÃO, CRM, SERVIDOR_CRM, BANCO_CRM, TIPO_CRM, STATUS, DATA_ATUALIZAÇÃO
    )
    VALUES (
        source.EMPRESA, source.CLIENTE, source.COD_CLIENTE, source.COD_CARTEIRA, source.COD_OP, source.COD_CRM, source.CARTEIRA, source.OPERAÇÃO, source.CRM, source.SERVIDOR_CRM, source.BANCO_CRM, source.TIPO_CRM, source.STATUS, source.DATA_ATUALIZAÇÃO
    );
