USE [OpenCore]
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
GO
EXEC sys.sp_dropextendedproperty @name=N'DESCRIPTION' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TYPE',@level1name=N'TYPE_POST_TRAN_PARAM', @level2type=N'COLUMN',@level2name=N'Acct_No'
GO
/****** Object:  StoredProcedure [dbo].[SP_AddEditCurrency]    Script Date: 03/12/2020 12:01:20 ******/
DROP PROCEDURE [dbo].[SP_AddEditCurrency]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddCIF_EXT1]    Script Date: 03/12/2020 12:01:20 ******/
DROP PROCEDURE [dbo].[SP_AddCIF_EXT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddCIF_Class]    Script Date: 03/12/2020 12:01:20 ******/
DROP PROCEDURE [dbo].[SP_AddCIF_Class]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddCIF]    Script Date: 03/12/2020 12:01:20 ******/
DROP PROCEDURE [dbo].[SP_AddCIF]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_LedgerPostingLevel]    Script Date: 03/12/2020 12:01:20 ******/
DROP PROCEDURE [dbo].[SP_ADD_LedgerPostingLevel]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_LedgerNature]    Script Date: 03/12/2020 12:01:20 ******/
DROP PROCEDURE [dbo].[SP_ADD_LedgerNature]
GO
/****** Object:  View [dbo].[VW_DEF_GL]    Script Date: 03/12/2020 12:01:20 ******/
DROP VIEW [dbo].[VW_DEF_GL]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_String_ParseGL]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_String_ParseGL]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetSettings]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_GetSettings]
GO
/****** Object:  Table [dbo].[TRN_SHARE_ACCT]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[TRN_SHARE_ACCT]
GO
/****** Object:  Table [dbo].[TRN_LEGS]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[TRN_LEGS]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[Settings]
GO
/****** Object:  Table [dbo].[PROC_FIXRATE_INTEREST]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[PROC_FIXRATE_INTEREST]
GO
/****** Object:  Table [dbo].[LUT_TRN_STATUS]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_TRN_STATUS]
GO
/****** Object:  Table [dbo].[LUT_OBJ_STATUS]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_OBJ_STATUS]
GO
/****** Object:  Table [dbo].[LUT_LedgerPostingLevel]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_LedgerPostingLevel]
GO
/****** Object:  Table [dbo].[LUT_LedgerNature]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_LedgerNature]
GO
/****** Object:  Table [dbo].[LUT_GL_ACCT_CATEGORY]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_GL_ACCT_CATEGORY]
GO
/****** Object:  Table [dbo].[LUT_COUNTRY]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_COUNTRY]
GO
/****** Object:  Table [dbo].[LUT_CITY]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_CITY]
GO
/****** Object:  Table [dbo].[LUT_CIF_TYPE]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_CIF_TYPE]
GO
/****** Object:  Table [dbo].[LUT_AE_CATEGORY]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_AE_CATEGORY]
GO
/****** Object:  Table [dbo].[LUT_ACCT_TYPE]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_ACCT_TYPE]
GO
/****** Object:  Table [dbo].[LUT_ACCRUAL_BASIS]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[LUT_ACCRUAL_BASIS]
GO
/****** Object:  Table [dbo].[ExchangeRates]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[ExchangeRates]
GO
/****** Object:  Table [dbo].[DEF_Zone]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_Zone]
GO
/****** Object:  Table [dbo].[DEF_Unit]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_Unit]
GO
/****** Object:  Table [dbo].[DEF_SHARE_ACCT]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_SHARE_ACCT]
GO
/****** Object:  Table [dbo].[DEF_Sector]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_Sector]
GO
/****** Object:  Table [dbo].[DEF_GL]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_GL]
GO
/****** Object:  Table [dbo].[DEF_FIXRATE_ACCT_DATES]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_FIXRATE_ACCT_DATES]
GO
/****** Object:  Table [dbo].[DEF_FIXRATE_ACCT]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_FIXRATE_ACCT]
GO
/****** Object:  Table [dbo].[DEF_EMP]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_EMP]
GO
/****** Object:  Table [dbo].[DEF_Dep]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_Dep]
GO
/****** Object:  Table [dbo].[DEF_Currency]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_Currency]
GO
/****** Object:  Table [dbo].[DEF_Company]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_Company]
GO
/****** Object:  Table [dbo].[DEF_CK_ACCT_ACCT_STRUCT]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_CK_ACCT_ACCT_STRUCT]
GO
/****** Object:  Table [dbo].[DEF_CK_ACCT]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_CK_ACCT]
GO
/****** Object:  Table [dbo].[DEF_CIF_Company]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_CIF_Company]
GO
/****** Object:  Table [dbo].[DEF_CIF_CLASS]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_CIF_CLASS]
GO
/****** Object:  Table [dbo].[DEF_CIF]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_CIF]
GO
/****** Object:  Table [dbo].[DEF_BusinessDate]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_BusinessDate]
GO
/****** Object:  Table [dbo].[DEF_Branch]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_Branch]
GO
/****** Object:  Table [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT]
GO
/****** Object:  Table [dbo].[DEF_ACCT_CLASS]    Script Date: 03/12/2020 12:01:20 ******/
DROP TABLE [dbo].[DEF_ACCT_CLASS]
GO
/****** Object:  UserDefinedFunction [dbo].[RANDBETWEEN]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[RANDBETWEEN]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_String_BuildGL]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_String_BuildGL]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetGLFormatDigitsNum]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_OPT_GetGLFormatDigitsNum]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetGLFormatDigits]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_OPT_GetGLFormatDigits]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetCIFFormatDigitsNum]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_OPT_GetCIFFormatDigitsNum]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetCIFFormatDigits]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_OPT_GetCIFFormatDigits]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetBaseCurrency]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_OPT_GetBaseCurrency]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_NUM_ACT_CR_DR]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_NUM_ACT_CR_DR]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GL_GetLast_LEDGERNO]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[FN_GL_GetLast_LEDGERNO]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetGLInfo]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_GetGLInfo]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetCurrentBusinessDate]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_GetCurrentBusinessDate]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Get_MAX_TABLE_CODE]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_Get_MAX_TABLE_CODE]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ACT_GL_GetLastBalance]    Script Date: 03/12/2020 12:01:20 ******/
DROP FUNCTION [dbo].[fn_ACT_GL_GetLastBalance]
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_POST_TRAN_PARAM]    Script Date: 03/12/2020 12:01:20 ******/
DROP TYPE [dbo].[TYPE_POST_TRAN_PARAM]
GO
USE [master]
GO
/****** Object:  Database [OpenCore]    Script Date: 03/12/2020 12:01:20 ******/
DROP DATABASE [OpenCore]
GO
/****** Object:  Database [OpenCore]    Script Date: 03/12/2020 12:01:20 ******/
CREATE DATABASE [OpenCore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OpenCore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\OpenCore.mdf' , SIZE = 11264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'OpenCore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\OpenCore_log.ldf' , SIZE = 395400KB , MAXSIZE = 2048GB , FILEGROWTH = 1024KB )
 COLLATE Arabic_CI_AS
GO
ALTER DATABASE [OpenCore] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OpenCore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OpenCore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OpenCore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OpenCore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OpenCore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OpenCore] SET ARITHABORT OFF 
GO
ALTER DATABASE [OpenCore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OpenCore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OpenCore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OpenCore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OpenCore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OpenCore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OpenCore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OpenCore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OpenCore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OpenCore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OpenCore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OpenCore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OpenCore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OpenCore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OpenCore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OpenCore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OpenCore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OpenCore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OpenCore] SET  MULTI_USER 
GO
ALTER DATABASE [OpenCore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OpenCore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OpenCore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OpenCore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'OpenCore', N'ON'
GO
USE [OpenCore]
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_POST_TRAN_PARAM]    Script Date: 03/12/2020 12:01:21 ******/
CREATE TYPE [dbo].[TYPE_POST_TRAN_PARAM] AS TABLE(
	[Row_NUM] [int] IDENTITY(1,1) NOT NULL,
	[Acct_CR_DR] [nvarchar](2) COLLATE Arabic_CI_AS NULL,
	[Acct_No] [nvarchar](max) COLLATE Arabic_CI_AS NULL,
	[GL] [bit] NULL,
	[Acct_Amt] [decimal](28, 3) NULL,
	[Acct_Curr] [nvarchar](3) COLLATE Arabic_CI_AS NULL,
	[EffDt] [datetime] NULL,
	[Acct_Description] [nvarchar](max) COLLATE Arabic_CI_AS NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ACT_GL_GetLastBalance]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_ACT_GL_GetLastBalance](
		@GL		nvarchar(MAX),
		@Curr	nvarchar(4))
