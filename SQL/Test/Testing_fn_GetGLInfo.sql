
USE [OpenCore]
GO

select * from VW_DEF_GL

select * from [fn_GetGLInfo]

SELECT * FROM [dbo].[fn_GetGLInfo] ('01-01-01-01-01-01-00001' , 'EGP')
GO


