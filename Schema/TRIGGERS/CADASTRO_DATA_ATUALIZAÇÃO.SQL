CREATE TRIGGER trg_UpdateDataAtualizacao
ON CADASTRO
AFTER UPDATE
AS
BEGIN
    -- Atualiza DATA_ATUALIZAÇÃO apenas para as linhas que foram efetivamente modificadas
    UPDATE target
    SET DATA_ATUALIZAÇÃO = GETDATE()
    FROM CADASTRO AS target
    JOIN inserted AS src ON target.ID_CADASTRO = src.ID_CADASTRO
    JOIN deleted AS old ON src.ID_CADASTRO = old.ID_CADASTRO
    WHERE (src.EMPRESA <> old.EMPRESA
        OR src.CLIENTE <> old.CLIENTE
        OR src.COD_CLIENTE <> old.COD_CLIENTE
        OR src.COD_CARTEIRA <> old.COD_CARTEIRA
        OR src.COD_OP <> old.COD_OP
        OR src.COD_CRM <> old.COD_CRM
        OR src.CARTEIRA <> old.CARTEIRA
        OR src.OPERAÇÃO <> old.OPERAÇÃO
        OR src.CRM <> old.CRM
        OR src.SERVIDOR_CRM <> old.SERVIDOR_CRM
        OR src.BANCO_CRM <> old.BANCO_CRM
        OR src.TIPO_CRM <> old.TIPO_CRM
        OR src.STATUS <> old.STATUS
        OR src.DATA_CADASTRO <> old.DATA_CADASTRO);
END;