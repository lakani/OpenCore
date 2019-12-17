USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_AddGL]    Script Date: 17/12/2019 13:40:01 ******/
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
--	10	Company doesnt exists in DEF_Company Table
--	11	UnitNo doesnt exists in DEF_Unit Table
--	12	Invalid TotallingGL
-- =============================================

CREATE OR ALTER PROCEDURE [dbo].[SP_AddGL] 
	-- Add the parameters for the stored procedure here
	@LEDGERNO_OUT	nvarchar(15)	OUTPUT,
	@CompanyNo		int,
	@Zone			int,
	@BranchNo		int,
	@SectorNo		int,
	@DepNo			int,
	@UNITNO			int,
	@NATURE			int,
	@LEDGERNO		nvarchar(MAX) = null,
	@TotallingGL	nvarchar(100) = null,
	@POSTINGLEVEL	int = null,
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
	
	PRINT 'Checking Company in DEF_Company Table'
	IF NOT EXISTS (select top 1 ID from DEF_Company where [ID] = @CompanyNo)
	BEGIN
		PRINT 'Company doesnt exists in DEF_Company Table'
		RETURN (10)
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

	PRINT 'Checking DEF_Unit Table'
	IF not exists (select top 1 ID from DEF_Unit where [ID] = @UNITNO)
	BEGIN
		PRINT 'UnitNo doesnt exists in DEF_Unit Table'
		RETURN (11)
	END

	PRINT 'checking TYPE in LUT_LedgerNature '
	IF not exists (select top 1 ID from LUT_LedgerNature where [ID] = @NATURE)
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
		IF(LEN(@LEDGERNO) > (SELECT	dbo.fn_OPT_GetGLFormatDigitsNum()))
		BEGIN
			PRINT 'length of LEDGERNO is not matching the GL format Length'
			PRINT 'ensure that @LEDGERNO length equel the GLFormatDigitsNum'
			RETURN (8)
		END
		ELSE
		BEGIN
			declare @LEDGERNO_Int			int;
		
			set @LEDGERNO_Int = CAST(@LEDGERNO as INT)
			set @LEDGERNO = right (rtrim(dbo.fn_OPT_GetGLFormatDigits())+ltrim(str( @LEDGERNO_Int )), LEN(dbo.fn_OPT_GetGLFormatDigits()) )		
		END
	END
	ELSE -- @LEDGERNO  is not provided , so get last Ledger number and increment it by one
	BEGIN
		--LUT_LedgerNature@TYPE			int,
				
		SET @LEDGERNO = dbo.FN_GL_GetLast_LEDGERNO 
			(@CompanyNo, @Zone, @BranchNo, @SectorNo, @DepNo, @UNITNO,@NATURE, @POSTINGLEVEL, @CURR)

		set @LEDGERNO_Int = CAST(@LEDGERNO as INT)
		set @LEDGERNO_Int = @LEDGERNO_Int + 1

		--set @LEDGERNO = convert(nvarchar(15), @LEDGERNO_Int)
		PRINT dbo.fn_OPT_GetGLFormatDigits()
				
		set @LEDGERNO = right (rtrim(dbo.fn_OPT_GetGLFormatDigits())+ltrim(str( @LEDGERNO_Int )), LEN(dbo.fn_OPT_GetGLFormatDigits()) )
		
	END

	-- @TotallingGL checks
	DECLARE @LEN_TotallingGL tinyint;
	set @LEN_TotallingGL = LEN (@TotallingGL);
	IF (@LEN_TotallingGL > 0 )
	BEGIN
		IF (@LEN_TotallingGL > 35) -- FIXED GL Lenght is 35
		BEGIN
			PRINT 'FIXED GL Lenght is 35'
			RETURN (8)
		END

		DECLARE @TotallingGL_CompanyNo		int;
		DECLARE @TotallingGL_NATURE			int;
		DECLARE @TotallingGL_POSTINGLEVEL	int; 
		DECLARE @TotallingGL_CURR			nvarchar(4);
	
		select	@TotallingGL_CompanyNo = CompanyNo, @TotallingGL_CURR = CURR, @TotallingGL_NATURE = Nature ,
				@TotallingGL_POSTINGLEVEL = PostingLevel
		from	[dbo].[fn_GetGLInfo] (@TotallingGL, @CURR)

		IF (	( @TotallingGL_CompanyNo <> @CompanyNo) OR
				( @TotallingGL_CURR <> @CURR) OR
				( @TotallingGL_NATURE <> @NATURE) OR 
				( @TotallingGL_POSTINGLEVEL <> @POSTINGLEVEL))
		BEGIN
			PRINT 'Invalid TotallingGL'
			RETURN (12)
		END



	END

	set @LEDGERNO_OUT = @LEDGERNO

	-- check if exists before 
	PRINT 'check if GL exists before'
	IF EXISTS (SELECT LEDGERNO FROM DEF_GL WHERE [Zone] = @Zone AND [CompanyNo] = @CompanyNo AND 
								[BranchNo] = @BranchNo and [SectorNo] = @SectorNo AND
								[DepNo] = @DepNo AND [UNITNO] = @UNITNO AND 
								[LEDGERNO] = @LEDGERNO  AND [CURR]= @CURR )
	BEGIN
		PRINT 'GL Already exists before'
		RETURN (9)
	END
		

		--   ,[LEDGERNO] ,[CURR] ,[COMMENTS] ,[EFFECTIVE_DT] , [STATUS] ,[REFERENCE])

	-- Insert 
	INSERT INTO [dbo].[DEF_GL]
           ([Zone] ,[CompanyNo] ,[BranchNo] ,[SectorNo] ,[DepNo] ,[UNITNO] ,[Nature] ,[POSTINGLEVEL] 
		   ,[LEDGERNO] ,[CURR] ,[TotallingGL] ,[COMMENTS] ,[EFFECTIVE_DT] , [STATUS] ,[REFERENCE])

     values ( @Zone ,@CompanyNo ,@BranchNo ,@SectorNo ,@DepNo ,@UNITNO ,@NATURE ,@POSTINGLEVEL
           ,@LEDGERNO ,@CURR , @TotallingGL ,@COMMENTS ,@EFFECTIVE_DT , 1,@REFERENCE) 

	
	PRINT 'Added Successfully'
	RETURN (0)

END
GO

