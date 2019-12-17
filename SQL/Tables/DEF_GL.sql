USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_GL]    Script Date: 17/12/2019 13:20:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_GL](
	[Zone] [tinyint] NOT NULL,
	[CompanyNo] [smallint] NOT NULL,
	[BranchNo] [smallint] NOT NULL,
	[SectorNo] [tinyint] NOT NULL,
	[DepNo] [tinyint] NOT NULL,
	[UnitNO] [tinyint] NOT NULL,
	[Nature] [tinyint] NOT NULL,
	[PostingLevel] [tinyint] NOT NULL,
	[LedgerNO] [nvarchar](15) NOT NULL,
	[CURR] [nvarchar](4) NOT NULL,
	[TotallingGL] [nvarchar](35) NULL,
	[COMMENTS] [nvarchar](200) NULL,
	[EFFECTIVE_DT] [datetime] NOT NULL,
	[STATUS] [tinyint] NOT NULL,
	[REFERENCE] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

