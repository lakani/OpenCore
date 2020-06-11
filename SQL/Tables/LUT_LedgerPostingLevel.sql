USE [OpenCore]
GO

/****** Object:  Table [dbo].[LUT_LedgerPostingLevel]    Script Date: 17/12/2019 13:22:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LUT_LedgerPostingLevel](
	[ID] [tinyint] NOT NULL,
	[PostingLevel] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO

