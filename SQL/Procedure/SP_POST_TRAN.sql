USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_POST_TRAN]    Script Date: 17/12/2019 13:41:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER PROCEDURE [dbo].[SP_POST_TRAN] 
	-- Add the parameters for the stored procedure here
	@Ref			uniqueidentifier  OUTPUT,
	@Legs			TYPE_POST_TRAN_PARAM READONLY 
AS
BEGIN
	
	DECLARE @SumOfCR decimal(28, 3), @SumOfDR decimal(28, 3), @nLoop int, @nSize int, @nCompany int;
	DECLARE @BaseCurr nvarchar(4);
	DECLARE @MaxEffDt Datetime;
	DECLARE @CRT_DT Datetime;
	
	-- Retrieve values
	set @nLoop = 0
	select @nSize = COUNT(l.EffDt) from @Legs l;
	select @BaseCurr = BaseCurrency from  dbo.fn_GetSettings();
	select @nCompany =	GLIn.CompanyNo from [dbo].[fn_GetGLInfo] 
						( (select top 1 ls.Acct_No from @Legs ls where ls.GL = 1), @BaseCurr) GLIn;
	set @CRT_DT = GETDATE();

	


	-- Ensure that sum of CR = SUM of DR
	select @SumOfCR = SUM(l.Acct_Amt) from @Legs l where UPPER (l.Acct_CR_DR) = 'CR'
	select @SumOfDR = SUM(l.Acct_Amt) from @Legs l where UPPER (l.Acct_CR_DR) = 'DR'
	IF @SumOfCR <> @SumOfDR
		RETURN (1)

	-- TODO - 		Should check if there is a corresponding Totalling GL , the Legs should balance 
	--				CR = DR of the totalling 

	-- ensure that All GLs are within the same company
	IF (  (	select COUNT(GLIn.CompanyNo) 
			from @Legs ls CROSS APPLY [dbo].[fn_GetGLInfo] ( ls.Acct_No, @BaseCurr) GLIn
			where ls.GL = 1 and GLIn.CompanyNo != @nCompany) <> 0)
		RETURN (6)


	-- ensure that all Gls got the supplied currency 
	IF (	(select COUNT(GL) from @Legs ls where ls.GL = 1 ) <>
			(	select COUNT(GLIn.CompanyNo) 
				from @Legs ls CROSS APPLY [dbo].[fn_GetGLInfo] ( ls.Acct_No, @BaseCurr) GLIn
				where ls.GL = 1))
		RETURN (5)

	-- Ensure that All Legs is with the same currency which is the base Currency
	IF (select COUNT(l.Acct_CR_DR) from @Legs l where l.Acct_Curr != @BaseCurr ) > 0
		RETURN (2)

	-- Ensure that its not Future Dated
	-- Ensure that all Legs are With the same date
	select @MaxEffDt = MAX(l.EffDt) from @Legs l
	IF (@MaxEffDt > dbo.fn_GetCurrentBusinessDate())
		RETURN (3)
	IF (	(select COUNT(l.EffDt) from @Legs l Group by l.EffDt) <> 
			(select COUNT(l.EffDt) from @Legs l where  l.EffDt = @MaxEffDt Group by l.EffDt) )
		RETURN (4)

	
	-- Insert Records in Database
	SET @Ref = NEWID()
	set @nLoop = 1
	WHILE @nLoop <= @nSize
	BEGIN
		DECLARE @Balance_Before decimal(28, 3);
		DECLARE @Balance_After	decimal(28, 3);
		DECLARE @Acct_No		nvarchar(MAX);
		DECLARE @Acct_Curr		nvarchar(4);
		DECLARE	@Acct_CR_DR		nvarchar(2);
		DECLARE	@GL				bit;
		DECLARE	@Acct_Amt		decimal(28, 3);
		DECLARE	@Nature			tinyint;
		DECLARE	@PostingLevel	tinyint;
		DECLARE	@LedgerNO		nvarchar(30);



		select	@Acct_No = L.Acct_No,  @Acct_Curr = L.Acct_Curr , @GL = L.GL, @Acct_CR_DR = L.Acct_CR_DR, @Acct_Amt = L.Acct_Amt
		FROM	@Legs L
		WHERE	L.Row_NUM = @nLoop

		-- get Last Balance for the GL
		select	@Nature = Nature , @PostingLevel = PostingLevel, @LedgerNO = LedgerNO
		from	[dbo].[fn_GetGLInfo] (@Acct_No, @Acct_Curr)
		set @Balance_Before = dbo.fn_ACT_GL_GetLastBalance(@Acct_No, @Acct_Curr);
		----
		set @Balance_After =  dbo.fn_NUM_ACT_CR_DR (@Balance_Before, @Acct_Amt, @Nature, @Acct_CR_DR) ;
		--- 
		
		INSERT INTO		TRN_LEGS  (	[Ref] , [Sequence] , [Acct_CR_DR] , [Acct_No] , [GL] , [Balance_Before] ,
									[Acct_Amt] , [Balance_After] , [Acct_Curr] , [EffDt] , 
									[CREATE_DT] ,[EMP_ID] , [STATUS_ID] ,[CHANNEL_ID] , 
									[Acct_Description] )

		SELECT		@Ref , @nLoop,  @Acct_CR_DR, @Acct_No, @GL, @Balance_Before, @Acct_Amt, @Balance_After, 
					@Acct_Curr, L.EffDt, @CRT_DT, 0, 1, 0, L.Acct_Description

		FROM		@Legs L
		WHERE		L.Row_NUM = @nLoop

		
		set @nLoop = @nLoop + 1
	END

	RETURN (0)

END
GO

