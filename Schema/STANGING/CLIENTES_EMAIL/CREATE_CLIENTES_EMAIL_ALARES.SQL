CREATE TABLE CLIENTES_EMAIL_ALARES (
    EMAIL_ID bigint IDENTITY(1,1) ,
    DATA_INCLUSAO datetime2 ,
    DATA_ALTERACAO datetime2 ,
    COD_CRM int ,
    CPF varchar(20) ,
    ID_KEY bigint ,
    EMAIL nvarchar(400) ,
    SITUACAO_EMAIL nvarchar(120) ,
    TIPO_EMAIL nvarchar(80) ,
    ORIGEM_EMAIL nvarchar(120) ,
    INSTANCIA varchar(20) ,
    BANCO varchar(20) ,
    ORIGEM varchar(30) ,
    DATA_INSERT datetime2 
);
