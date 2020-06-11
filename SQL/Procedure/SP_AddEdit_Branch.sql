USE [OpenCore]
GO

/****** Object:  StoredProcedure [dbo].[SP_AddEdit_Branch]    Script Date: 17/12/2019 13:39:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[SP_AddEdit_Branch] 
	-- Add the parameters for the stored procedure here
	@Name		nvarchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @NewBranch int;

	-- Check if Record exists or not
	print 'Checking Name , if Record exists or not'
	IF not exists (select top 1 ID from DEF_Branch where Name = @Name)
		return -1;

	insert into DEF_Branch values (@Name)
	select @NewBranch = ID from DEF_Branch where Name= @Name;
		RETURN (@NewBranch)

    RETURN (@NewBranch)
END
GO

