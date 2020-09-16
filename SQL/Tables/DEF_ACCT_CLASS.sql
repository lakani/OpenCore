USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_ACCT_CLASS]    Script Date: 23/02/2020 11:55:57 ******/
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


