USE [master]
GO
/****** Object:  Database [OpenCore]    Script Date: 18/11/2020 14:46:31 ******/
CREATE DATABASE [OpenCore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OpenCore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\OpenCore.mdf' , SIZE = 11264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'OpenCore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\OpenCore_log.ldf' , SIZE = 395400KB , MAXSIZE = 2048GB , FILEGROWTH = 1024KB )
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
ALTER DATABASE [OpenCore] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'OpenCore', N'ON'
GO
ALTER DATABASE [OpenCore] SET QUERY_STORE = OFF
GO
USE [OpenCore]
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_POST_TRAN_PARAM]    Script Date: 18/11/2020 14:46:31 ******/
CREATE TYPE [dbo].[TYPE_POST_TRAN_PARAM] AS TABLE(
	[Row_NUM] [int] IDENTITY(1,1) NOT NULL,
	[Acct_CR_DR] [nvarchar](2) NULL,
	[Acct_No] [nvarchar](max) NULL,
	[GL] [bit] NULL,
	[Acct_Amt] [decimal](28, 3) NULL,
	[Acct_Curr] [nvarchar](3) NULL,
	[EffDt] [datetime] NULL,
	[Acct_Description] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ACT_GL_GetLastBalance]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_Get_MAX_TABLE_CODE]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetCurrentBusinessDate]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetGLInfo]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_GL_GetLast_LEDGERNO]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_NUM_ACT_CR_DR]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetBaseCurrency]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetCIFFormatDigits]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetCIFFormatDigitsNum]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetGLFormatDigits]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_OPT_GetGLFormatDigitsNum]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_String_BuildGL]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[RANDBETWEEN]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  Table [dbo].[Settings]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[VerID] [int] IDENTITY(1,1) NOT NULL,
	[EffectiveDate] [date] NULL,
	[GLFormat] [nchar](200) NOT NULL,
	[GLFormatDigits] [nchar](200) NULL,
	[BaseCurrency] [nchar](10) NOT NULL,
	[ACCTFormatDigits] [nchar](200) NULL,
	[ACCTFormatDigitsNum] [nchar](200) NULL,
	[ACCTFormat] [nchar](200) NULL,
	[CIFFormatDigits] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[VerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetSettings]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  Table [dbo].[DEF_Branch]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Branch](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[CompanyNo] [int] NULL,
 CONSTRAINT [PK_DEF_Branch] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Company]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Company](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_DEF_Company] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Dep]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Dep](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Sector]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Sector](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Unit]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Unit](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Zone]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Zone](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_LedgerNature]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_LedgerNature](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[CR_DR] [nchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_GL]    Script Date: 18/11/2020 14:46:31 ******/
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
	[GL] [nvarchar](50) NULL,
	[CURR] [nvarchar](4) NOT NULL,
	[COMMENTS] [nvarchar](200) NULL,
	[EFFECTIVE_DT] [datetime] NOT NULL,
	[STATUS] [tinyint] NOT NULL,
	[REFERENCE] [nvarchar](max) NULL,
 CONSTRAINT [PK_DEF_GL] PRIMARY KEY CLUSTERED 
(
	[GL_DEFID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_DEF_GL]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_String_ParseGL]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  Table [dbo].[DEF_ACCT_CLASS]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_ACCT_CLASS](
	[AccountClassID] [smallint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](5) NOT NULL,
	[Name] [nvarchar](80) NULL,
	[Type] [nvarchar](10) NULL,
	[CompanyNo] [int] NULL,
	[Currency] [nvarchar](5) NULL,
	[EFFECTIVE_DT] [datetime] NULL,
	[REFERENCE] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_DEF_ACCT_CLASS] PRIMARY KEY CLUSTERED 
