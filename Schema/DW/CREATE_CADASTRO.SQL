CREATE TABLE CADASTRO (
    ID_CADASTRO int IDENTITY(1,1) PRIMARY KEY,
    EMPRESA nvarchar(20)  ,
    CLIENTE nvarchar(30)  ,
    COD_CLIENTE int  ,
    COD_CARTEIRA int  ,
    COD_OP int  ,
    COD_CRM int  ,
    CARTEIRA nvarchar(20)  ,
    OPERAÇÃO nvarchar(100)  ,
    CRM varchar(30)  ,
    SERVIDOR_CRM varchar(20)  ,
    BANCO_CRM varchar(20)  ,
    TIPO_CRM nvarchar(15)  ,
    STATUS char(7)  ,
    DATA_CADASTRO datetime2  ,
    DATA_ATUALIZAÇÃO datetime2  
);
