USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_AddCIF]    Script Date: 17/12/2019 13:38:37 ******/
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
--	1	Company doesnt exists in DEF_Company Table
--	3	'Zone doesnt exists in DEF_Zone Table'
--	4	'BranchNo doesnt exists in DEF_Branch Table'
--	5	'BranchNo doesnt exists in DEF_Branch Table'
--	6	'DepNo doesnt exists in DEF_Dep Table'
--	7	'TYPE doesnt exists in LUT_LedgerNature Table'
--	8	'length of LEDGERNO is not matching the GL format Length'
--	10	Company doesnt exists in DEF_Company Table
--	11	UnitNo doesnt exists in DEF_Unit Table
--
-- =============================================

CREATE OR ALTER PROCEDURE [dbo].[SP_AddCIF] 
	-- Add the parameters for the stored procedure here
	@CIF_NO_OUT		nvarchar(MAX)	OUTPUT,
	@CompanyNo		smallint		,
	@CIF_TYPE		smallint		,
	@CIF_CLASS		nvarchar(10),
	@CIF_NO			nvarchar(MAX)	= NULL,
	@SearchKey		nvarchar(MAX)	= NULL,
	@FirstName		nvarchar(MAX)	= NULL,
	@MiddleName		nvarchar(MAX)	= NULL,
	@LastName		nvarchar(MAX)	= NULL,
	@NationalID		nvarchar(80)	= NULL,
	@EFFECTIVE_DT	datetime		= null
AS
BEGIN
	
	--fn_OPT_GetCIFFormatDigits = 4 for the Class
	
	-- if not supplied , assume its current bussiness date
	IF (@EFFECTIVE_DT IS NULL)
		SET @EFFECTIVE_DT = (SELECT dbo.fn_GetCurrentBusinessDate());

	PRINT 'Checking Company in DEF_Company Table'
	IF NOT EXISTS (select top 1 ID from DEF_Company where [ID] = @CompanyNo)
	BEGIN
		PRINT 'Company doesnt exists in DEF_Company Table'
		RETURN (1)
	END
	
	PRINT 'Checking Class in LUT_CIF_TYPE Table'
	IF NOT EXISTS (select top 1 Code from DEF_CIF_CLASS where Code = @CIF_CLASS)
	BEGIN
		PRINT 'CIF Type doesnt exists in LUT_CIF_TYPE Table'
		RETURN (2)
	END
	
	
	PRINT 'Checking Class Type in LUT_CIF_TYPE Table'
	IF NOT EXISTS (select top 1 Code from LUT_CIF_TYPE where Code = @CIF_TYPE)
	BEGIN
		PRINT 'CIF Type doesnt exists in LUT_CIF_TYPE Table'
		RETURN (3)
	END


	-- if @CIF_NO is provided
	IF (LEN(@CIF_NO) > 0)
	BEGIN
		-- ensure that @CIF_NO length equel 4 if @CIF_NO is provided
		IF(LEN(@CIF_NO) > (SELECT dbo.fn_OPT_GetCIFFormatDigitsNum()))
		BEGIN
			PRINT 'length of @CIF_NO is not matching the CIF Class format Length'
			PRINT 'ensure that @CIF_NO length equel 4'
			RETURN (8)
		END
		ELSE
		BEGIN
			declare @CIF_NO_Int			int;
		
			set @CIF_NO_Int = CAST(@CIF_NO as INT)
			set @CIF_NO = right (rtrim(dbo.fn_OPT_GetCIFFormatDigits())+ltrim(str( @CIF_NO_Int )), dbo.fn_OPT_GetCIFFormatDigitsNum() )	
			--TODO
		END
		
	END
	ELSE -- @CIF_NO  is not provided , so get last Ledger number and increment it by one
	BEGIN
		--LUT_LedgerNature@TYPE			int,
				
		select @CIF_NO = MAX(CIF_NO) from DEF_CIF 
		
		IF (@CIF_NO is NULL or LEN(@CIF_NO) = 0)
		BEGIN
			set @CIF_NO = rtrim(dbo.fn_OPT_GetCIFFormatDigits())
		END
		

		set @CIF_NO_Int = CAST(@CIF_NO as INT)
		set @CIF_NO_Int = @CIF_NO_Int + 1

		set @CIF_NO = right (rtrim(dbo.fn_OPT_GetCIFFormatDigits())+ltrim(str( @CIF_NO_Int )), dbo.fn_OPT_GetCIFFormatDigitsNum() )
		--TODO
	END

	set @CIF_NO_OUT = @CIF_NO

	-- check if exists before 
	PRINT 'check if CIF exists before'
	IF EXISTS (SELECT TOP (1) CIF_NO FROM DEF_CIF where CIF_NO = @CIF_NO )
	BEGIN
		PRINT 'CIF already exists before'
		RETURN (4)
	END
	
	-- Assign @SearchKey if not provided 
	IF (@SearchKey IS NULL or LEN(@SearchKey) =0)
	BEGIN
		set @SearchKey = @CIF_NO
	END
	
	-- check if Search Key exists before 
	PRINT 'check if CIF exists before'
	IF EXISTS (SELECT TOP (1) SearchKey FROM DEF_CIF where SearchKey = @SearchKey )
	BEGIN
		PRINT 'Search Key already exists before in CIF Table'
		RETURN (5)
	END
		

	-- Insert 
	INSERT INTO DEF_CIF 
		([CIF_NO] ,[SearchKey] , [CIF_CLASS], [CIF_TYPE] , [FirstName] ,[MiddleName] ,[LastName] ,[CREATE_DT] , [LAST_SAVE_DT], [NationalID] )
	VALUES 
		(@CIF_NO , @SearchKey, @CIF_CLASS, @CIF_TYPE, @FirstName, @MiddleName, @LastName, @EFFECTIVE_DT, @EFFECTIVE_DT, @NationalID)
		
	PRINT 'Added Successfully'
	RETURN (0)

END
GO

