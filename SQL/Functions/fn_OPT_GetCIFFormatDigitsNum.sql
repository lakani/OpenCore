USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetCIFFormatDigitsNum]    Script Date: 17/12/2019 13:45:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE OR ALTER FUNCTION [dbo].[fn_OPT_GetCIFFormatDigitsNum]()
RETURNS smallint
AS
BEGIN 

	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	LEN(rtrim(Options.CIFFormatDigits))
				from			OpenCore.dbo.Settings Options 
				order by Options.VerID desc
		)

END


GO

