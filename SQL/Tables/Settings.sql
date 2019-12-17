USE [OpenCore]
GO

/****** Object:  Table [dbo].[Settings]    Script Date: 17/12/2019 13:23:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Settings](
	[VerID] [int] IDENTITY(1,1) NOT NULL,
	[EffectiveDate] [date] NULL,
	[GLFormat] [nchar](200) NOT NULL,
	[GLFormatDigits] [nchar](200) NULL,
	[BaseCurrency] [nchar](10) NOT NULL,
	[ACCTFormatDigits] [nchar](200) NULL,
	[ACCTFormatDigitsNum] [nchar](200) NULL,
	[ACCTFormat] [nchar](200) NULL,
	[CIFFormatDigits] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[VerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

