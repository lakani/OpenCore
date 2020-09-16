USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetCIFFormatDigits]    Script Date: 17/12/2019 13:44:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [dbo].[fn_OPT_GetCIFFormatDigits]()
RETURNS NVARCHAR(MAX)
AS
BEGIN 

	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	rtrim(Options.CIFFormatDigits)
				from			OpenCore.dbo.Settings Options 
				order by Options.VerID desc
		)

END

GO

