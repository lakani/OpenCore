USE [OpenCore]
GO

/****** Object:  Table [dbo].[GL_DEF]    Script Date: 21/12/2019 2:57:04 pm ******/
DROP TABLE [dbo].[GL_DEF]
GO

/****** Object:  Table [dbo].[GL_DEF]    Script Date: 21/12/2019 2:57:04 pm ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[GL_DEF](
	[GL_DEFID] [int] IDENTITY(1,1) NOT NULL,
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
	[REFERENCE] [nvarchar](max) NULL,
 CONSTRAINT [PK_GL_DEF] PRIMARY KEY CLUSTERED 
(
	[GL_DEFID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO




/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_DEF_GL
	(
	GL_DEFID int NOT NULL IDENTITY (1, 1),
	Zone tinyint NOT NULL,
	CompanyNo smallint NOT NULL,
	BranchNo smallint NOT NULL,
	SectorNo tinyint NOT NULL,
	DepNo tinyint NOT NULL,
	UnitNO tinyint NOT NULL,
	Nature tinyint NOT NULL,
	PostingLevel tinyint NOT NULL,
	LedgerNO nvarchar(15) NOT NULL,
	CURR nvarchar(4) NOT NULL,
	TotallingGL nvarchar(35) NULL,
	COMMENTS nvarchar(200) NULL,
	EFFECTIVE_DT datetime NOT NULL,
	STATUS tinyint NOT NULL,
	REFERENCE nvarchar(MAX) NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_DEF_GL SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_GL OFF
GO
IF EXISTS(SELECT * FROM dbo.DEF_GL)
	 EXEC('INSERT INTO dbo.Tmp_DEF_GL (Zone, CompanyNo, BranchNo, SectorNo, DepNo, UnitNO, Nature, PostingLevel, LedgerNO, CURR, TotallingGL, COMMENTS, EFFECTIVE_DT, STATUS, REFERENCE)
		SELECT Zone, CompanyNo, BranchNo, SectorNo, DepNo, UnitNO, Nature, PostingLevel, LedgerNO, CURR, TotallingGL, COMMENTS, EFFECTIVE_DT, STATUS, REFERENCE FROM dbo.DEF_GL WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.DEF_GL
GO
EXECUTE sp_rename N'dbo.Tmp_DEF_GL', N'DEF_GL', 'OBJECT' 
GO
COMMIT
