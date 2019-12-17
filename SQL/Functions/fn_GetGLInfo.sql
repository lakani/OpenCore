USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_GetGLInfo]    Script Date: 17/12/2019 13:43:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[fn_GetGLInfo] (@GL nvarchar(MAX), @ISOCurr nvarchar(8))
RETURNS @t TABLE (
					ZoneNo			tinyint,
					CompanyNo		smallint,
					BranchNo		smallint,
					SectorNo		tinyint,
					DepNo			tinyint,
					UnitNO			tinyint,
					Nature			tinyint,
					PostingLevel	tinyint,
					LedgerNO		nvarchar(30),
					CURR			nvarchar(8),
					COMMENTS		nvarchar(400),
					EFFECTIVE_DT	datetime,
					STATUS			tinyint,
					REFERENCE	nvarchar(MAX))
AS
BEGIN
DECLARE		
	@ZoneNo tinyint, @CompanyNo smallint, @BranchNo smallint, @SectorNo tinyint, 
	@DepNo tinyint, @UnitNO tinyint, @LedgerNO nvarchar(30);
	
	select	@ZoneNo = Zone, @CompanyNo = CompanyNo ,@BranchNo = BranchNo, @SectorNo = SectorNo, 
			@DepNo = DepNo, @UnitNO = UnitNO, @LedgerNO = LedgerNO
	FROM	[dbo].[fn_String_ParseGL] (@GL)	
	
	insert into @t 
	SELECT top	1 *	
	from		OpenCore.dbo.DEF_GL GLTbl 
	where		GLTbl.LedgerNO = @LedgerNO and GLTbl.Zone = @ZoneNo AND	GLTbl.CompanyNo = @CompanyNo and 
				GLTbl.BranchNo = @BranchNo AND GLTbl.CURR = @ISOCurr and GLTbl.SectorNo = @SectorNo and 
				GLTbl.DepNo = @DepNo and GLTbl.UnitNO = @UnitNO 
				
					
	RETURN
	
END

GO

