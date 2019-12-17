USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_GetSettings]    Script Date: 17/12/2019 13:43:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[fn_GetSettings]()
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT top 1 * from OpenCore.dbo.Settings Options order by Options.VerID desc
)

GO

