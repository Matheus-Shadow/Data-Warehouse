select [USR].[User_Id],
	[SER].[Service_c] as 'Serviço',
	[USR].[UserFullName],
	[WK].[Workgroup_Name] 
from [config_epro]..[Service_Group] as [SERG] With(NoLock) 
	inner join [config_epro]..[Service] as [SER] With(NoLock) on ([SERG].[Service_Id] = [SER].[Service_Id]) 
	inner join [config_epro]..[Users] as [USR] With(NoLock) on ([SERG].[User_Id] = [USR].[User_Id]) 
	inner join [config_epro]..[Agent] as [AG] on [AG].[User_Id] = [USR].[User_Id] 
	inner join [config_epro]..[Workgroup] as [WK] on [WK].[Workgroup_Id] = [AG].[Workgroup_Id] 
order by 1, 2
