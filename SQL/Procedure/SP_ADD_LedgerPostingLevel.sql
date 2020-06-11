USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_ADD_LedgerPostingLevel]    Script Date: 17/12/2019 13:39:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[SP_ADD_LedgerPostingLevel] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	
	IF not exists (select top 1 ID from LUT_LedgerPostingLevel where PostingLevel = 'OnBss')
		insert into LUT_LedgerPostingLevel values (1, 'OnBss')

	IF not exists (select top 1 ID from LUT_LedgerPostingLevel where PostingLevel = 'OffBss')
		insert into LUT_LedgerPostingLevel values (1, 'OffBss')
END
GO

