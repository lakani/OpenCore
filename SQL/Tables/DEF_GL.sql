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

