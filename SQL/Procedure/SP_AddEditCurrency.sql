USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_AddEditCurrency]    Script Date: 17/12/2019 13:39:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[SP_AddEditCurrency] 
	-- Add the parameters for the stored procedure here
	@ISOCode	nvarchar(4),
	@Symbol		nvarchar(4),
	@Fractions	smallint,
	@Name		nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Declare the return variable here
	DECLARE @CurrencyID int;

	-- validate against fields
	if (@Fractions > 6)
		RETURN (-1)

	select @CurrencyID = CurrencyID from DEF_Currency where ISOCode = @ISOCode;

	-- Check if Record exists or not
	IF (@CurrencyID is null)
	BEGIN
		insert into DEF_Currency values (@ISOCode, @Symbol, @Fractions, @Name)
		select @CurrencyID = CurrencyID from DEF_Currency where ISOCode = @ISOCode;
		RETURN (@CurrencyID)
	END
	ELSE
	BEGIN
		update DEF_Currency 
		set ISOCode = @ISOCode, Symbol = @Symbol, Fractions = @Fractions, DEF_Currency.Name = @Name
		where DEF_Currency.CurrencyID = @CurrencyID

		RETURN (@CurrencyID)
	END

	RETURN (@CurrencyID)

END
GO

