USE [OpenCore]
GO

/****** Object:  Table [dbo].[LUT_ACCT_TYPE]    Script Date: 17/12/2019 13:21:40 ******/
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

