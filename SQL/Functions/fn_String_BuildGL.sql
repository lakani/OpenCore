USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_String_BuildGL]    Script Date: 17/12/2019 13:45:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER FUNCTION [dbo].[fn_String_BuildGL] (
		@Zone smallint, 
		@CompanyNo smallint, 
		@BranchNo smallint, 
		@SectorNo smallint, 
		@DepNo smallint, 
		@UnitNO smallint,
		@LedgerNO nvarchar(MAX))
RETURNS nvarchar(MAX)
AS
BEGIN
	RETURN 
	(
		RIGHT('00'+ CONVERT(VARCHAR,@Zone),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@CompanyNo),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@BranchNo),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@SectorNo),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@DepNo),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@UnitNO),2) + '-' +
		CAST(@LedgerNO as nvarchar(MAX))
	)
END

GO

