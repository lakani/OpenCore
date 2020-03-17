

select * from OpenCore..DEF_CK_ACCT

select * FROM [OpenCore].[dbo].[TRN_LEGS]
where Ref in (select ReF 
FROM [OpenCore].[dbo].[TRN_LEGS] 
group by ReF 
having (COUNT(Sequence) % 2) > 0)


select ReF , COUNT(Sequence) , COUNT(Sequence) % 2
FROM [OpenCore].[dbo].[TRN_LEGS] 
group by ReF 
having (COUNT(Sequence) % 2) > 0

select * from OpenCore..LUT_LedgerNature
-- 000000000000001

select * from OpenCore..TRN_LEGS


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



select * from OpenCore..LUT_GL_ACCT_CATEGORY

select top 1 GLNum from OpenCore..DEF_CK_ACCT_ACCT_STRUCT order by AccountStructID desc

select top 1 l.Balance_After, l.*
from OpenCore..TRN_LEGS l
where   l.GL = 1 and l.STATUS_ID = 1  
--l.Acct_No == stACCT_NO and l.Acct_Curr == Acct_Curr 
order by l.EffDt desc , l.CREATE_DT desc, 
l.Sequence desc, l.TRN_LEGS_ID desc
                            
