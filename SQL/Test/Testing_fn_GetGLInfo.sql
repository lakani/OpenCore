


select * from VW_DEF_GL


USE [OpenCore]
GO
select GLS.GL , GLIn.TotallingGL  from VW_DEF_GL GLS CROSS APPLY [dbo].[fn_GetGLInfo] ( GLS.GL, GLS.CURR) GLIn

IF (  (	select COUNT(GLIn.CompanyNo) 
			from @Legs ls CROSS APPLY [dbo].[fn_GetGLInfo] ( ls.Acct_No, @BaseCurr) GLIn
			where ls.GL = 1 and GLIn.CompanyNo != @nCompany) <> 0)
		RETURN (6)


SELECT * FROM [dbo].[fn_GetGLInfo] ('01-01-01-01-01-01-00001' , 'EGP')
GO


