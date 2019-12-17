USE [OpenCore]
GO

/****** Object:  Table [dbo].[LUT_LedgerNature]    Script Date: 17/12/2019 13:22:37 ******/
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

