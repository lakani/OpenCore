USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_Currency]    Script Date: 17/12/2019 13:18:30 ******/
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

