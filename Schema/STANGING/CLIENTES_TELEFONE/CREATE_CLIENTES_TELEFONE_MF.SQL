CREATE TABLE CLIENTES_TELEFONE_MF (
    TELEFONE_ID bigint IDENTITY(1,1) ,
    DATA_INCLUSAO datetime2 ,
    DATA_ALTERACAO datetime2 ,
    COD_CRM int ,
    CPF varchar(20) ,
    ID_KEY bigint ,
    TELEFONE nvarchar(40) ,
    TIPO_FONE nvarchar(60) ,
    ORIGEM_FONE nvarchar(60) ,
    STATUS nvarchar(60) ,
    PERCENTUAL_LOCALIZACAO int ,
    WHATSAPP smallint ,
    INSTANCIA varchar(20) ,
    BANCO varchar(20) ,
    ORIGEM varchar(30) ,
    DATA_INSERT datetime2 
);
