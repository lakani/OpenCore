USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_AddAccount]    Script Date: 17/12/2019 13:39:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--
--
--		Retun Codes
--	0 	Successful execution.
--
--	2	'ISOCode doesnt exists in DEF_Currency Table'
--	3	'Zone doesnt exists in DEF_Zone Table'
--	4	'BranchNo doesnt exists in DEF_Branch Table'
--	5	'BranchNo doesnt exists in DEF_Branch Table'
--	6	'DepNo doesnt exists in DEF_Dep Table'
--	7	'TYPE doesnt exists in LUT_LedgerNature Table'
--	8	'length of LEDGERNO is not matching the GL format Length'
--	9	GL Already exists before 
--
--
--
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[SP_AddAccount] 
	-- Add the parameters for the stored procedure here
	@CompanyNo		int,
	@Zone			int,
	@BranchNo		int,
	@SectorNo		int,
	@DepNo			int,
	@UNITNO			int,
	@TYPE			int,
	@POSTINGLEVEL	int,
	@LEDGERNO		nvarchar(15),
	@CURR			nvarchar(4) = null, 
	@COMMENTS		nvarchar(200) = null,
	@EFFECTIVE_DT	datetime = null,
	@REFERENCE		nvarchar(MAX) = null
AS
BEGIN
	
	-- if not supplied , assume its the base currency
	if (@CURR IS NULL) 
		set @CURR = dbo.fn_OPT_GetBaseCurrency();
					   

	-- if not supplied , assume its current bussiness date
	IF (@EFFECTIVE_DT IS NULL)
		SET @EFFECTIVE_DT = (SELECT dbo.fn_GetCurrentBusinessDate());

	-- check paramters
	PRINT 'Checking DEF_Currency Table'
	IF not exists (select top 1 ISOCode from DEF_Currency where ISOCode = @CURR)
	BEGIN
		PRINT 'ISOCode doesnt exists in DEF_Currency Table'
		return (2)
	END
	

	PRINT 'Checking DEF_Zone Table'
	IF not exists (select top 1 ID from DEF_Zone where [ID] = @Zone)
	BEGIN
		PRINT 'Zone doesnt exists in DEF_Zone Table'
		RETURN (3)
	END
	

	PRINT 'Checking DEF_Branch Table'
	IF not exists (select top 1 ID from DEF_Branch where [ID] = @BranchNo)
	BEGIN
		PRINT 'BranchNo doesnt exists in DEF_Branch Table'
		RETURN (4)
	END

	PRINT 'Checking DEF_Sector Table'
	IF not exists (select top 1 ID from DEF_Sector where [ID] = @SectorNo)
	BEGIN
		PRINT 'BranchNo doesnt exists in DEF_Branch Table'
		RETURN (5)
	END

	PRINT 'Checking DEF_Dep Table'
	IF not exists (select top 1 ID from DEF_Dep where [ID] = @DepNo)
	BEGIN
		PRINT 'DepNo doesnt exists in DEF_Dep Table'
		RETURN (6)
	END

	PRINT 'checking TYPE in LUT_LedgerNature '
	IF not exists (select top 1 ID from LUT_LedgerNature where [ID] = @TYPE)
	BEGIN
		PRINT 'TYPE doesnt exists in LUT_LedgerNature Table'
		RETURN (7)
	END

	PRINT 'Checking LUT_LedgerPostingLevel Table'
	IF not exists (select top 1 ID from LUT_LedgerPostingLevel where [ID] = @POSTINGLEVEL)
	BEGIN
		PRINT 'Assume OnBalance'
		SET @POSTINGLEVEL = 1;
	END

	-- if @LEDGERNO is provided
	IF (LEN(@LEDGERNO) > 0)
	BEGIN
		-- ensure that @LEDGERNO length equel the GLFormatDigitsNum if @LEDGERNO is provided
		IF(LEN(@LEDGERNO) <> (SELECT	dbo.fn_OPT_GetGLFormatDigitsNum()))
		BEGIN
			PRINT 'length of LEDGERNO is not matching the GL format Length'
			PRINT 'ensure that @LEDGERNO length equel the GLFormatDigitsNum'
			RETURN (8)
		END
	END
	ELSE
	BEGIN
		--LUT_LedgerNature@TYPE			int,
		SET @LEDGERNO = dbo.FN_GL_GetLast_LEDGERNO 
			(@CompanyNo, @Zone, @BranchNo, @SectorNo, @DepNo, @UNITNO,@TYPE, @POSTINGLEVEL, @CURR)
	END

	-- check if exists before 
	PRINT 'check if GL exists before'
	IF EXISTS (SELECT LEDGERNO FROM DEF_GL WHERE [Zone] = @Zone AND [CompanyNo] = @CompanyNo AND 
								[BranchNo] = @BranchNo and [SectorNo] = @SectorNo AND
								[DepNo] = @DepNo AND [UNITNO] = @UNITNO AND [TYPE] = @TYPE AND 
								[POSTINGLEVEL] = @POSTINGLEVEL AND [LEDGERNO] = @LEDGERNO)
	BEGIN
		PRINT 'GL Already exists before'
		RETURN (9)
	END
		

		--   ,[LEDGERNO] ,[CURR] ,[COMMENTS] ,[EFFECTIVE_DT] , [STATUS] ,[REFERENCE])

	-- Insert 
	INSERT INTO [dbo].[DEF_GL]
           ([Zone] ,[CompanyNo] ,[BranchNo] ,[SectorNo] ,[DepNo] ,[UNITNO] ,[TYPE] ,[POSTINGLEVEL] 
		   ,[LEDGERNO] ,[CURR] ,[COMMENTS] ,[EFFECTIVE_DT] , [STATUS] ,[REFERENCE])

     values ( @Zone ,@CompanyNo ,@BranchNo ,@SectorNo ,@DepNo ,@UNITNO ,@TYPE ,@POSTINGLEVEL
           ,@LEDGERNO ,@CURR ,@COMMENTS ,@EFFECTIVE_DT , 1,@REFERENCE) 

	RETURN (0)

END
GO

