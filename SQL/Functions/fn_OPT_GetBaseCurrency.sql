USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetBaseCurrency]    Script Date: 17/12/2019 13:44:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[fn_OPT_GetBaseCurrency](	)
RETURNS NVARCHAR(3)
AS
BEGIN
	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	Options.BaseCurrency 
				from			OpenCore.dbo.Settings Options 
				order by Options.VerID desc
		)
END
GO

