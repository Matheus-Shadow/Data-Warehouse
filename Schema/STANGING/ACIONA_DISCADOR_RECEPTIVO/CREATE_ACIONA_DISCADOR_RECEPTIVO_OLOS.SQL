CREATE TABLE ACIONA_DISCADOR_RECEPTIVO_OLOS (
    EVENTO_ID bigint IDENTITY(1,1),
    DATA date ,
    ID_KEY varchar(20) ,
    CPF varchar(20) ,
    ID_AGENTE nvarchar(120) ,
    AGENTE nvarchar(410) ,
    CALL_ID bigint ,
    ID_CAMPANHA bigint ,
    NOME_CAMPANHA nvarchar(1200) ,
    ID_TABULACAO bigint ,
    NOME_TABULACAO nvarchar(400) ,
    MAILING varchar(250) ,
    ROTA varchar(130) ,
    INICIO_CHAMADA datetime2 ,
    FIM_CHAMADA datetime2 ,
    INICIO_POS datetime2 ,
    FIM_POS datetime2 ,
    INICIO_FILA datetime2 ,
    FIM_FILA datetime2 ,
    TELEFONE varchar(25) ,
    INSTANCIA varchar(20) ,
    BANCO varchar(20) ,
    ORIGEM varchar(30) ,
    DATA_INSERT datetime2 
);