RETURNS decimal(28, 3)
AS
BEGIN
	DECLARE		@Ret decimal(28, 3);
	
	select top 1 @Ret =	Balance_After 
	from		TRN_LEGS L 
	where		L.Acct_No = @GL and L.GL = 1 and L.STATUS_ID = 1 and L.Acct_Curr = @Curr
	ORDER BY	l.EffDt desc, L.CREATE_DT desc , L.Sequence desc

	RETURN 	( ISNULL(@Ret,0) );
END;

GO
/****** Object:  UserDefinedFunction [dbo].[fn_Get_MAX_TABLE_CODE]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_Get_MAX_TABLE_CODE]()
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetCurrentBusinessDate]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_GetCurrentBusinessDate]()
RETURNS DATE
AS
BEGIN 

	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	LastDay.BusinessDay 
				from			OpenCore.dbo.DEF_BusinessDate LastDay 
				order by		LastDay.ID desc
		)

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetGLInfo]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[fn_GetGLInfo] (@GL nvarchar(MAX), @ISOCurr nvarchar(8))
RETURNS @t TABLE (
					ZoneNo			tinyint,
					CompanyNo		smallint,
					BranchNo		smallint,
					SectorNo		tinyint,
					DepNo			tinyint,
					UnitNO			tinyint,
					Nature			tinyint,
					PostingLevel	tinyint,
					LedgerNO		nvarchar(30),
					CURR			nvarchar(8),
					COMMENTS		nvarchar(400),
					EFFECTIVE_DT	datetime,
					STATUS			tinyint,
					TotallingGL		nvarchar(35),
					REFERENCE	nvarchar(MAX))
AS
BEGIN
DECLARE		
	@ZoneNo tinyint, @CompanyNo smallint, @BranchNo smallint, @SectorNo tinyint, 
	@DepNo tinyint, @UnitNO tinyint, @LedgerNO nvarchar(30);
	
	select	@ZoneNo = Zone, @CompanyNo = CompanyNo ,@BranchNo = BranchNo, @SectorNo = SectorNo, 
			@DepNo = DepNo, @UnitNO = UnitNO, @LedgerNO = LedgerNO
	FROM	[dbo].[fn_String_ParseGL] (@GL)	
	
	insert into @t 
	SELECT top	1 	GLTbl.Zone, GLTbl.CompanyNo, GLTbl.BranchNo, GLTbl.SectorNo, GLTbl.DepNo, GLTbl.UnitNO, GLTbl.Nature, 
				GLTbl.PostingLevel, GLTbl.LedgerNO, GLTbl.CURR, GLTbl.COMMENTS, GLTbl.EFFECTIVE_DT, GLTbl.STATUS, GLTbl.TotallingGL,
				GLTbl.REFERENCE
	from		OpenCore.dbo.DEF_GL GLTbl 
	where		GLTbl.LedgerNO = @LedgerNO and GLTbl.Zone = @ZoneNo AND	GLTbl.CompanyNo = @CompanyNo and 
				GLTbl.BranchNo = @BranchNo AND GLTbl.CURR = @ISOCurr and GLTbl.SectorNo = @SectorNo and 
				GLTbl.DepNo = @DepNo and GLTbl.UnitNO = @UnitNO 
				
					
	RETURN
	
END

GO
/****** Object:  UserDefinedFunction [dbo].[FN_GL_GetLast_LEDGERNO]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop FUNCTION [dbo].[FN_GL_GetLast_LEDGERNO]

CREATE FUNCTION [dbo].[FN_GL_GetLast_LEDGERNO]
(
	@CompanyNo		int,
	@Zone			int,
	@BranchNo		int,
	@SectorNo		int,
	@DepNo			int,
	@UNITNO			int,
	@NATURE			int,
	@POSTINGLEVEL	int,
	@CURR			nvarchar(4)
)
RETURNS nvarchar(MAX)
AS
BEGIN
	DECLARE @MAX_LEDGER		nvarchar(MAX);
	DECLARE @MAX_LED		nvarchar(MAX);

	SET @MAX_LEDGER = ( SELECT  MAX(GL.LedgerNO) 
						FROM	OpenCore.dbo.DEF_GL GL
						WHERE	GL.CompanyNo = @CompanyNo AND GL.Zone = @Zone AND Gl.BranchNo = @BranchNo AND Gl.SectorNo = @SectorNo)

	SELECT @MAX_LED = ISNULL(@MAX_LEDGER,  dbo.fn_OPT_GetGLFormatDigits()); 

	RETURN (@MAX_LED)
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_NUM_ACT_CR_DR]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fn_NUM_ACT_CR_DR](
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
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetBaseCurrency]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_OPT_GetBaseCurrency](	)
RETURNS NVARCHAR(3)
AS
BEGIN
	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	Options.BaseCurrency 
				from			OpenCore.dbo.Settings Options 
				order by Options.VerID desc
		)
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetCIFFormatDigits]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fn_OPT_GetCIFFormatDigits]()
RETURNS NVARCHAR(MAX)
AS
BEGIN 

	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	rtrim(Options.CIFFormatDigits)
				from			OpenCore.dbo.Settings Options 
				order by Options.VerID desc
		)

END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetCIFFormatDigitsNum]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[fn_OPT_GetCIFFormatDigitsNum]()
RETURNS smallint
AS
BEGIN 

	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	LEN(rtrim(Options.CIFFormatDigits))
				from			OpenCore.dbo.Settings Options 
				order by Options.VerID desc
		)

END


GO
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetGLFormatDigits]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_OPT_GetGLFormatDigits]()
RETURNS NVARCHAR(MAX)
AS
BEGIN 

	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	Options.GLFormatDigits
				from			OpenCore.dbo.Settings Options 
				order by Options.VerID desc
		)

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetGLFormatDigitsNum]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fn_OPT_GetGLFormatDigitsNum]()
RETURNS TINYINT
AS
BEGIN 

	-- Add the SELECT statement with parameter references here
	return (	SELECT top 1	LEN(Options.GLFormatDigits)
				from			OpenCore.dbo.Settings Options 
				order by Options.VerID desc
		)

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_String_BuildGL]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_String_BuildGL] (
		@Zone smallint, 
		@CompanyNo smallint, 
		@BranchNo smallint, 
		@SectorNo smallint, 
		@DepNo smallint, 
		@UnitNO smallint,
		@LedgerNO nvarchar(MAX))
RETURNS nvarchar(MAX)
AS
BEGIN
	RETURN 
	(
		RIGHT('00'+ CONVERT(VARCHAR,@Zone),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@CompanyNo),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@BranchNo),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@SectorNo),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@DepNo),2) + '-' + 
		RIGHT('00'+ CONVERT(VARCHAR,@UnitNO),2) + '-' +
		CAST(@LedgerNO as nvarchar(MAX))
	)
END

GO
/****** Object:  UserDefinedFunction [dbo].[RANDBETWEEN]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[RANDBETWEEN](@minval TINYINT, @maxval TINYINT, @random NUMERIC(18,10))
RETURNS TINYINT
AS
BEGIN
  RETURN (SELECT CAST(((@maxval + 1) - @minval) * @random + @minval AS TINYINT))
END
GO
/****** Object:  Table [dbo].[DEF_ACCT_CLASS]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_ACCT_CLASS](
	[AccountClassID] [smallint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](5) COLLATE Arabic_CI_AS NOT NULL,
	[Name] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[Type] [nvarchar](10) COLLATE Arabic_CI_AS NULL,
	[CompanyNo] [int] NULL,
	[Currency] [nvarchar](5) COLLATE Arabic_CI_AS NULL,
	[EFFECTIVE_DT] [datetime] NULL,
	[REFERENCE] [nvarchar](max) COLLATE Arabic_CI_AS NOT NULL,
 CONSTRAINT [PK_DEF_ACCT_CLASS] PRIMARY KEY CLUSTERED 
(
	[AccountClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT](
	[AccountStructID] [smallint] IDENTITY(1,1) NOT NULL,
	[AccountClassCode] [nvarchar](5) COLLATE Arabic_CI_AS NOT NULL,
	[GLNum] [nvarchar](40) COLLATE Arabic_CI_AS NOT NULL,
	[GLCategory] [smallint] NOT NULL,
	[GLComments] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
 CONSTRAINT [PK_DEF_ACCT_CLASS_ACCT_STRUCT] PRIMARY KEY CLUSTERED 
(
	[AccountStructID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Branch]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Branch](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) COLLATE Arabic_CI_AS NOT NULL,
	[CompanyNo] [int] NULL,
 CONSTRAINT [PK_DEF_Branch] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_BusinessDate]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_BusinessDate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BusinessDay] [date] NULL,
	[IsClosed] [bit] NULL,
	[IsEndOfWeek] [bit] NULL,
	[IsEndOfMonth] [bit] NULL,
	[IsEndOfQuarter] [bit] NULL,
	[IsEndOfYear] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_CIF]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CIF](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[SearchKey] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[FirstName] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[MiddleName] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[LastName] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[FamilyName] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[CREATE_DT] [datetime] NULL,
	[CIF_TYPE] [smallint] NULL,
	[CIF_CLASS] [nvarchar](10) COLLATE Arabic_CI_AS NULL,
	[RSM] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[Gender] [nvarchar](10) COLLATE Arabic_CI_AS NULL,
	[Country] [int] NULL,
	[COUNTRY_OF_BIRTH] [int] NULL,
	[GOVERNORATE] [int] NULL,
	[City] [int] NULL,
	[Area] [int] NULL,
	[Address] [nvarchar](max) COLLATE Arabic_CI_AS NULL,
	[Nationality] [int] NULL,
	[BIRTH_DT] [date] NULL,
	[LAST_SAVE_DT] [datetime] NULL,
	[MobileNumber] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[HomeNumber] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[WorkNumber] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[NationalID] [nvarchar](max) COLLATE Arabic_CI_AS NULL,
 CONSTRAINT [PK__tmp_ms_x__3214EC073F31DDF2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_CIF_CLASS]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CIF_CLASS](
	[Code] [nvarchar](10) COLLATE Arabic_CI_AS NOT NULL,
	[Name] [nvarchar](80) COLLATE Arabic_CI_AS NOT NULL,
	[Type] [tinyint] NOT NULL,
	[CompanyNo] [smallint] NOT NULL,
	[EFFECTIVE_DT] [datetime] NULL,
	[REFERENCE] [nvarchar](max) COLLATE Arabic_CI_AS NULL,
 CONSTRAINT [PK__DEF_CIF___A25C5AA6127E02BB] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[CompanyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_CIF_Company]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CIF_Company](
	[DEF_CIF_Company_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[Company_ID] [smallint] NULL,
 CONSTRAINT [PK_DEF_CIF_Company] PRIMARY KEY CLUSTERED 
(
	[DEF_CIF_Company_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_CK_ACCT]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CK_ACCT](
	[DEF_ACCT_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[ACCT_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[Title] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[Description] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[ReferenceACCT] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[ReferenceOrg] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[IBAN] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[ACCT_TYPE] [nvarchar](10) COLLATE Arabic_CI_AS NOT NULL,
	[ACCT_CLASS] [nvarchar](10) COLLATE Arabic_CI_AS NULL,
	[Currency] [nvarchar](3) COLLATE Arabic_CI_AS NULL,
	[OpenDate] [date] NULL,
	[CSP_Code] [nvarchar](10) COLLATE Arabic_CI_AS NULL,
	[CompanyNo] [smallint] NOT NULL,
	[STATUS] [tinyint] NULL,
 CONSTRAINT [PK_DEF_ACCT] PRIMARY KEY CLUSTERED 
(
	[DEF_ACCT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_CK_ACCT_ACCT_STRUCT]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CK_ACCT_ACCT_STRUCT](
	[AccountStructID] [smallint] IDENTITY(1,1) NOT NULL,
	[AccountCode] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[GLNum] [nvarchar](40) COLLATE Arabic_CI_AS NOT NULL,
	[GLCategory] [smallint] NOT NULL,
	[GLComments] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
 CONSTRAINT [PK_DEF_ACCT_ACCT_STRUCT] PRIMARY KEY CLUSTERED 
(
	[AccountStructID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Company]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Company](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) COLLATE Arabic_CI_AS NOT NULL,
 CONSTRAINT [PK_DEF_Company] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Currency]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Currency](
	[CurrencyID] [smallint] IDENTITY(1,1) NOT NULL,
	[ISOCode] [nvarchar](3) COLLATE Arabic_CI_AS NOT NULL,
	[Symbol] [nvarchar](3) COLLATE Arabic_CI_AS NOT NULL,
	[Fractions] [smallint] NOT NULL,
	[Name] [nvarchar](100) COLLATE Arabic_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Dep]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Dep](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) COLLATE Arabic_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_EMP]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_EMP](
	[EMP_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](max) COLLATE Arabic_CI_AS NULL,
	[FirstName] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[MiddleName] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[LastName] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[FamilyName] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[CREATE_DT] [datetime] NULL,
	[LAST_SAVE_DT] [datetime] NULL,
	[MobileNumber] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[HomeNumber] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[WorkNumber] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[STATUS_ID] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_FIXRATE_ACCT]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_FIXRATE_ACCT](
	[DEF_ACCT_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[ACCT_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[Title] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[Description] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[ReferenceACCT] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[ReferenceOrg] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[IBAN] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[ACCT_TYPE] [nvarchar](10) COLLATE Arabic_CI_AS NOT NULL,
	[ACCT_CLASS] [nvarchar](10) COLLATE Arabic_CI_AS NULL,
	[Currency] [nvarchar](3) COLLATE Arabic_CI_AS NULL,
	[OpenDate] [date] NOT NULL,
	[CreateDate] [date] NOT NULL,
	[CloseDate] [date] NOT NULL,
	[Principle] [decimal](28, 2) NOT NULL,
	[Rate] [decimal](28, 26) NULL,
	[AccrualBasis] [tinyint] NULL,
	[CSP_Code] [nvarchar](10) COLLATE Arabic_CI_AS NULL,
	[CompanyNo] [smallint] NOT NULL,
	[STATUS_ID] [tinyint] NOT NULL,
 CONSTRAINT [PK_DEF_FIXRATE_ACCT] PRIMARY KEY CLUSTERED 
(
	[DEF_ACCT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_FIXRATE_ACCT_DATES]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_FIXRATE_ACCT_DATES](
	[DEF_FIXRATE_ACCT_DATES_ID] [int] IDENTITY(1,1) NOT NULL,
	[DEF_ACCT_ID] [int] NOT NULL,
	[ACCT_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[ACCT_DATE] [date] NOT NULL,
 CONSTRAINT [PK_DEF_FIXRATE_ACCT_DATES] PRIMARY KEY CLUSTERED 
(
	[DEF_FIXRATE_ACCT_DATES_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_GL]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_GL](
	[GL_DEFID] [int] IDENTITY(1,1) NOT NULL,
	[Zone] [tinyint] NULL,
	[CompanyNo] [smallint] NOT NULL,
	[BranchNo] [smallint] NULL,
	[SectorNo] [tinyint] NULL,
	[DepNo] [tinyint] NULL,
	[UnitNO] [tinyint] NULL,
	[ProductNo] [smallint] NULL,
	[Nature] [tinyint] NOT NULL,
	[PostingLevel] [tinyint] NOT NULL,
	[LedgerNO] [int] NOT NULL,
	[GL] [nvarchar](50) COLLATE Arabic_CI_AS NULL,
	[CURR] [nvarchar](4) COLLATE Arabic_CI_AS NOT NULL,
	[COMMENTS] [nvarchar](200) COLLATE Arabic_CI_AS NULL,
	[EFFECTIVE_DT] [datetime] NOT NULL,
	[STATUS] [tinyint] NOT NULL,
	[REFERENCE] [nvarchar](max) COLLATE Arabic_CI_AS NULL,
 CONSTRAINT [PK_DEF_GL] PRIMARY KEY CLUSTERED 
(
	[GL_DEFID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Sector]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Sector](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](30) COLLATE Arabic_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_SHARE_ACCT]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_SHARE_ACCT](
	[DEF_ACCT_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[ACCT_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[Name] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[Description] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[ReferenceACCT] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[ReferenceOrg] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[IBAN] [nvarchar](35) COLLATE Arabic_CI_AS NULL,
	[ACCT_TYPE] [nvarchar](10) COLLATE Arabic_CI_AS NOT NULL,
	[ACCT_CLASS] [nvarchar](10) COLLATE Arabic_CI_AS NULL,
	[Currency] [nvarchar](3) COLLATE Arabic_CI_AS NULL,
	[OpenDate] [date] NOT NULL,
	[ACCT_QTY] [decimal](28, 8) NOT NULL,
	[ACCT_AMT] [decimal](28, 8) NOT NULL,
	[ACCT_AVG] [decimal](28, 8) NOT NULL,
	[ACCT_P_L] [decimal](28, 8) NOT NULL,
	[CSP_Code] [nvarchar](10) COLLATE Arabic_CI_AS NULL,
	[CompanyNo] [smallint] NOT NULL,
	[STATUS_ID] [tinyint] NOT NULL,
 CONSTRAINT [PK_DEF_SHARE_ACCT] PRIMARY KEY CLUSTERED 
(
	[DEF_ACCT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Unit]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Unit](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](30) COLLATE Arabic_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Zone]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Zone](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](30) COLLATE Arabic_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExchangeRates]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeRates](
	[FromCurIsoCode] [nchar](3) COLLATE Arabic_CI_AS NOT NULL,
	[ToCurIsoCode] [nchar](3) COLLATE Arabic_CI_AS NOT NULL,
	[Rate] [decimal](24, 9) NULL,
	[ExRateDate] [datetime] NULL,
	[TimeEXC] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_ACCRUAL_BASIS]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_ACCRUAL_BASIS](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](10) COLLATE Arabic_CI_AS NOT NULL,
	[Description] [nvarchar](max) COLLATE Arabic_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_ACCT_TYPE]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_ACCT_TYPE](
	[ID] [smallint] NOT NULL,
	[Name] [nvarchar](10) COLLATE Arabic_CI_AS NOT NULL,
	[Description] [nvarchar](max) COLLATE Arabic_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_AE_CATEGORY]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_AE_CATEGORY](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](80) COLLATE Arabic_CI_AS NOT NULL,
	[Description] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[ParentCat] [smallint] NULL,
 CONSTRAINT [PK_LUT_AE_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_CIF_TYPE]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_CIF_TYPE](
	[Code] [tinyint] NOT NULL,
	[Name] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
 CONSTRAINT [PK__LUT_CIF___A25C5AA6A1F27BC6] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_CITY]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_CITY](
	[Code] [nvarchar](10) COLLATE Arabic_CI_AS NOT NULL,
	[Name] [nvarchar](80) COLLATE Arabic_CI_AS NOT NULL,
	[CountryCode] [nvarchar](10) COLLATE Arabic_CI_AS NOT NULL,
 CONSTRAINT [PK_LUT_CITY] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_COUNTRY]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_COUNTRY](
	[ID] [smallint] NOT NULL,
	[Code] [nvarchar](10) COLLATE Arabic_CI_AS NOT NULL,
	[Name] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
 CONSTRAINT [PK_LUT_COUNTRY] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_GL_ACCT_CATEGORY]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_GL_ACCT_CATEGORY](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](80) COLLATE Arabic_CI_AS NOT NULL,
	[Description] [nvarchar](80) COLLATE Arabic_CI_AS NULL,
	[ParentCat] [smallint] NULL,
 CONSTRAINT [PK_LUT_GL_ACCT_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_LedgerNature]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_LedgerNature](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](30) COLLATE Arabic_CI_AS NOT NULL,
	[CR_DR] [nchar](2) COLLATE Arabic_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_LedgerPostingLevel]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_LedgerPostingLevel](
	[ID] [tinyint] NOT NULL,
	[PostingLevel] [nvarchar](50) COLLATE Arabic_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_OBJ_STATUS]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_OBJ_STATUS](
	[STATUS_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](80) COLLATE Arabic_CI_AS NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_TRN_STATUS]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_TRN_STATUS](
	[STATUS_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](80) COLLATE Arabic_CI_AS NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROC_FIXRATE_INTEREST]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROC_FIXRATE_INTEREST](
	[PROC_FIXRATE_INTEREST_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[ACCT_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[PRINCIPLE_AMT] [decimal](32, 2) NOT NULL,
	[CALC_INTEREST_AMT] [decimal](32, 2) NOT NULL,
	[FROM_DATE] [datetime] NOT NULL,
	[TO_DATE] [datetime] NOT NULL,
	[STATUS_ID] [tinyint] NOT NULL,
 CONSTRAINT [PK_PROC_FIXRATE_INTEREST] PRIMARY KEY CLUSTERED 
(
	[PROC_FIXRATE_INTEREST_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[VerID] [int] IDENTITY(1,1) NOT NULL,
	[EffectiveDate] [date] NULL,
	[GLFormat] [nchar](200) COLLATE Arabic_CI_AS NOT NULL,
	[GLFormatDigits] [nchar](200) COLLATE Arabic_CI_AS NULL,
	[BaseCurrency] [nchar](10) COLLATE Arabic_CI_AS NOT NULL,
	[ACCTFormatDigits] [nchar](200) COLLATE Arabic_CI_AS NULL,
	[ACCTFormatDigitsNum] [nchar](200) COLLATE Arabic_CI_AS NULL,
	[ACCTFormat] [nchar](200) COLLATE Arabic_CI_AS NULL,
	[CIFFormatDigits] [nchar](100) COLLATE Arabic_CI_AS NOT NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[VerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRN_LEGS]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRN_LEGS](
	[TRN_LEGS_ID] [int] IDENTITY(1,1) NOT NULL,
	[Ref] [uniqueidentifier] NULL,
	[Sequence] [smallint] NULL,
	[Acct_CR_DR] [nvarchar](2) COLLATE Arabic_CI_AS NULL,
	[Acct_No] [nvarchar](max) COLLATE Arabic_CI_AS NULL,
	[GL] [bit] NULL,
	[Balance_Before] [decimal](28, 3) NULL,
	[Trn_Amt] [decimal](28, 3) NULL,
	[Balance_After] [decimal](28, 3) NULL,
	[Acct_Curr] [nvarchar](3) COLLATE Arabic_CI_AS NULL,
	[EffDt] [date] NULL,
	[CREATE_DT] [datetime] NULL,
	[EMP_ID] [smallint] NULL,
	[STATUS_ID] [tinyint] NOT NULL,
	[CHANNEL_ID] [smallint] NULL,
	[Category] [smallint] NULL,
	[Acct_Description] [nvarchar](max) COLLATE Arabic_CI_AS NULL,
	[Related_Ref] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TRN_LEGS] PRIMARY KEY CLUSTERED 
(
	[TRN_LEGS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRN_SHARE_ACCT]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRN_SHARE_ACCT](
	[TRN_SHARE_ACCT_ID] [int] IDENTITY(1,1) NOT NULL,
	[Ref] [uniqueidentifier] NULL,
	[ACCT_NO] [nvarchar](35) COLLATE Arabic_CI_AS NOT NULL,
	[TRAN_DT] [datetime] NOT NULL,
	[SETTLMENT_DT] [datetime] NOT NULL,
	[TRAN_TYPE_ID] [tinyint] NOT NULL,
	[TRAN_QTY] [decimal](28, 8) NOT NULL,
	[UNIT_PRICE] [decimal](28, 8) NOT NULL,
	[TRAN_AMT] [decimal](28, 8) NOT NULL,
	[TRAN_P_L] [decimal](28, 8) NOT NULL,
 CONSTRAINT [PK_TRN_SHARE_ACCT] PRIMARY KEY CLUSTERED 
(
	[TRN_SHARE_ACCT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetSettings]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetSettings]()
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT top 1 * from OpenCore.dbo.Settings Options order by Options.VerID desc
)

GO
/****** Object:  UserDefinedFunction [dbo].[fn_String_ParseGL]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP FUNCTION [dbo].[fn_String_ParseGL]
CREATE FUNCTION [dbo].[fn_String_ParseGL] (@GL nvarchar(MAX))
RETURNS TABLE
AS
RETURN 
(
	select 
		SUBSTRING(@GL,1, 2)		'Zone',									-- Zone
		SUBSTRING(@GL,4, 2)		'CompanyNo',							-- CompanyNo
		SUBSTRING(@GL,7, 2)		'BranchNo',								-- BranchNo
		SUBSTRING(@GL,10, 2)		'SectorNo',								-- SectorNo
		SUBSTRING(@GL,13, 2)	'DepNo'	,								-- DepNo
		SUBSTRING(@GL,16, 2)	'UnitNO',								-- UnitNO
		SUBSTRING(@GL,19, dbo.fn_OPT_GetGLFormatDigitsNum()) 'LedgerNO'	-- LedgerNO
)


GO
/****** Object:  View [dbo].[VW_DEF_GL]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DEF_GL]
AS
SELECT        GL.GL, ISNULL(GL.Zone, 0) AS Zone, ISNULL(dbo.DEF_Zone.Name, '') AS ZoneName, GL.CompanyNo, dbo.DEF_Company.Name AS CompanyName, ISNULL(GL.BranchNo, 0) AS BranchNo, ISNULL(dbo.DEF_Branch.Name, '') 
                         AS BranchName, ISNULL(GL.SectorNo, 0) AS SectorNo, ISNULL(dbo.DEF_Sector.Name, '') AS SectorName, ISNULL(GL.DepNo, 0) AS DepNo, ISNULL(dbo.DEF_Dep.Name, '') AS DepName, ISNULL(GL.UnitNO, 0) AS UnitNO, 
                         ISNULL(dbo.DEF_Unit.Name, '') AS UnitName, ISNULL(GL.ProductNo, '') AS ProductNo, ISNULL(GL.Nature, 0) AS Nature, dbo.LUT_LedgerNature.Name AS NatureName, dbo.LUT_LedgerNature.CR_DR, GL.PostingLevel, 
                         GL.LedgerNO, GL.CURR, GL.EFFECTIVE_DT, ISNULL(GL.REFERENCE, '') AS REFERENCE
FROM            dbo.DEF_GL AS GL LEFT OUTER JOIN
                         dbo.DEF_Zone ON dbo.DEF_Zone.ID = GL.Zone LEFT OUTER JOIN
                         dbo.DEF_Company ON dbo.DEF_Company.ID = GL.CompanyNo LEFT OUTER JOIN
                         dbo.DEF_Branch ON dbo.DEF_Branch.ID = GL.BranchNo LEFT OUTER JOIN
                         dbo.DEF_Sector ON dbo.DEF_Sector.ID = GL.SectorNo LEFT OUTER JOIN
                         dbo.DEF_Dep ON dbo.DEF_Dep.ID = GL.DepNo LEFT OUTER JOIN
                         dbo.DEF_Unit ON dbo.DEF_Unit.ID = GL.UnitNO LEFT OUTER JOIN
                         dbo.LUT_LedgerNature ON dbo.LUT_LedgerNature.ID = GL.Nature
GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_LedgerNature]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_LUTLedgerNature]    Script Date: 28/07/2019 14:12:39 ******/



