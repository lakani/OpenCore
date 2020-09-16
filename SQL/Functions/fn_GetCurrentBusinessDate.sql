USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_GetCurrentBusinessDate]    Script Date: 17/12/2019 13:44:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER FUNCTION [dbo].[fn_GetCurrentBusinessDate]()
RETURNS DATE
AS
BEGIN 

	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	LastDay.BusinessDay 
				from			OpenCore.dbo.DEF_BusinessDate LastDay 
				order by		LastDay.ID desc
		)

END
GO

