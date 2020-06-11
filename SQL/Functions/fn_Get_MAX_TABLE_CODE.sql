USE [OpenCore]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_Get_MAX_TABLE_CODE]    Script Date: 17/12/2019 13:44:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER FUNCTION [dbo].[fn_Get_MAX_TABLE_CODE]()
RETURNS NVARCHAR(80)
AS
BEGIN 
	DECLARE @MaxValueStr			NVARCHAR(80);
	DECLARE @MaxValueInt			int;

	select @MaxValueStr = max(Code) from LUT_CIF_TYPE
	if (@MaxValueStr is null)
		set @MaxValueInt = 1;
	ELSE
		BEGIN
			set @MaxValueInt = TRY_CAST(@MaxValueStr AS int)
			IF(@MaxValueInt IS NULL)
				set @MaxValueInt = 1;
		END

	SET @MaxValueInt = @MaxValueInt + 1;

	RETURN @MaxValueInt


--insert into LUT_CIF_TYPE VALUES('002', 'Type 1')




--print (@MaxValueStr);

--select MAX(@MaxValueStr) = Code from  LUT_CIF_TYPE

--select @MaxValueStr = max(Code) from LUT_CIF_TYPE




END
GO