CREATE PROCEDURE [dbo].[SP_ADD_LedgerNature] 
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
/****** Object:  StoredProcedure [dbo].[SP_ADD_LedgerPostingLevel]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ADD_LedgerPostingLevel] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	
	IF not exists (select top 1 ID from LUT_LedgerPostingLevel where PostingLevel = 'OnBss')
		insert into LUT_LedgerPostingLevel values (1, 'OnBss')

	IF not exists (select top 1 ID from LUT_LedgerPostingLevel where PostingLevel = 'OffBss')
		insert into LUT_LedgerPostingLevel values (1, 'OffBss')
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddCIF]    Script Date: 03/12/2020 12:01:21 ******/
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

CREATE PROCEDURE [dbo].[SP_AddCIF] 
	-- Add the parameters for the stored procedure here
	@CIF_NO_OUT		nvarchar(MAX)	OUTPUT,
	@CompanyNo		smallint		,
	@CIF_TYPE		smallint		,
	@CIF_CLASS		nvarchar(10),
	@CIF_NO			nvarchar(MAX)	= NULL,
	@SearchKey		nvarchar(MAX)	= NULL,
	@FirstName		nvarchar(MAX)	= NULL,
	@MiddleName		nvarchar(MAX)	= NULL,
	@LastName		nvarchar(MAX)	= NULL,
	@NationalID		nvarchar(80)	= NULL,
	@EFFECTIVE_DT	datetime		= null
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
	
	PRINT 'Checking Class in LUT_CIF_TYPE Table'
	IF NOT EXISTS (select top 1 Code from DEF_CIF_CLASS where Code = @CIF_CLASS)
	BEGIN
		PRINT 'CIF Type doesnt exists in LUT_CIF_TYPE Table'
		RETURN (2)
	END
	
	
	PRINT 'Checking Class Type in LUT_CIF_TYPE Table'
	IF NOT EXISTS (select top 1 Code from LUT_CIF_TYPE where Code = @CIF_TYPE)
	BEGIN
		PRINT 'CIF Type doesnt exists in LUT_CIF_TYPE Table'
		RETURN (3)
	END


	-- if @CIF_NO is provided
	IF (LEN(@CIF_NO) > 0)
	BEGIN
		-- ensure that @CIF_NO length equel 4 if @CIF_NO is provided
		IF(LEN(@CIF_NO) > (SELECT dbo.fn_OPT_GetCIFFormatDigitsNum()))
		BEGIN
			PRINT 'length of @CIF_NO is not matching the CIF Class format Length'
			PRINT 'ensure that @CIF_NO length equel 4'
			RETURN (8)
		END
		ELSE
		BEGIN
			declare @CIF_NO_Int			int;
		
			set @CIF_NO_Int = CAST(@CIF_NO as INT)
			set @CIF_NO = right (rtrim(dbo.fn_OPT_GetCIFFormatDigits())+ltrim(str( @CIF_NO_Int )), dbo.fn_OPT_GetCIFFormatDigitsNum() )	
			--TODO
		END
		
	END
	ELSE -- @CIF_NO  is not provided , so get last Ledger number and increment it by one
	BEGIN
		--LUT_LedgerNature@TYPE			int,
				
		select @CIF_NO = MAX(CIF_NO) from DEF_CIF 
		
		IF (@CIF_NO is NULL or LEN(@CIF_NO) = 0)
		BEGIN
			set @CIF_NO = rtrim(dbo.fn_OPT_GetCIFFormatDigits())
		END
		

		set @CIF_NO_Int = CAST(@CIF_NO as INT)
		set @CIF_NO_Int = @CIF_NO_Int + 1

		set @CIF_NO = right (rtrim(dbo.fn_OPT_GetCIFFormatDigits())+ltrim(str( @CIF_NO_Int )), dbo.fn_OPT_GetCIFFormatDigitsNum() )
		--TODO
	END

	set @CIF_NO_OUT = @CIF_NO

	-- check if exists before 
	PRINT 'check if CIF exists before'
	IF EXISTS (SELECT TOP (1) CIF_NO FROM DEF_CIF where CIF_NO = @CIF_NO )
	BEGIN
		PRINT 'CIF already exists before'
		RETURN (4)
	END
	
	-- Assign @SearchKey if not provided 
	IF (@SearchKey IS NULL or LEN(@SearchKey) =0)
	BEGIN
		set @SearchKey = @CIF_NO
	END
	
	-- check if Search Key exists before 
	PRINT 'check if CIF exists before'
	IF EXISTS (SELECT TOP (1) SearchKey FROM DEF_CIF where SearchKey = @SearchKey )
	BEGIN
		PRINT 'Search Key already exists before in CIF Table'
		RETURN (5)
	END
		

	-- Insert 
	INSERT INTO DEF_CIF 
		([CIF_NO] ,[SearchKey] , [CIF_CLASS], [CIF_TYPE] , [FirstName] ,[MiddleName] ,[LastName] ,[CREATE_DT] , [LAST_SAVE_DT], [NationalID] )
	VALUES 
		(@CIF_NO , @SearchKey, @CIF_CLASS, @CIF_TYPE, @FirstName, @MiddleName, @LastName, @EFFECTIVE_DT, @EFFECTIVE_DT, @NationalID)
		
	PRINT 'Added Successfully'
	RETURN (0)

