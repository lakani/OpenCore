USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_GL_GetLast_LEDGERNO]    Script Date: 17/12/2019 13:44:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--drop FUNCTION [dbo].[FN_GL_GetLast_LEDGERNO]

CREATE OR ALTER FUNCTION [dbo].[FN_GL_GetLast_LEDGERNO]
(
	@CompanyNo		int,
	@Zone			int,
	@BranchNo		int,
	@SectorNo		int,
	@DepNo			int,
	@UNITNO			int,
	@NATURE			int,
	@POSTINGLEVEL	int,
	@CURR			nvarchar(4)
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @MAX_LEDGER		nvarchar(MAX);
	DECLARE @MAX_LED		nvarchar(MAX);

	SET @MAX_LEDGER = ( SELECT  MAX(GL.LedgerNO) 
						FROM	OpenCore.dbo.DEF_GL GL
						WHERE	GL.CompanyNo = @CompanyNo AND GL.Zone = @Zone AND Gl.BranchNo = @BranchNo AND Gl.SectorNo = @SectorNo)

	SELECT @MAX_LED = ISNULL(@MAX_LEDGER,  dbo.fn_OPT_GetGLFormatDigits()); 

	RETURN (@MAX_LED)
END
GO

