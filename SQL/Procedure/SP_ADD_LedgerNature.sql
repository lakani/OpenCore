USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_ADD_LedgerNature]    Script Date: 17/12/2019 13:38:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[SP_ADD_LUTLedgerNature]    Script Date: 28/07/2019 14:12:39 ******/



CREATE OR ALTER PROCEDURE [dbo].[SP_ADD_LedgerNature] 
	-- Add the parameters for the stored procedure here
WITH RECOMPILE
AS
BEGIN
	
	IF not exists (select top 1 ID from LUT_LedgerNature where Name = 'Asset')
		insert into LUT_LedgerNature values (1, 'Asset', 'DR')

	IF not exists (select top 1 ID from LUT_LedgerNature where Name = 'Liability')
		insert into LUT_LedgerNature values (2, 'Liability', 'CR')

	IF not exists (select top 1 ID from LUT_LedgerNature where Name = 'Income')
		insert into LUT_LedgerNature values (3, 'Income', 'CR')

	IF not exists (select top 1 ID from LUT_LedgerNature where Name = 'Expense')
		insert into LUT_LedgerNature values (4, 'Expense', 'DR')

	IF not exists (select top 1 ID from LUT_LedgerNature where Name = 'Capital')
		insert into LUT_LedgerNature values (5, 'Capital', 'CR')
	
END
GO

