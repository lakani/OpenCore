USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_AddCIF_Class]    Script Date: 17/12/2019 13:39:30 ******/
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
--	1	Company doesnt exists in DEF_Company Table
--	2	Checking Class Type in LUT_CIF_TYPE Table
--	3	length of @CIF_CLASS is not matching the CIF Class format Length
--	4	CIF Class Already exists before
--
--
-- =============================================

CREATE OR ALTER PROCEDURE [dbo].[SP_AddCIF_Class] 
	-- Add the parameters for the stored procedure here
	@CIF_CLASS_OUT	nvarchar(4)	OUTPUT,
	@CompanyNo		smallint,
	@TYPE			tinyint,
	@NAME			nvarchar(80),
	@CIF_CLASS		nvarchar(4)		= null,
	@EFFECTIVE_DT	datetime		= null,
	@REFERENCE		nvarchar(MAX)	= null
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
	
	PRINT 'Checking Class Type in LUT_CIF_TYPE Table'
	IF NOT EXISTS (select top 1 Code from LUT_CIF_TYPE where Code = @TYPE)
	BEGIN
		PRINT 'Type doesnt exists in LUT_CIF_TYPE Table'
		RETURN (2)
	END


	-- if @CIF_CLASS is provided
	IF (LEN(@CIF_CLASS) > 0)
	BEGIN
		-- ensure that @CIF_CLASS length equel 4 if @CIF_CLASS is provided
		IF(LEN(@CIF_CLASS) > 4)
		BEGIN
			PRINT 'length of @CIF_CLASS is not matching the CIF Class format Length'
			PRINT 'ensure that @CIF_CLASS length equel 4'
			RETURN (3)
		END
		ELSE
		BEGIN
			set @CIF_CLASS = right ('0000'+ltrim(@CIF_CLASS), 4 )
		END
	END
	ELSE -- @CIF_CLASS  is not provided , so get last Ledger number and increment it by one
	BEGIN
		--LUT_LedgerNature@TYPE			int,
		declare @CIF_CLASS_Int			int;
		
		select @CIF_CLASS = MAX(Code) from DEF_CIF_CLASS where CompanyNo = @CompanyNo
		
		IF (@CIF_CLASS is NULL or LEN(@CIF_CLASS) = 0)
		BEGIN
			set @CIF_CLASS = '0000'
		END
		

		set @CIF_CLASS_Int = CAST(@CIF_CLASS as INT)
		set @CIF_CLASS_Int = @CIF_CLASS_Int + 1

		set @CIF_CLASS = right ('0000'+ltrim(str( @CIF_CLASS_Int )), 4 )
	END

	set @CIF_CLASS_OUT = @CIF_CLASS

	-- check if exists before 
	PRINT 'check if CIF CLASS exists before'
	IF EXISTS (SELECT TOP (1) Code FROM DEF_CIF_CLASS where CompanyNo = @CompanyNo and Code = @CIF_CLASS )
	BEGIN
		PRINT 'CIF Class Already exists before'
		RETURN (4)
	END
		

	-- Insert 
	INSERT INTO DEF_CIF_CLASS 
		([Code] ,[Name] ,[Type] ,[CompanyNo] ,[EFFECTIVE_DT] ,[REFERENCE])
	VALUES 
		(@CIF_CLASS , @NAME, @TYPE , @CompanyNo, @EFFECTIVE_DT, @REFERENCE)
		
	PRINT 'Added Successfully'
	RETURN (0)

END
GO

