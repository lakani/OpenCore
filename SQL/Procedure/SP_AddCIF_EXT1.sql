USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_AddCIF_EXT1]    Script Date: 17/12/2019 13:39:39 ******/
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
--	9	GL Already exists before 
--	10	Company doesnt exists in DEF_Company Table
--	11	UnitNo doesnt exists in DEF_Unit Table
--
-- =============================================

CREATE OR ALTER PROCEDURE [dbo].[SP_AddCIF_EXT1]
	-- Add the parameters for the stored procedure here
	@CIF			nvarchar(MAX)	
AS
BEGIN
	
	
	PRINT 'SP_AddCIF_EXT1'
	-- Insert 
	
	PRINT 'Added Successfully'
	RETURN (1)

END
GO

