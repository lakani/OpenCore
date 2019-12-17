USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_String_ParseGL]    Script Date: 17/12/2019 13:43:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--DROP FUNCTION [dbo].[fn_String_ParseGL]
CREATE OR ALTER FUNCTION [dbo].[fn_String_ParseGL] (@GL nvarchar(MAX))
RETURNS TABLE
AS
RETURN 
(
	select 
		SUBSTRING(@GL,1, 2)		'Zone',									-- Zone
		SUBSTRING(@GL,4, 2)		'CompanyNo',							-- CompanyNo
		SUBSTRING(@GL,7, 2)		'BranchNo',								-- BranchNo
		SUBSTRING(@GL,10, 2)		'SectorNo',								-- SectorNo
		SUBSTRING(@GL,13, 2)	'DepNo'	,								-- DepNo
		SUBSTRING(@GL,16, 2)	'UnitNO',								-- UnitNO
		SUBSTRING(@GL,19, dbo.fn_OPT_GetGLFormatDigitsNum()) 'LedgerNO'	-- LedgerNO
)


GO