(
	[AccountClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT](
	[AccountStructID] [smallint] IDENTITY(1,1) NOT NULL,
	[AccountClassCode] [nvarchar](5) NOT NULL,
	[GLNum] [nvarchar](40) NOT NULL,
	[GLCategory] [smallint] NOT NULL,
	[GLComments] [nvarchar](80) NULL,
 CONSTRAINT [PK_DEF_ACCT_CLASS_ACCT_STRUCT] PRIMARY KEY CLUSTERED 
(
	[AccountStructID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_BusinessDate]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  Table [dbo].[DEF_CIF]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CIF](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) NOT NULL,
	[SearchKey] [nvarchar](35) NOT NULL,
	[FirstName] [nvarchar](80) NULL,
	[MiddleName] [nvarchar](80) NULL,
	[LastName] [nvarchar](80) NULL,
	[FamilyName] [nvarchar](80) NULL,
	[CREATE_DT] [datetime] NULL,
	[CIF_TYPE] [smallint] NULL,
	[CIF_CLASS] [nvarchar](10) NULL,
	[RSM] [nvarchar](35) NULL,
	[Gender] [nvarchar](10) NULL,
	[Country] [int] NULL,
	[COUNTRY_OF_BIRTH] [int] NULL,
	[GOVERNORATE] [int] NULL,
	[City] [int] NULL,
	[Area] [int] NULL,
	[Address] [nvarchar](max) NULL,
	[Nationality] [int] NULL,
	[BIRTH_DT] [date] NULL,
	[LAST_SAVE_DT] [datetime] NULL,
	[MobileNumber] [nvarchar](80) NULL,
	[HomeNumber] [nvarchar](80) NULL,
	[WorkNumber] [nvarchar](80) NULL,
	[NationalID] [nvarchar](max) NULL,
 CONSTRAINT [PK__tmp_ms_x__3214EC073F31DDF2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_CIF_CLASS]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CIF_CLASS](
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](80) NOT NULL,
	[Type] [tinyint] NOT NULL,
	[CompanyNo] [smallint] NOT NULL,
	[EFFECTIVE_DT] [datetime] NULL,
	[REFERENCE] [nvarchar](max) NULL,
 CONSTRAINT [PK__DEF_CIF___A25C5AA6127E02BB] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[CompanyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_CIF_Company]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CIF_Company](
	[DEF_CIF_Company_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) NULL,
	[Company_ID] [smallint] NULL,
 CONSTRAINT [PK_DEF_CIF_Company] PRIMARY KEY CLUSTERED 
(
	[DEF_CIF_Company_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_CK_ACCT]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CK_ACCT](
	[DEF_ACCT_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) NOT NULL,
	[ACCT_NO] [nvarchar](35) NOT NULL,
	[Title] [nvarchar](80) NULL,
	[Description] [nvarchar](80) NULL,
	[ReferenceACCT] [nvarchar](35) NULL,
	[ReferenceOrg] [nvarchar](35) NULL,
	[IBAN] [nvarchar](35) NULL,
	[ACCT_TYPE] [nvarchar](10) NOT NULL,
	[ACCT_CLASS] [nvarchar](10) NULL,
	[Currency] [nvarchar](3) NULL,
	[OpenDate] [date] NULL,
	[CSP_Code] [nvarchar](10) NULL,
	[CompanyNo] [smallint] NOT NULL,
	[STATUS] [tinyint] NULL,
 CONSTRAINT [PK_DEF_ACCT] PRIMARY KEY CLUSTERED 
(
	[DEF_ACCT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_CK_ACCT_ACCT_STRUCT]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_CK_ACCT_ACCT_STRUCT](
	[AccountStructID] [smallint] IDENTITY(1,1) NOT NULL,
	[AccountCode] [nvarchar](35) NOT NULL,
	[GLNum] [nvarchar](40) NOT NULL,
	[GLCategory] [smallint] NOT NULL,
	[GLComments] [nvarchar](80) NULL,
 CONSTRAINT [PK_DEF_ACCT_ACCT_STRUCT] PRIMARY KEY CLUSTERED 
(
	[AccountStructID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_Currency]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_Currency](
	[CurrencyID] [smallint] IDENTITY(1,1) NOT NULL,
	[ISOCode] [nvarchar](3) NOT NULL,
	[Symbol] [nvarchar](3) NOT NULL,
	[Fractions] [smallint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_EMP]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_EMP](
	[EMP_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](max) NULL,
	[FirstName] [nvarchar](80) NULL,
	[MiddleName] [nvarchar](80) NULL,
	[LastName] [nvarchar](80) NULL,
	[FamilyName] [nvarchar](80) NULL,
	[CREATE_DT] [datetime] NULL,
	[LAST_SAVE_DT] [datetime] NULL,
	[MobileNumber] [nvarchar](80) NULL,
	[HomeNumber] [nvarchar](80) NULL,
	[WorkNumber] [nvarchar](80) NULL,
	[STATUS_ID] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_FIXRATE_ACCT]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_FIXRATE_ACCT](
	[DEF_ACCT_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) NOT NULL,
	[ACCT_NO] [nvarchar](35) NOT NULL,
	[Title] [nvarchar](80) NULL,
	[Description] [nvarchar](80) NULL,
	[ReferenceACCT] [nvarchar](35) NULL,
	[ReferenceOrg] [nvarchar](35) NULL,
	[IBAN] [nvarchar](35) NULL,
	[ACCT_TYPE] [nvarchar](10) NOT NULL,
	[ACCT_CLASS] [nvarchar](10) NULL,
	[Currency] [nvarchar](3) NULL,
	[OpenDate] [date] NOT NULL,
	[CreateDate] [date] NOT NULL,
	[CloseDate] [date] NOT NULL,
	[Principle] [decimal](32, 2) NOT NULL,
	[Rate] [decimal](32, 30) NULL,
	[AccrualBasis] [tinyint] NULL,
	[CSP_Code] [nvarchar](10) NULL,
	[CompanyNo] [smallint] NOT NULL,
	[STATUS_ID] [tinyint] NOT NULL,
 CONSTRAINT [PK_DEF_FIXRATE_ACCT] PRIMARY KEY CLUSTERED 
(
	[DEF_ACCT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEF_FIXRATE_ACCT_DATES]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEF_FIXRATE_ACCT_DATES](
	[DEF_FIXRATE_ACCT_DATES_ID] [int] IDENTITY(1,1) NOT NULL,
	[DEF_ACCT_ID] [int] NOT NULL,
	[ACCT_NO] [nvarchar](35) NOT NULL,
	[ACCT_DATE] [date] NOT NULL,
 CONSTRAINT [PK_DEF_FIXRATE_ACCT_DATES] PRIMARY KEY CLUSTERED 
(
	[DEF_FIXRATE_ACCT_DATES_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExchangeRates]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeRates](
	[FromCurIsoCode] [nchar](3) NOT NULL,
	[ToCurIsoCode] [nchar](3) NOT NULL,
	[Rate] [decimal](24, 9) NULL,
	[ExRateDate] [datetime] NULL,
	[TimeEXC] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_ACCRUAL_BASIS]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_ACCRUAL_BASIS](
	[ID] [tinyint] NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_ACCT_TYPE]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_ACCT_TYPE](
	[ID] [smallint] NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_AE_CATEGORY]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_AE_CATEGORY](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](80) NOT NULL,
	[Description] [nvarchar](80) NULL,
	[ParentCat] [smallint] NULL,
 CONSTRAINT [PK_LUT_AE_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_CIF_TYPE]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_CIF_TYPE](
	[Code] [tinyint] NOT NULL,
	[Name] [nvarchar](80) NULL,
 CONSTRAINT [PK__LUT_CIF___A25C5AA6A1F27BC6] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_CITY]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_CITY](
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](80) NOT NULL,
	[CountryCode] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_LUT_CITY] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_COUNTRY]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_COUNTRY](
	[ID] [smallint] NOT NULL,
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](80) NULL,
 CONSTRAINT [PK_LUT_COUNTRY] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_GL_ACCT_CATEGORY]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_GL_ACCT_CATEGORY](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](80) NOT NULL,
	[Description] [nvarchar](80) NULL,
	[ParentCat] [smallint] NULL,
 CONSTRAINT [PK_LUT_GL_ACCT_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_LedgerPostingLevel]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_LedgerPostingLevel](
	[ID] [tinyint] NOT NULL,
	[PostingLevel] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_OBJ_STATUS]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_OBJ_STATUS](
	[STATUS_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUT_TRN_STATUS]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUT_TRN_STATUS](
	[STATUS_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROC_FIXRATE_INTEREST]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROC_FIXRATE_INTEREST](
	[PROC_FIXRATE_INTEREST_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) NOT NULL,
	[ACCT_NO] [nvarchar](35) NOT NULL,
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
/****** Object:  Table [dbo].[TRN_LEGS]    Script Date: 18/11/2020 14:46:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRN_LEGS](
	[TRN_LEGS_ID] [int] IDENTITY(1,1) NOT NULL,
	[Ref] [uniqueidentifier] NULL,
	[Sequence] [smallint] NULL,
	[Acct_CR_DR] [nvarchar](2) NULL,
	[Acct_No] [nvarchar](max) NULL,
	[GL] [bit] NULL,
	[Balance_Before] [decimal](28, 3) NULL,
	[Trn_Amt] [decimal](28, 3) NULL,
	[Balance_After] [decimal](28, 3) NULL,
	[Acct_Curr] [nvarchar](3) NULL,
	[EffDt] [date] NULL,
	[CREATE_DT] [datetime] NULL,
	[EMP_ID] [smallint] NULL,
	[STATUS_ID] [tinyint] NOT NULL,
	[CHANNEL_ID] [smallint] NULL,
	[Category] [smallint] NULL,
	[Acct_Description] [nvarchar](max) NULL,
	[Related_Ref] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TRN_LEGS] PRIMARY KEY CLUSTERED 
(
	[TRN_LEGS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DEF_ACCT_CLASS] ON 
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (1, N'00001', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (2, N'00002', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (3, N'00003', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (4, N'00004', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (5, N'00005', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (6, N'00006', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (7, N'00007', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (8, N'00008', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (9, N'00009', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (10, N'00010', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (11, N'00011', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (12, N'00012', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (13, N'00013', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
SET IDENTITY_INSERT [dbo].[DEF_ACCT_CLASS] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ON 
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (2, N'00001', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (3, N'00001', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (4, N'00002', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (5, N'00002', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (6, N'00003', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (7, N'00003', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (8, N'00004', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (9, N'00004', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (10, N'00005', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (11, N'00005', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (12, N'00006', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (13, N'00006', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (14, N'00007', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (15, N'00007', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (16, N'00008', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (17, N'00008', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (18, N'00009', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (19, N'00009', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (20, N'00010', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (21, N'00010', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (22, N'00011', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (23, N'00011', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (24, N'00012', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (25, N'00012', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (26, N'00013', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (27, N'00013', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_Branch] ON 
GO
INSERT [dbo].[DEF_Branch] ([ID], [Name], [CompanyNo]) VALUES (1, N'Br1', NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_Branch] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_BusinessDate] ON 
GO
INSERT [dbo].[DEF_BusinessDate] ([ID], [BusinessDay], [IsClosed], [IsEndOfWeek], [IsEndOfMonth], [IsEndOfQuarter], [IsEndOfYear]) VALUES (1, CAST(N'2019-07-30' AS Date), 0, 0, 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[DEF_BusinessDate] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_CIF] ON 
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (1, N'000000001', N'000000001', N'SOSO', N'', N'', NULL, CAST(N'2020-11-16T15:52:22.637' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (2, N'000000002', N'000000002', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.363' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (3, N'000000003', N'000000003', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.397' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (4, N'000000004', N'000000004', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.473' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (5, N'000000005', N'000000005', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.583' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (6, N'000000006', N'000000006', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.617' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (7, N'000000007', N'000000007', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.643' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (8, N'000000008', N'000000008', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.693' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (9, N'000000009', N'000000009', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.750' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (10, N'000000010', N'000000010', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.840' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (11, N'000000011', N'000000011', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.920' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (12, N'000000012', N'000000012', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.043' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (13, N'000000013', N'000000013', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.087' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (14, N'000000014', N'000000014', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.170' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (15, N'000000015', N'000000015', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.253' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (16, N'000000016', N'000000016', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.350' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (17, N'000000017', N'000000017', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.387' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (18, N'000000018', N'000000018', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.430' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (19, N'000000019', N'000000019', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.483' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (20, N'000000020', N'000000020', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.597' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (21, N'000000021', N'000000021', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.680' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (22, N'000000022', N'000000022', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:24.947' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (23, N'000000023', N'000000023', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.007' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (24, N'000000024', N'000000024', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.060' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (25, N'000000025', N'000000025', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.090' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (26, N'000000026', N'000000026', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.123' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (27, N'000000027', N'000000027', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.150' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (28, N'000000028', N'000000028', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.203' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (29, N'000000029', N'000000029', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.250' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (30, N'000000030', N'000000030', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.303' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (31, N'000000031', N'000000031', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.360' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (32, N'000000032', N'000000032', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.380' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (33, N'000000033', N'000000033', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.440' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (34, N'000000034', N'000000034', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.500' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (35, N'000000035', N'000000035', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.547' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (36, N'000000036', N'000000036', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.597' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (37, N'000000037', N'000000037', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.620' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (38, N'000000038', N'000000038', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.633' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (39, N'000000039', N'000000039', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.647' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (40, N'000000040', N'000000040', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.680' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (41, N'000000041', N'000000041', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.740' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (42, N'000000042', N'000000042', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.820' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (43, N'000000043', N'000000043', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:25.983' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (44, N'000000044', N'000000044', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:26.220' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (45, N'000000045', N'000000045', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:26.383' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (46, N'000000046', N'000000046', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:26.620' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (47, N'000000047', N'000000047', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:26.763' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (48, N'000000048', N'000000048', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:26.937' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (49, N'000000049', N'000000049', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.080' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (50, N'000000050', N'000000050', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.120' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (51, N'000000051', N'000000051', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.133' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (52, N'000000052', N'000000052', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.163' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (53, N'000000053', N'000000053', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.220' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (54, N'000000054', N'000000054', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.280' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (55, N'000000055', N'000000055', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.323' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (56, N'000000056', N'000000056', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.337' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (57, N'000000057', N'000000057', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.353' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (58, N'000000058', N'000000058', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.367' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (59, N'000000059', N'000000059', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.377' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (60, N'000000060', N'000000060', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.403' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (61, N'000000061', N'000000061', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.450' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (62, N'000000062', N'000000062', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.513' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (63, N'000000063', N'000000063', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.567' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (64, N'000000064', N'000000064', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.597' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (65, N'000000065', N'000000065', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.640' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (66, N'000000066', N'000000066', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.720' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (67, N'000000067', N'000000067', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.787' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (68, N'000000068', N'000000068', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.833' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (69, N'000000069', N'000000069', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.850' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (70, N'000000070', N'000000070', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.867' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (71, N'000000071', N'000000071', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.883' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (72, N'000000072', N'000000072', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.913' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (73, N'000000073', N'000000073', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:27.957' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (74, N'000000074', N'000000074', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.003' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (75, N'000000075', N'000000075', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.053' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (76, N'000000076', N'000000076', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.090' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (77, N'000000077', N'000000077', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.107' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (78, N'000000078', N'000000078', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.133' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (79, N'000000079', N'000000079', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.180' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (80, N'000000080', N'000000080', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.230' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (81, N'000000081', N'000000081', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.273' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (82, N'000000082', N'000000082', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.330' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (83, N'000000083', N'000000083', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.470' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (84, N'000000084', N'000000084', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.593' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (85, N'000000085', N'000000085', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.677' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (86, N'000000086', N'000000086', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.733' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (87, N'000000087', N'000000087', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.837' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (88, N'000000088', N'000000088', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:28.967' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (89, N'000000089', N'000000089', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.063' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (90, N'000000090', N'000000090', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.100' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (91, N'000000091', N'000000091', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.117' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (92, N'000000092', N'000000092', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.147' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (93, N'000000093', N'000000093', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.197' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (94, N'000000094', N'000000094', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.253' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (95, N'000000095', N'000000095', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.337' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (96, N'000000096', N'000000096', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.350' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (97, N'000000097', N'000000097', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.370' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (98, N'000000098', N'000000098', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.383' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (99, N'000000099', N'000000099', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.417' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (100, N'000000100', N'000000100', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.503' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (101, N'000000101', N'000000101', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:29.553' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
SET IDENTITY_INSERT [dbo].[DEF_CIF] OFF
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0001', N'CIF Class 1', 1, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0001', N'CIF Class 1', 1, 2, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0002', N'CIF Class 1', 1, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0002', N'CIF Class 1', 1, 2, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0003', N'CIF Class 1', 1, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0003', N'CIF Class 1', 1, 2, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0004', N'CIF Class 1', 1, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0004', N'CIF Class 1', 1, 2, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0005', N'CIF Class 1', 1, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0005', N'CIF Class 1', 1, 2, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0006', N'CIF Class 1', 2, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0006', N'CIF Class 1', 1, 2, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0007', N'CIF Class 1', 2, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_CIF_Company] ON 
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (1, N'000000001', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (2, N'000000001', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (3, N'000000002', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (4, N'000000002', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (5, N'000000003', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (6, N'000000003', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (7, N'000000004', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (8, N'000000004', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (9, N'000000005', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (10, N'000000005', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (11, N'000000006', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (12, N'000000006', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (13, N'000000007', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (14, N'000000007', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (15, N'000000008', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (16, N'000000008', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (17, N'000000009', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (18, N'000000009', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (19, N'000000010', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (20, N'000000010', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (21, N'000000011', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (22, N'000000011', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (23, N'000000012', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (24, N'000000012', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (25, N'000000013', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (26, N'000000013', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (27, N'000000014', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (28, N'000000014', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (29, N'000000015', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (30, N'000000015', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (31, N'000000016', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (32, N'000000016', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (33, N'000000017', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (34, N'000000017', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (35, N'000000018', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (36, N'000000018', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (37, N'000000019', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (38, N'000000019', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (39, N'000000020', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (40, N'000000020', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (41, N'000000021', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (42, N'000000021', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (43, N'000000022', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (44, N'000000022', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (45, N'000000023', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (46, N'000000023', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (47, N'000000024', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (48, N'000000024', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (49, N'000000025', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (50, N'000000025', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (51, N'000000026', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (52, N'000000026', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (53, N'000000027', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (54, N'000000027', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (55, N'000000028', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (56, N'000000028', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (57, N'000000029', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (58, N'000000029', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (59, N'000000030', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (60, N'000000030', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (61, N'000000031', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (62, N'000000031', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (63, N'000000032', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (64, N'000000032', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (65, N'000000033', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (66, N'000000033', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (67, N'000000034', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (68, N'000000034', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (69, N'000000035', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (70, N'000000035', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (71, N'000000036', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (72, N'000000036', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (73, N'000000037', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (74, N'000000037', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (75, N'000000038', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (76, N'000000038', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (77, N'000000039', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (78, N'000000039', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (79, N'000000040', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (80, N'000000040', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (81, N'000000041', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (82, N'000000041', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (83, N'000000042', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (84, N'000000042', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (85, N'000000043', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (86, N'000000043', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (87, N'000000044', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (88, N'000000044', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (89, N'000000045', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (90, N'000000045', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (91, N'000000046', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (92, N'000000046', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (93, N'000000047', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (94, N'000000047', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (95, N'000000048', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (96, N'000000048', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (97, N'000000049', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (98, N'000000049', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (99, N'000000050', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (100, N'000000050', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (101, N'000000051', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (102, N'000000051', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (103, N'000000052', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (104, N'000000052', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (105, N'000000053', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (106, N'000000053', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (107, N'000000054', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (108, N'000000054', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (109, N'000000055', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (110, N'000000055', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (111, N'000000056', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (112, N'000000056', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (113, N'000000057', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (114, N'000000057', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (115, N'000000058', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (116, N'000000058', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (117, N'000000059', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (118, N'000000059', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (119, N'000000060', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (120, N'000000060', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (121, N'000000061', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (122, N'000000061', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (123, N'000000062', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (124, N'000000062', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (125, N'000000063', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (126, N'000000063', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (127, N'000000064', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (128, N'000000064', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (129, N'000000065', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (130, N'000000065', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (131, N'000000066', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (132, N'000000066', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (133, N'000000067', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (134, N'000000067', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (135, N'000000068', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (136, N'000000068', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (137, N'000000069', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (138, N'000000069', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (139, N'000000070', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (140, N'000000070', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (141, N'000000071', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (142, N'000000071', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (143, N'000000072', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (144, N'000000072', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (145, N'000000073', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (146, N'000000073', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (147, N'000000074', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (148, N'000000074', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (149, N'000000075', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (150, N'000000075', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (151, N'000000076', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (152, N'000000076', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (153, N'000000077', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (154, N'000000077', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (155, N'000000078', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (156, N'000000078', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (157, N'000000079', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (158, N'000000079', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (159, N'000000080', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (160, N'000000080', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (161, N'000000081', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (162, N'000000081', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (163, N'000000082', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (164, N'000000082', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (165, N'000000083', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (166, N'000000083', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (167, N'000000084', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (168, N'000000084', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (169, N'000000085', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (170, N'000000085', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (171, N'000000086', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (172, N'000000086', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (173, N'000000087', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (174, N'000000087', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (175, N'000000088', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (176, N'000000088', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (177, N'000000089', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (178, N'000000089', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (179, N'000000090', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (180, N'000000090', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (181, N'000000091', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (182, N'000000091', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (183, N'000000092', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (184, N'000000092', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (185, N'000000093', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (186, N'000000093', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (187, N'000000094', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (188, N'000000094', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (189, N'000000095', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (190, N'000000095', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (191, N'000000096', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (192, N'000000096', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (193, N'000000097', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (194, N'000000097', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (195, N'000000098', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (196, N'000000098', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (197, N'000000099', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (198, N'000000099', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (199, N'000000100', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (200, N'000000100', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (201, N'000000101', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (202, N'000000101', 2)
GO
SET IDENTITY_INSERT [dbo].[DEF_CIF_Company] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_CK_ACCT] ON 
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (2, N'000000001', N'000000000000001', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (3, N'000000001', N'000000000000002', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (4, N'000000001', N'000000000000003', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (5, N'000000001', N'000000000000004', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (6, N'000000001', N'000000000000005', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (7, N'000000001', N'000000000000006', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (8, N'000000001', N'000000000000007', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (9, N'000000001', N'000000000000008', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (10, N'000000001', N'000000000000009', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (11, N'000000001', N'000000000000010', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (12, N'000000001', N'000000000000011', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (13, N'000000001', N'000000000000012', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (14, N'000000001', N'000000000000013', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (15, N'000000001', N'000000000000014', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (16, N'000000001', N'000000000000015', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (17, N'000000001', N'000000000000016', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (18, N'000000001', N'000000000000017', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (19, N'000000001', N'000000000000018', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (20, N'000000001', N'000000000000019', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (21, N'000000001', N'000000000000020', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (22, N'000000001', N'000000000000021', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (23, N'000000001', N'000000000000022', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (24, N'000000001', N'000000000000023', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (25, N'000000001', N'000000000000024', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (26, N'000000001', N'000000000000025', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (27, N'000000001', N'000000000000026', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (28, N'000000001', N'000000000000027', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (29, N'000000001', N'000000000000028', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (30, N'000000001', N'000000000000029', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (31, N'000000001', N'000000000000030', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (32, N'000000001', N'000000000000031', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (33, N'000000001', N'000000000000032', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (34, N'000000001', N'000000000000033', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (35, N'000000001', N'000000000000034', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (36, N'000000001', N'000000000000035', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (37, N'000000001', N'000000000000036', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (38, N'000000001', N'000000000000037', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (39, N'000000001', N'000000000000038', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (40, N'000000001', N'000000000000039', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (41, N'000000001', N'000000000000040', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (42, N'000000001', N'000000000000041', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[DEF_CK_ACCT] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ON 
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (1, N'000000000000001', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (2, N'000000000000001', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (3, N'000000000000002', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (4, N'000000000000002', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (5, N'000000000000003', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (6, N'000000000000003', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (7, N'000000000000004', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (8, N'000000000000004', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (9, N'000000000000005', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (10, N'000000000000005', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (11, N'000000000000006', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (12, N'000000000000006', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (13, N'000000000000007', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (14, N'000000000000007', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (15, N'000000000000008', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (16, N'000000000000008', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (17, N'000000000000009', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (18, N'000000000000009', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (19, N'000000000000010', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (20, N'000000000000010', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (21, N'000000000000011', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (22, N'000000000000011', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (23, N'000000000000012', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (24, N'000000000000012', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (25, N'000000000000013', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (26, N'000000000000013', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (27, N'000000000000014', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (28, N'000000000000014', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (29, N'000000000000015', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (30, N'000000000000015', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (31, N'000000000000016', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (32, N'000000000000016', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (33, N'000000000000017', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (34, N'000000000000017', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (35, N'000000000000018', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (36, N'000000000000018', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (37, N'000000000000019', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (38, N'000000000000019', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (39, N'000000000000020', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (40, N'000000000000020', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (41, N'000000000000021', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (42, N'000000000000021', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (43, N'000000000000022', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (44, N'000000000000022', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (45, N'000000000000023', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (46, N'000000000000023', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (47, N'000000000000024', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (48, N'000000000000024', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (49, N'000000000000025', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (50, N'000000000000025', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (51, N'000000000000026', N'2-01-02-0000-00-00-00-0000-1-000032', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (52, N'000000000000026', N'2-01-02-0000-00-00-00-0000-1-000032', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (53, N'000000000000027', N'2-01-02-0000-00-00-00-0000-1-000032', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (54, N'000000000000027', N'2-01-02-0000-00-00-00-0000-1-000032', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (55, N'000000000000028', N'2-01-02-0000-00-00-00-0000-1-000032', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (56, N'000000000000028', N'2-01-02-0000-00-00-00-0000-1-000032', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (57, N'000000000000029', N'2-01-02-0000-00-00-00-0000-1-000045', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (58, N'000000000000029', N'2-01-02-0000-00-00-00-0000-1-000044', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (59, N'000000000000030', N'2-01-02-0000-00-00-00-0000-1-000032', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (60, N'000000000000030', N'2-01-02-0000-00-00-00-0000-1-000032', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (61, N'000000000000031', N'2-01-02-0000-00-00-00-0000-1-000045', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (62, N'000000000000031', N'2-01-02-0000-00-00-00-0000-1-000044', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (63, N'000000000000032', N'2-01-02-0000-00-00-00-0000-1-000032', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (64, N'000000000000032', N'2-01-02-0000-00-00-00-0000-1-000032', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (65, N'000000000000033', N'2-01-02-0000-00-00-00-0000-1-000045', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (66, N'000000000000033', N'2-01-02-0000-00-00-00-0000-1-000044', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (67, N'000000000000034', N'2-01-02-0000-00-00-00-0000-1-000032', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (68, N'000000000000034', N'2-01-02-0000-00-00-00-0000-1-000032', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (69, N'000000000000035', N'2-01-02-0000-00-00-00-0000-1-000045', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (70, N'000000000000035', N'2-01-02-0000-00-00-00-0000-1-000044', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (71, N'000000000000036', N'2-01-02-0000-00-00-00-0000-1-000032', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (72, N'000000000000036', N'2-01-02-0000-00-00-00-0000-1-000032', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (73, N'000000000000037', N'2-01-02-0000-00-00-00-0000-1-000045', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (74, N'000000000000037', N'2-01-02-0000-00-00-00-0000-1-000044', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (75, N'000000000000038', N'2-01-02-0000-00-00-00-0000-1-000032', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (76, N'000000000000038', N'2-01-02-0000-00-00-00-0000-1-000032', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (77, N'000000000000039', N'2-01-02-0000-00-00-00-0000-1-000045', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (78, N'000000000000039', N'2-01-02-0000-00-00-00-0000-1-000044', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (79, N'000000000000040', N'2-01-02-0000-00-00-00-0000-1-000032', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (80, N'000000000000040', N'2-01-02-0000-00-00-00-0000-1-000032', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (81, N'000000000000041', N'2-01-02-0000-00-00-00-0000-1-000045', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (82, N'000000000000041', N'2-01-02-0000-00-00-00-0000-1-000044', 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_Company] ON 
GO
INSERT [dbo].[DEF_Company] ([ID], [Name]) VALUES (1, N'Company1')
GO
INSERT [dbo].[DEF_Company] ([ID], [Name]) VALUES (2, N'Retail')
GO
SET IDENTITY_INSERT [dbo].[DEF_Company] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_Currency] ON 
GO
INSERT [dbo].[DEF_Currency] ([CurrencyID], [ISOCode], [Symbol], [Fractions], [Name]) VALUES (1, N'EGP', N'EGP', 2, N'Egyption Pounds')
GO
INSERT [dbo].[DEF_Currency] ([CurrencyID], [ISOCode], [Symbol], [Fractions], [Name]) VALUES (2, N'USD', N'USD', 2, N'Dollar')
GO
INSERT [dbo].[DEF_Currency] ([CurrencyID], [ISOCode], [Symbol], [Fractions], [Name]) VALUES (3, N'AUD', N'AUD', 2, N'Australian dollar')
GO
SET IDENTITY_INSERT [dbo].[DEF_Currency] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_Dep] ON 
GO
INSERT [dbo].[DEF_Dep] ([ID], [Name]) VALUES (1, N'Dep1')
GO
SET IDENTITY_INSERT [dbo].[DEF_Dep] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_FIXRATE_ACCT] ON 
GO
INSERT [dbo].[DEF_FIXRATE_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CreateDate], [CloseDate], [Principle], [Rate], [AccrualBasis], [CSP_Code], [CompanyNo], [STATUS_ID]) VALUES (1, N'000000001', N'000000000000001', NULL, NULL, NULL, NULL, NULL, N'FIXRATE', NULL, N'EGP', CAST(N'2020-02-01' AS Date), CAST(N'2020-01-01' AS Date), CAST(N'2020-12-30' AS Date), CAST(1000000.00 AS Decimal(32, 2)), CAST(5.500000000000000000000000000000 AS Decimal(32, 30)), NULL, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[DEF_FIXRATE_ACCT] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_FIXRATE_ACCT_DATES] ON 
GO
INSERT [dbo].[DEF_FIXRATE_ACCT_DATES] ([DEF_FIXRATE_ACCT_DATES_ID], [DEF_ACCT_ID], [ACCT_NO], [ACCT_DATE]) VALUES (1, 0, N'000000000000001', CAST(N'2020-12-30' AS Date))
GO
SET IDENTITY_INSERT [dbo].[DEF_FIXRATE_ACCT_DATES] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_GL] ON 
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (301, 1, 2, 0, 0, 0, 0, 0, 2, 1, 1, N'2-01-02-0000-00-00-00-0000-1-000001     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (302, 1, 2, 0, 0, 0, 0, 0, 2, 1, 2, N'2-01-02-0000-00-00-00-0000-1-000002     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (303, 1, 2, 0, 0, 0, 0, 0, 2, 1, 3, N'2-01-02-0000-00-00-00-0000-1-000003     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (304, 1, 2, 0, 0, 0, 0, 0, 2, 1, 4, N'2-01-02-0000-00-00-00-0000-1-000004     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (305, 1, 2, 0, 0, 0, 0, 0, 2, 1, 5, N'2-01-02-0000-00-00-00-0000-1-000005     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (306, 1, 2, 0, 0, 0, 0, 0, 2, 1, 6, N'2-01-02-0000-00-00-00-0000-1-000006     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (307, 1, 2, 0, 0, 0, 0, 0, 2, 1, 7, N'2-01-02-0000-00-00-00-0000-1-000007     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (308, 1, 2, 0, 0, 0, 0, 0, 2, 1, 8, N'2-01-02-0000-00-00-00-0000-1-000008     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (309, 1, 2, 0, 0, 0, 0, 0, 2, 1, 9, N'2-01-02-0000-00-00-00-0000-1-000009     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (310, 1, 2, 0, 0, 0, 0, 0, 2, 1, 10, N'2-01-02-0000-00-00-00-0000-1-000010     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (311, 1, 2, 0, 0, 0, 0, 0, 2, 1, 11, N'2-01-02-0000-00-00-00-0000-1-000011     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (312, 1, 2, 0, 0, 0, 0, 0, 2, 1, 12, N'2-01-02-0000-00-00-00-0000-1-000012     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (313, 1, 2, 0, 0, 0, 0, 0, 2, 1, 13, N'2-01-02-0000-00-00-00-0000-1-000013     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (314, 1, 2, 0, 0, 0, 0, 0, 2, 1, 14, N'2-01-02-0000-00-00-00-0000-1-000014     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (315, 1, 2, 0, 0, 0, 0, 0, 2, 1, 15, N'2-01-02-0000-00-00-00-0000-1-000015     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (316, 1, 2, 0, 0, 0, 0, 0, 2, 1, 16, N'2-01-02-0000-00-00-00-0000-1-000016     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (317, 1, 2, 0, 0, 0, 0, 0, 2, 1, 17, N'2-01-02-0000-00-00-00-0000-1-000017     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (318, 1, 2, 0, 0, 0, 0, 0, 2, 1, 18, N'2-01-02-0000-00-00-00-0000-1-000018     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (319, 1, 2, 0, 0, 0, 0, 0, 2, 1, 19, N'2-01-02-0000-00-00-00-0000-1-000019     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (320, 1, 2, 0, 0, 0, 0, 0, 2, 1, 20, N'2-01-02-0000-00-00-00-0000-1-000020     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (321, 1, 2, 0, 0, 0, 0, 0, 2, 1, 21, N'2-01-02-0000-00-00-00-0000-1-000021     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (322, 1, 2, 0, 0, 0, 0, 0, 2, 1, 22, N'2-01-02-0000-00-00-00-0000-1-000022     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (323, 1, 2, 0, 0, 0, 0, 0, 2, 1, 23, N'2-01-02-0000-00-00-00-0000-1-000023     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (324, 1, 2, 0, 0, 0, 0, 0, 2, 1, 24, N'2-01-02-0000-00-00-00-0000-1-000024     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (325, 1, 2, 0, 0, 0, 0, 0, 2, 1, 25, N'2-01-02-0000-00-00-00-0000-1-000025     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (326, 1, 2, 0, 0, 0, 0, 0, 2, 1, 26, N'2-01-02-0000-00-00-00-0000-1-000026     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (327, 1, 2, 0, 0, 0, 0, 0, 2, 1, 27, N'2-01-02-0000-00-00-00-0000-1-000027     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (328, 1, 2, 0, 0, 0, 0, 0, 2, 1, 28, N'2-01-02-0000-00-00-00-0000-1-000028     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (329, 1, 2, 0, 0, 0, 0, 0, 2, 1, 29, N'2-01-02-0000-00-00-00-0000-1-000029     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (330, 1, 2, 0, 0, 0, 0, 0, 2, 1, 30, N'2-01-02-0000-00-00-00-0000-1-000030     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (331, 1, 2, 0, 0, 0, 0, 0, 2, 1, 31, N'2-01-02-0000-00-00-00-0000-1-000031     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (332, 1, 2, 0, 0, 0, 0, 0, 2, 1, 32, N'2-01-02-0000-00-00-00-0000-1-000032     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (333, 1, 2, 0, 0, 0, 0, 0, 2, 1, 33, N'2-01-02-0000-00-00-00-0000-1-000033     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (334, 1, 2, 0, 0, 0, 0, 0, 2, 1, 34, N'2-01-02-0000-00-00-00-0000-1-000034     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (335, 1, 2, 0, 0, 0, 0, 0, 2, 1, 35, N'2-01-02-0000-00-00-00-0000-1-000035     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (336, 1, 2, 0, 0, 0, 0, 0, 2, 1, 36, N'2-01-02-0000-00-00-00-0000-1-000036     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (337, 1, 2, 0, 0, 0, 0, 0, 2, 1, 37, N'2-01-02-0000-00-00-00-0000-1-000037     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (338, 1, 2, 0, 0, 0, 0, 0, 2, 1, 38, N'2-01-02-0000-00-00-00-0000-1-000038     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (339, 1, 2, 0, 0, 0, 0, 0, 2, 1, 39, N'2-01-02-0000-00-00-00-0000-1-000039     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (340, 1, 2, 0, 0, 0, 0, 0, 2, 1, 40, N'2-01-02-0000-00-00-00-0000-1-000040     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (341, 1, 2, 0, 0, 0, 0, 0, 2, 1, 41, N'2-01-02-0000-00-00-00-0000-1-000041     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (342, 1, 2, 0, 0, 0, 0, 0, 2, 1, 42, N'2-01-02-0000-00-00-00-0000-1-000042     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (343, 1, 2, 0, 0, 0, 0, 0, 2, 1, 43, N'2-01-02-0000-00-00-00-0000-1-000043     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (344, 1, 2, 0, 0, 0, 0, 0, 2, 1, 44, N'2-01-02-0000-00-00-00-0000-1-000044     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (345, 1, 2, 0, 0, 0, 0, 0, 2, 1, 45, N'2-01-02-0000-00-00-00-0000-1-000045     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (346, 1, 2, 0, 0, 0, 0, 0, 2, 1, 46, N'2-01-02-0000-00-00-00-0000-1-000046     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (347, 1, 2, 0, 0, 0, 0, 0, 2, 1, 47, N'2-01-02-0000-00-00-00-0000-1-000047     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (348, 1, 2, 0, 0, 0, 0, 0, 2, 1, 48, N'2-01-02-0000-00-00-00-0000-1-000048     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (349, 1, 2, 0, 0, 0, 0, 0, 2, 1, 49, N'2-01-02-0000-00-00-00-0000-1-000049     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (350, 1, 2, 0, 0, 0, 0, 0, 2, 1, 50, N'2-01-02-0000-00-00-00-0000-1-000050     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (351, 1, 2, 0, 0, 0, 0, 0, 2, 1, 51, N'2-01-02-0000-00-00-00-0000-1-000051     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (352, 1, 2, 0, 0, 0, 0, 0, 2, 1, 52, N'2-01-02-0000-00-00-00-0000-1-000052     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (353, 1, 2, 0, 0, 0, 0, 0, 2, 1, 53, N'2-01-02-0000-00-00-00-0000-1-000053     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (354, 1, 2, 0, 0, 0, 0, 0, 2, 1, 54, N'2-01-02-0000-00-00-00-0000-1-000054     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (355, 1, 2, 0, 0, 0, 0, 0, 2, 1, 55, N'2-01-02-0000-00-00-00-0000-1-000055     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (356, 1, 2, 0, 0, 0, 0, 0, 2, 1, 56, N'2-01-02-0000-00-00-00-0000-1-000056     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (357, 1, 2, 0, 0, 0, 0, 0, 2, 1, 57, N'2-01-02-0000-00-00-00-0000-1-000057     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (358, 1, 2, 0, 0, 0, 0, 0, 2, 1, 58, N'2-01-02-0000-00-00-00-0000-1-000058     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (359, 1, 2, 0, 0, 0, 0, 0, 2, 1, 59, N'2-01-02-0000-00-00-00-0000-1-000059     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (360, 1, 2, 0, 0, 0, 0, 0, 2, 1, 60, N'2-01-02-0000-00-00-00-0000-1-000060     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (361, 1, 2, 0, 0, 0, 0, 0, 2, 1, 61, N'2-01-02-0000-00-00-00-0000-1-000061     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (362, 1, 2, 0, 0, 0, 0, 0, 2, 1, 62, N'2-01-02-0000-00-00-00-0000-1-000062     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (363, 1, 2, 0, 0, 0, 0, 0, 2, 1, 63, N'2-01-02-0000-00-00-00-0000-1-000063     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (364, 1, 2, 0, 0, 0, 0, 0, 2, 1, 64, N'2-01-02-0000-00-00-00-0000-1-000064     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (365, 1, 2, 0, 0, 0, 0, 0, 2, 1, 65, N'2-01-02-0000-00-00-00-0000-1-000065     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (366, 1, 2, 0, 0, 0, 0, 0, 2, 1, 66, N'2-01-02-0000-00-00-00-0000-1-000066     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (367, 1, 2, 0, 0, 0, 0, 0, 2, 1, 67, N'2-01-02-0000-00-00-00-0000-1-000067     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (368, 1, 2, 0, 0, 0, 0, 0, 2, 1, 68, N'2-01-02-0000-00-00-00-0000-1-000068     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (369, 1, 2, 0, 0, 0, 0, 0, 2, 1, 69, N'2-01-02-0000-00-00-00-0000-1-000069     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (370, 1, 2, 0, 0, 0, 0, 0, 2, 1, 70, N'2-01-02-0000-00-00-00-0000-1-000070     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (371, 1, 2, 0, 0, 0, 0, 0, 2, 1, 71, N'2-01-02-0000-00-00-00-0000-1-000071     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (372, 1, 2, 0, 0, 0, 0, 0, 2, 1, 72, N'2-01-02-0000-00-00-00-0000-1-000072     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (373, 1, 2, 0, 0, 0, 0, 0, 2, 1, 73, N'2-01-02-0000-00-00-00-0000-1-000073     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (374, 1, 2, 0, 0, 0, 0, 0, 2, 1, 74, N'2-01-02-0000-00-00-00-0000-1-000074     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (375, 1, 2, 0, 0, 0, 0, 0, 2, 1, 75, N'2-01-02-0000-00-00-00-0000-1-000075     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (376, 1, 2, 0, 0, 0, 0, 0, 2, 1, 76, N'2-01-02-0000-00-00-00-0000-1-000076     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (377, 1, 2, 0, 0, 0, 0, 0, 2, 1, 77, N'2-01-02-0000-00-00-00-0000-1-000077     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (378, 1, 2, 0, 0, 0, 0, 0, 2, 1, 78, N'2-01-02-0000-00-00-00-0000-1-000078     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (379, 1, 2, 0, 0, 0, 0, 0, 2, 1, 79, N'2-01-02-0000-00-00-00-0000-1-000079     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (380, 1, 2, 0, 0, 0, 0, 0, 2, 1, 80, N'2-01-02-0000-00-00-00-0000-1-000080     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (381, 1, 2, 0, 0, 0, 0, 0, 2, 1, 81, N'2-01-02-0000-00-00-00-0000-1-000081     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (382, 1, 2, 0, 0, 0, 0, 0, 2, 1, 82, N'2-01-02-0000-00-00-00-0000-1-000082     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (383, 1, 2, 0, 0, 0, 0, 0, 2, 1, 83, N'2-01-02-0000-00-00-00-0000-1-000083     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (384, 1, 2, 0, 0, 0, 0, 0, 2, 1, 84, N'2-01-02-0000-00-00-00-0000-1-000084     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (385, 1, 2, 0, 0, 0, 0, 0, 2, 1, 85, N'2-01-02-0000-00-00-00-0000-1-000085     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (386, 1, 2, 0, 0, 0, 0, 0, 2, 1, 86, N'2-01-02-0000-00-00-00-0000-1-000086     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (387, 1, 2, 0, 0, 0, 0, 0, 2, 1, 87, N'2-01-02-0000-00-00-00-0000-1-000087     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (388, 1, 2, 0, 0, 0, 0, 0, 2, 1, 88, N'2-01-02-0000-00-00-00-0000-1-000088     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (389, 1, 2, 0, 0, 0, 0, 0, 2, 1, 89, N'2-01-02-0000-00-00-00-0000-1-000089     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (390, 1, 2, 0, 0, 0, 0, 0, 2, 1, 90, N'2-01-02-0000-00-00-00-0000-1-000090     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (391, 1, 2, 0, 0, 0, 0, 0, 2, 1, 91, N'2-01-02-0000-00-00-00-0000-1-000091     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (392, 1, 2, 0, 0, 0, 0, 0, 2, 1, 92, N'2-01-02-0000-00-00-00-0000-1-000092     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (393, 1, 2, 0, 0, 0, 0, 0, 2, 1, 93, N'2-01-02-0000-00-00-00-0000-1-000093     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (394, 1, 2, 0, 0, 0, 0, 0, 2, 1, 94, N'2-01-02-0000-00-00-00-0000-1-000094     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (395, 1, 2, 0, 0, 0, 0, 0, 2, 1, 95, N'2-01-02-0000-00-00-00-0000-1-000095     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (396, 1, 2, 0, 0, 0, 0, 0, 2, 1, 96, N'2-01-02-0000-00-00-00-0000-1-000096     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (397, 1, 2, 0, 0, 0, 0, 0, 2, 1, 97, N'2-01-02-0000-00-00-00-0000-1-000097     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (398, 1, 2, 0, 0, 0, 0, 0, 2, 1, 98, N'2-01-02-0000-00-00-00-0000-1-000098     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (399, 1, 2, 0, 0, 0, 0, 0, 2, 1, 99, N'2-01-02-0000-00-00-00-0000-1-000099     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (400, 1, 2, 0, 0, 0, 0, 0, 2, 1, 100, N'2-01-02-0000-00-00-00-0000-1-000100     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (401, 1, 2, 0, 0, 0, 0, 0, 2, 1, 101, N'2-01-02-0000-00-00-00-0000-1-000101     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (402, 1, 2, 0, 0, 0, 0, 0, 2, 1, 102, N'2-01-02-0000-00-00-00-0000-1-000102     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (403, 1, 2, 0, 0, 0, 0, 0, 2, 1, 103, N'2-01-02-0000-00-00-00-0000-1-000103     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (404, 1, 2, 0, 0, 0, 0, 0, 2, 1, 104, N'2-01-02-0000-00-00-00-0000-1-000104     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (405, 1, 2, 0, 0, 0, 0, 0, 2, 1, 105, N'2-01-02-0000-00-00-00-0000-1-000105     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (406, 1, 2, 0, 0, 0, 0, 0, 2, 1, 106, N'2-01-02-0000-00-00-00-0000-1-000106     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (407, 1, 2, 0, 0, 0, 0, 0, 2, 1, 107, N'2-01-02-0000-00-00-00-0000-1-000107     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (408, 1, 2, 0, 0, 0, 0, 0, 2, 1, 108, N'2-01-02-0000-00-00-00-0000-1-000108     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (409, 1, 2, 0, 0, 0, 0, 0, 2, 1, 109, N'2-01-02-0000-00-00-00-0000-1-000109     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (410, 1, 2, 0, 0, 0, 0, 0, 2, 1, 110, N'2-01-02-0000-00-00-00-0000-1-000110     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (411, 1, 2, 0, 0, 0, 0, 0, 2, 1, 111, N'2-01-02-0000-00-00-00-0000-1-000111     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (412, 1, 2, 0, 0, 0, 0, 0, 2, 1, 112, N'2-01-02-0000-00-00-00-0000-1-000112     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (413, 1, 2, 0, 0, 0, 0, 0, 2, 1, 113, N'2-01-02-0000-00-00-00-0000-1-000113     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (414, 1, 2, 0, 0, 0, 0, 0, 2, 1, 114, N'2-01-02-0000-00-00-00-0000-1-000114     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (415, 1, 2, 0, 0, 0, 0, 0, 2, 1, 115, N'2-01-02-0000-00-00-00-0000-1-000115     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (416, 1, 2, 0, 0, 0, 0, 0, 2, 1, 116, N'2-01-02-0000-00-00-00-0000-1-000116     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (417, 1, 2, 0, 0, 0, 0, 0, 2, 1, 117, N'2-01-02-0000-00-00-00-0000-1-000117     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (418, 1, 2, 0, 0, 0, 0, 0, 2, 1, 118, N'2-01-02-0000-00-00-00-0000-1-000118     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (419, 1, 2, 0, 0, 0, 0, 0, 2, 1, 119, N'2-01-02-0000-00-00-00-0000-1-000119     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (420, 1, 2, 0, 0, 0, 0, 0, 2, 1, 120, N'2-01-02-0000-00-00-00-0000-1-000120     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (421, 1, 2, 0, 0, 0, 0, 0, 2, 1, 121, N'2-01-02-0000-00-00-00-0000-1-000121     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (422, 1, 2, 0, 0, 0, 0, 0, 2, 1, 122, N'2-01-02-0000-00-00-00-0000-1-000122     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_GL] OFF
GO
INSERT [dbo].[DEF_Sector] ([ID], [Name]) VALUES (1, N'Sector1')
GO
INSERT [dbo].[DEF_Unit] ([ID], [Name]) VALUES (1, N'Unit')
GO
INSERT [dbo].[DEF_Zone] ([ID], [Name]) VALUES (1, N'Zone1')
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'EGP', CAST(1.000000000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'AED', CAST(0.226411000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'ARS', CAST(3.571883000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'AUD', CAST(0.091184000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'BGN', CAST(0.109738000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'BRL', CAST(0.255191000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'BSD', CAST(0.061659000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CAD', CAST(0.081748000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CHF', CAST(0.061578000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CLP', CAST(44.000000000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CNY', CAST(0.436681000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'COP', CAST(210.951765000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CZK', CAST(1.446417000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'DKK', CAST(0.418450000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'DOP', CAST(3.239325000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'EUR', CAST(0.056022000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'FJD', CAST(0.135650000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'GBP', CAST(0.049170000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'GTQ', CAST(0.479163000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'HKD', CAST(0.484742000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'HRK', CAST(0.417213000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'HUF', CAST(18.565401000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'IDR', CAST(880.000000000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'ILS', CAST(0.216930000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'INR', CAST(4.400000000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'ISK', CAST(7.746479000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'JPY', CAST(6.697108000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'KRW', CAST(73.333333000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'KZT', CAST(24.022685000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'MXN', CAST(1.190476000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'MYR', CAST(0.258793000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'NOK', CAST(0.562804000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'NZD', CAST(0.098105000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PAB', CAST(0.061659000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PEN', CAST(0.207918000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PHP', CAST(3.186097000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PKR', CAST(9.640797000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PLN', CAST(0.241415000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PYG', CAST(396.646079000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'RON', CAST(0.266054000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'RUB', CAST(3.971119000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'SAR', CAST(0.231107000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'SEK', CAST(0.606562000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'SGD', CAST(0.084565000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'THB', CAST(1.879539000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'TRY', CAST(0.365479000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'TWD', CAST(1.892662000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'UAH', CAST(1.504274000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'USD', CAST(0.061794000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'UYU', CAST(2.294476000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'VND', CAST(1426.972909000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'ZAR', CAST(0.913432000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[LUT_ACCT_TYPE] ([ID], [Name], [Description]) VALUES (1, N'CK', N'Current Account')
GO
SET IDENTITY_INSERT [dbo].[LUT_AE_CATEGORY] ON 
GO
INSERT [dbo].[LUT_AE_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (1, N'Treasury', N'', 0)
GO
INSERT [dbo].[LUT_AE_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (2, N'Amortization', N'', 1)
GO
INSERT [dbo].[LUT_AE_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (3, N'Book Up Front', N'', 2)
GO
SET IDENTITY_INSERT [dbo].[LUT_AE_CATEGORY] OFF
GO
INSERT [dbo].[LUT_CIF_TYPE] ([Code], [Name]) VALUES (1, N'Personal')
GO
INSERT [dbo].[LUT_CIF_TYPE] ([Code], [Name]) VALUES (2, N'Non Personal')
GO
SET IDENTITY_INSERT [dbo].[LUT_GL_ACCT_CATEGORY] ON 
GO
INSERT [dbo].[LUT_GL_ACCT_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (1, N'Principle', N'', 0)
GO
INSERT [dbo].[LUT_GL_ACCT_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (2, N'Lib', N'', 0)
GO
SET IDENTITY_INSERT [dbo].[LUT_GL_ACCT_CATEGORY] OFF
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (1, N'Asset', N'DR')
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (2, N'Liability', N'CR')
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (3, N'Income', N'CR')
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (4, N'Expense', N'DR')
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (5, N'Capital', N'CR')
GO
INSERT [dbo].[LUT_LedgerPostingLevel] ([ID], [PostingLevel]) VALUES (1, N'OnBalance')
GO
INSERT [dbo].[LUT_LedgerPostingLevel] ([ID], [PostingLevel]) VALUES (2, N'OffBalance')
GO
SET IDENTITY_INSERT [dbo].[LUT_TRN_STATUS] ON 
GO
INSERT [dbo].[LUT_TRN_STATUS] ([STATUS_ID], [NAME]) VALUES (1, N'Completed')
GO
INSERT [dbo].[LUT_TRN_STATUS] ([STATUS_ID], [NAME]) VALUES (2, N'Reversed')
GO
SET IDENTITY_INSERT [dbo].[LUT_TRN_STATUS] OFF
GO
SET IDENTITY_INSERT [dbo].[Settings] ON 
GO
INSERT [dbo].[Settings] ([VerID], [EffectiveDate], [GLFormat], [GLFormatDigits], [BaseCurrency], [ACCTFormatDigits], [ACCTFormatDigitsNum], [ACCTFormat], [CIFFormatDigits]) VALUES (1, CAST(N'2019-07-30' AS Date), N'01-01-01-%GL                                                                                                                                                                                            ', N'00000                                                                                                                                                                                                   ', N'EGP       ', N'000000000                                                                                                                                                                                               ', N'4                                                                                                                                                                                                       ', NULL, N'000000000                                                                                           ')
GO
INSERT [dbo].[Settings] ([VerID], [EffectiveDate], [GLFormat], [GLFormatDigits], [BaseCurrency], [ACCTFormatDigits], [ACCTFormatDigitsNum], [ACCTFormat], [CIFFormatDigits]) VALUES (2, CAST(N'2019-07-30' AS Date), N'01-01-01-%GL                                                                                                                                                                                            ', N'00000                                                                                                                                                                                                   ', N'EGP       ', N'000000000                                                                                                                                                                                               ', N'4                                                                                                                                                                                                       ', NULL, N'000000000                                                                                           ')
GO
INSERT [dbo].[Settings] ([VerID], [EffectiveDate], [GLFormat], [GLFormatDigits], [BaseCurrency], [ACCTFormatDigits], [ACCTFormatDigitsNum], [ACCTFormat], [CIFFormatDigits]) VALUES (3, CAST(N'2019-07-30' AS Date), N'Nature-Zone-CompanyNo-BranchNo-SectorNo-DepNo-UnitNo-ProductNo-PostingLevel-LedgerNo                                                                                                                    ', N'#-##-##-####-##-##-##-####-#-######                                                                                                                                                                     ', N'EGP       ', N'000000000                                                                                                                                                                                               ', N'4                                                                                                                                                                                                       ', NULL, N'000000000                                                                                           ')
GO
SET IDENTITY_INSERT [dbo].[Settings] OFF
GO
SET IDENTITY_INSERT [dbo].[TRN_LEGS] ON 
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (1, N'173ffa8d-a1af-4289-b312-bb4fb9525063', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T12:49:37.153' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (2, N'173ffa8d-a1af-4289-b312-bb4fb9525063', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T12:49:37.153' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (3, N'173ffa8d-a1af-4289-b312-bb4fb9525063', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T12:49:37.153' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (4, N'173ffa8d-a1af-4289-b312-bb4fb9525063', 4, N'CR', N'000000000000001', 0, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T12:49:37.153' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (5, N'77135f40-ef72-4748-a001-ff014abda2fd', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:33:57.970' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (6, N'77135f40-ef72-4748-a001-ff014abda2fd', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:33:57.970' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (7, N'77135f40-ef72-4748-a001-ff014abda2fd', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:33:57.970' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (8, N'77135f40-ef72-4748-a001-ff014abda2fd', 4, N'CR', N'000000000000001', 0, CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:33:57.970' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (9, N'37729909-b545-4666-af93-1ad2105ec088', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:37:19.980' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (10, N'37729909-b545-4666-af93-1ad2105ec088', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(-300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:37:19.980' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (11, N'37729909-b545-4666-af93-1ad2105ec088', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:37:19.980' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (12, N'37729909-b545-4666-af93-1ad2105ec088', 4, N'CR', N'000000000000001', 0, CAST(300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:37:19.980' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (13, N'f9ea522c-e1b6-4715-b00f-1b52001fdf4c', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:39:42.390' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (14, N'f9ea522c-e1b6-4715-b00f-1b52001fdf4c', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(-450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:39:42.390' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (15, N'f9ea522c-e1b6-4715-b00f-1b52001fdf4c', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:39:42.390' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (16, N'f9ea522c-e1b6-4715-b00f-1b52001fdf4c', 4, N'CR', N'000000000000001', 0, CAST(450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:39:42.390' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (17, N'df8dfa05-c520-4997-904c-bf8f3a6bf082', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-25' AS Date), CAST(N'2020-09-25T15:48:41.903' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (18, N'df8dfa05-c520-4997-904c-bf8f3a6bf082', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(-600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-25' AS Date), CAST(N'2020-09-25T15:48:41.903' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (19, N'df8dfa05-c520-4997-904c-bf8f3a6bf082', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-25' AS Date), CAST(N'2020-09-25T15:48:41.903' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (20, N'df8dfa05-c520-4997-904c-bf8f3a6bf082', 4, N'CR', N'000000000000001', 0, CAST(600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-25' AS Date), CAST(N'2020-09-25T15:48:41.903' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (21, N'43f64a9b-e47e-4bc3-9bc7-815fd9e2c3a5', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:11:51.230' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (22, N'43f64a9b-e47e-4bc3-9bc7-815fd9e2c3a5', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:11:51.230' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (23, N'43f64a9b-e47e-4bc3-9bc7-815fd9e2c3a5', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:11:51.230' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (24, N'43f64a9b-e47e-4bc3-9bc7-815fd9e2c3a5', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:11:51.230' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (25, N'47163e0d-f513-4360-8377-cb7210b615fd', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:13:50.450' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (26, N'47163e0d-f513-4360-8377-cb7210b615fd', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:13:50.450' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (27, N'47163e0d-f513-4360-8377-cb7210b615fd', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:13:50.450' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (28, N'47163e0d-f513-4360-8377-cb7210b615fd', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:13:50.450' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (29, N'c23d7b62-b896-4e9d-9410-f6bde3cb3b38', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:28.167' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (30, N'c23d7b62-b896-4e9d-9410-f6bde3cb3b38', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:28.167' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (31, N'c23d7b62-b896-4e9d-9410-f6bde3cb3b38', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:28.167' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (32, N'c23d7b62-b896-4e9d-9410-f6bde3cb3b38', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:28.167' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (33, N'82b5eb92-458e-4ece-8ce3-bfd22312ff51', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:58.113' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (34, N'82b5eb92-458e-4ece-8ce3-bfd22312ff51', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:58.113' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (35, N'82b5eb92-458e-4ece-8ce3-bfd22312ff51', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:58.113' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (36, N'82b5eb92-458e-4ece-8ce3-bfd22312ff51', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:58.113' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (37, N'd9345aa5-3415-4878-8da8-d7060d6e01cd', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-12' AS Date), CAST(N'2020-11-12T10:37:25.710' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (38, N'd9345aa5-3415-4878-8da8-d7060d6e01cd', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-12' AS Date), CAST(N'2020-11-12T10:37:25.710' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (39, N'd9345aa5-3415-4878-8da8-d7060d6e01cd', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-12' AS Date), CAST(N'2020-11-12T10:37:25.710' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (40, N'd9345aa5-3415-4878-8da8-d7060d6e01cd', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-12' AS Date), CAST(N'2020-11-12T10:37:25.710' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (41, N'10173a26-27b9-4112-b4b6-8c79290c9e84', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(750000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(900000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:40:00.507' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (42, N'10173a26-27b9-4112-b4b6-8c79290c9e84', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-750000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-900000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:40:00.507' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (43, N'10173a26-27b9-4112-b4b6-8c79290c9e84', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-750000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-900000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:40:00.507' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (44, N'10173a26-27b9-4112-b4b6-8c79290c9e84', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(750000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(900000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:40:00.507' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (45, N'84cffc51-aedf-4a95-aedd-4d9de0ef0d12', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(900000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(1050000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:52:31.463' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (46, N'84cffc51-aedf-4a95-aedd-4d9de0ef0d12', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-900000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-1050000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:52:31.463' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (47, N'84cffc51-aedf-4a95-aedd-4d9de0ef0d12', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-900000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-1050000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:52:31.463' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (48, N'84cffc51-aedf-4a95-aedd-4d9de0ef0d12', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(900000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(1050000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:52:31.463' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
SET IDENTITY_INSERT [dbo].[TRN_LEGS] OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_LedgerNature]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ADD_LedgerPostingLevel]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AddCIF]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AddCIF_Class]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AddCIF_EXT1]    Script Date: 18/11/2020 14:46:31 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AddEditCurrency]    Script Date: 18/11/2020 14:46:31 ******/
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
