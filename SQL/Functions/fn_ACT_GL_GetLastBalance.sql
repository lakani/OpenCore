USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_ACT_GL_GetLastBalance]    Script Date: 17/12/2019 13:43:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER FUNCTION [dbo].[fn_ACT_GL_GetLastBalance](
		@GL		nvarchar(MAX),
		@Curr	nvarchar(4))
RETURNS decimal(28, 3)
AS
BEGIN
	DECLARE		@Ret decimal(28, 3);
	
	select top 1 @Ret =	Balance_After 
	from		TRN_LEGS L 
	where		L.Acct_No = @GL and L.GL = 1 and L.STATUS_ID = 1 and L.Acct_Curr = @Curr
	ORDER BY	l.EffDt desc, L.CREATE_DT desc , L.Sequence desc

	RETURN 	( ISNULL(@Ret,0) );
END;

GO

