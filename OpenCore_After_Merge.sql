USE [master]
GO
/****** Object:  Database [OpenCore]    Script Date: 11/15/2018 10:10:49 PM ******/
CREATE DATABASE [OpenCore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'nCash', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\nCash.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'nCash_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\nCash_log.ldf' , SIZE = 3840KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [OpenCore] SET COMPATIBILITY_LEVEL = 110
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
ALTER DATABASE [OpenCore] SET RECOVERY FULL 
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
/****** Object:  User [admin]    Script Date: 11/15/2018 10:10:49 PM ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetSettings]    Script Date: 11/15/2018 10:10:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Al Lakani, Ahmed>
-- Create date: <Create Date 11/10/2018>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetSettings]()
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT top 1 * from nCash.dbo.Settings Options order by Options.VerID desc
)

GO
/****** Object:  Table [dbo].[Branch_DEF]    Script Date: 11/15/2018 10:10:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch_DEF](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company_DEF]    Script Date: 11/15/2018 10:10:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company_DEF](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currency_DEF]    Script Date: 11/15/2018 10:10:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency_DEF](
	[CurrencyID] [smallint] IDENTITY(1,1) NOT NULL,
	[ISOCode] [nvarchar](3) NOT NULL,
	[Symbol] [nvarchar](3) NOT NULL,
	[Fractions] [smallint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dep_DEF]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dep_DEF](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GL_DEF]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GL_DEF](
	[Zone] [int] NOT NULL,
	[CompanyNo] [int] NOT NULL,
	[BranchNo] [int] NOT NULL,
	[SectorNo] [int] NOT NULL,
	[DepNo] [int] NOT NULL,
	[UnitNO] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[PostingLevel] [int] NOT NULL,
	[LedgerNO] [nvarchar](15) NOT NULL,
	[CURR] [nvarchar](4) NOT NULL,
	[COMMENTS] [nvarchar](200) NULL,
	[EFFECTIVE_DT] [datetime] NOT NULL,
	[STATUS] [smallint] NOT NULL,
	[REFERENCE] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GL_TYPE]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GL_TYPE](
	[ID] [smallint] NOT NULL,
	[CODE] [nvarchar](30) NOT NULL,
	[Type] [nchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUTLedgerNature]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUTLedgerNature](
	[ID] [smallint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Type] [nchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUTLedgerPostingLevel]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUTLedgerPostingLevel](
	[ID] [smallint] NOT NULL,
	[PostingLevel] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUTSTATUS]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUTSTATUS](
	[TRAN] [nvarchar](50) NOT NULL,
	[STATUSID] [smallint] NULL,
	[NAME] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sector_DEF]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sector_DEF](
	[ID] [smallint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[VerID] [int] IDENTITY(1,1) NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[GLFormat] [nchar](200) NOT NULL,
	[GLFormatDigits] [nchar](200) NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[VerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unit_DEF]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit_DEF](
	[ID] [smallint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zone_DEF]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zone_DEF](
	[ID] [smallint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddEditCurrency]    Script Date: 11/15/2018 10:10:50 PM ******/
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

	select @CurrencyID = CurrencyID from Currency_DEF where ISOCode = @ISOCode;

	-- Check if Record exists or not
	IF (@CurrencyID is null)
	BEGIN
		insert into Currency_DEF values (@ISOCode, @Symbol, @Fractions, @Name)
		select @CurrencyID = CurrencyID from Currency_DEF where ISOCode = @ISOCode;
		RETURN (@CurrencyID)
	END
	ELSE
	BEGIN
		update Currency_DEF 
		set ISOCode = @ISOCode, Symbol = @Symbol, Fractions = @Fractions, Currency_DEF.Name = @Name
		where Currency_DEF.CurrencyID = @CurrencyID

		RETURN (@CurrencyID)
	END

	RETURN (@CurrencyID)

END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddGL]    Script Date: 11/15/2018 10:10:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AddGL] 
	-- Add the parameters for the stored procedure here
	@Zone			int,
	@CompanyNo		int,
	@BranchNo		int,
	@SectorNo		int,
	@DepNo			int,
	@UNITNO			int,
	@TYPE			int,
	@POSTINGLEVEL	int,
	@LEDGERNO		nvarchar(15),
	@CURR			nvarchar(4),
	@COMMENTS		nvarchar(200),
	@EFFECTIVE_DT	datetime,
	@REFERENCE		nvarchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- check paramters

	IF not exists (select top 1 CurrencyISOCode from LUTCurrency where CurrencyISOCode = @CURR)
	return ;

	IF not exists (select top 1 CODE from GL_TYPE typ where [ID] = @TYPE)
	return ;

	IF not exists (select top 1 ID from Zone_DEF  where [ID] = @Zone)
	return ;

	IF not exists (select top 1 ID from Branch_DEF where [ID] = @BranchNo)
	return ;

	IF not exists (select top 1 ID from Sector_DEF where [ID] = @SectorNo)
	return ;

	IF not exists (select top 1 ID from Dep_DEF where [ID] = @DepNo)
	return ;

	IF not exists (select top 1 ID from LUTLedgerPostingLevel where [ID] = @POSTINGLEVEL)
	return ;

	
	
	-- Insert statements for procedure here

	INSERT INTO [dbo].[GL_DEF]
           ([Zone]
           ,[CompanyNo]
           ,[BranchNo]
           ,[SectorNo]
           ,[DepNo]
           ,[UNITNO]
           ,[TYPE]
           ,[POSTINGLEVEL]
           ,[LEDGERNO]
           ,[CURR]
           ,[COMMENTS]
           ,[EFFECTIVE_DT]
           ,[REFERENCE])

     values ( @Zone
           ,@CompanyNo
           ,@BranchNo
           ,@SectorNo
           ,@DepNo
           ,@UNITNO
           ,@TYPE
           ,@POSTINGLEVEL
           ,@LEDGERNO
           ,@CURR
           ,@COMMENTS
           ,@EFFECTIVE_DT
           ,@REFERENCE) 

		   select @LEDGERNO

END
GO
USE [master]
GO
ALTER DATABASE [OpenCore] SET  READ_WRITE 
GO
