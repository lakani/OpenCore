USE [OpenCore]
GO

DECLARE @RC int , @CIF_CLASS_OUT nvarchar(4) , @CompanyNo int , @TYPE smallint, @NAME nvarchar(80) , @CIF_CLASS nvarchar(4) , 
		@EFFECTIVE_DT datetime , @REFERENCE nvarchar(max);
-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[SP_AddCIF_Class] 
   @CIF_CLASS_OUT OUTPUT
  ,@CompanyNo
  ,@TYPE
  ,@NAME
  ,@CIF_CLASS
  ,@EFFECTIVE_DT
  ,@REFERENCE
GO

select * from LUT_CIF_TYPE