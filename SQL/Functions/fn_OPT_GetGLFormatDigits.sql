USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetGLFormatDigits]    Script Date: 17/12/2019 13:45:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER FUNCTION [dbo].[fn_OPT_GetGLFormatDigits]()
RETURNS NVARCHAR(MAX)
AS
BEGIN 

	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	Options.GLFormatDigits
				from			OpenCore.dbo.Settings Options 
				order by Options.VerID desc
		)

END
GO