END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddCIF_Class]    Script Date: 03/12/2020 12:01:21 ******/
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

CREATE   PROCEDURE [dbo].[SP_AddCIF_Class] 
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
/****** Object:  StoredProcedure [dbo].[SP_AddCIF_EXT1]    Script Date: 03/12/2020 12:01:21 ******/
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

CREATE PROCEDURE [dbo].[SP_AddCIF_EXT1]
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
/****** Object:  StoredProcedure [dbo].[SP_AddEditCurrency]    Script Date: 03/12/2020 12:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AddEditCurrency] 
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
EXEC sys.sp_addextendedproperty @name=N'DESCRIPTION', @value=N'Account number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TYPE',@level1name=N'TYPE_POST_TRAN_PARAM', @level2type=N'COLUMN',@level2name=N'Acct_No'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "GL"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Zone"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Company"
            Begin Extent = 
               Top = 102
               Left = 246
               Bottom = 198
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Branch"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Sector"
            Begin Extent = 
               Top = 198
               Left = 246
               Bottom = 294
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Dep"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 348
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Unit"
            Begin Extent = 
               Top = 294
               Left = 246
               Bottom = 390
               Right = 416
            End
            DisplayFlags' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 280
            TopColumn = 0
         End
         Begin Table = "LUT_LedgerNature"
            Begin Extent = 
               Top = 348
               Left = 38
               Bottom = 461
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5070
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
GO
USE [master]
GO
ALTER DATABASE [OpenCore] SET  READ_WRITE 
GO
