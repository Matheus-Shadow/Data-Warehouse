SELECT 
    DE.LoginDt, 
    DE.User_Id, 
    DE.LogoutDt,
    SER.Service_c AS CAMPANHAA,
    SER.Service_Id
FROM 
    detail_epro..AgentLoginLogout DE
INNER JOIN 
    [config_epro]..[Service] AS SER WITH (NOLOCK) 
    ON SER.Service_Id = DE.Service_Id
WHERE 
    CAST(DE.LoginDt AS DATE) = '2024-07-26' 
        AND DE.User_Id = 'TIMANANAYRA';
