USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_NUM_ACT_CR_DR]    Script Date: 17/12/2019 13:44:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER FUNCTION [dbo].[fn_NUM_ACT_CR_DR](
		@OldBalance	decimal(28, 3),
		@TrnAmt	decimal(28, 3),
		@Nature		tinyint,
		@CR_DR		nvarchar(4))
RETURNS decimal(28, 3)
AS
BEGIN
	DECLARE		@Ret decimal(28, 3);
		--ID	Name		CR_DR
		--1		Asset		DR
		--2		Liability	CR
		--3		Income		CR
		--4		Expense		DR
		--5		Capital		CR

		-- Based on CR or DR and the Nature Add or Subtract
		IF			@Nature = 1	AND		UPPER (@CR_DR)	=  'CR'		
			set @Ret =  @OldBalance - @TrnAmt;
		ELSE IF		@Nature = 1	AND		UPPER (@CR_DR)	=  'DR'	
			set @Ret =  @OldBalance + @TrnAmt;

		ELSE IF		@Nature = 2	AND		UPPER (@CR_DR)	=  'CR'	
			set @Ret =  @OldBalance + @TrnAmt;
		ELSE IF		@Nature = 2	AND		UPPER (@CR_DR)	=  'DR'	
			set @Ret =  @OldBalance - @TrnAmt;

		ELSE IF		@Nature = 3	AND		UPPER (@CR_DR)	=  'CR'	
			set @Ret =  @OldBalance + @TrnAmt;
		ELSE IF		@Nature = 3	AND		UPPER (@CR_DR)	=  'DR'	
			set @Ret =  @OldBalance - @TrnAmt;

		ELSE IF		@Nature = 4	AND		UPPER (@CR_DR)	=  'CR'	
			set @Ret =  @OldBalance - @TrnAmt;
		ELSE IF		@Nature = 4	AND		UPPER (@CR_DR)	=  'DR'	
			set @Ret =  @OldBalance + @TrnAmt;

		ELSE IF		@Nature = 5	AND		UPPER (@CR_DR)	=  'CR'	
			set @Ret =  @OldBalance + @TrnAmt;
		ELSE IF		@Nature = 5	AND		UPPER (@CR_DR)	=  'DR'	
			set @Ret =  @OldBalance - @TrnAmt;


	RETURN 	( @Ret );
END;

GO

