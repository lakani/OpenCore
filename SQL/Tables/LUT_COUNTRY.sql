USE [OpenCore]
GO

/****** Object:  Table [dbo].[LUT_COUNTRY]    Script Date: 17/12/2019 13:22:25 ******/
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

