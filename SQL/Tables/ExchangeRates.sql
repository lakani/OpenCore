USE [OpenCore]
GO

/****** Object:  Table [dbo].[ExchangeRates]    Script Date: 17/12/2019 13:21:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ExchangeRates](
	[FromCurIsoCode] [nchar](3) NOT NULL,
	[ToCurIsoCode] [nchar](3) NOT NULL,
	[Rate] [decimal](24, 9) NULL,
	[ExRateDate] [datetime] NULL,
	[TimeEXC] [datetime] NULL
) ON [PRIMARY]
GO

