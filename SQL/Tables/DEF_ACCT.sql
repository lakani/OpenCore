USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_ACCT]    Script Date: 19/02/2020 14:54:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_ACCT](
	[DEF_ACCT_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) NOT NULL,
	[ACCT_NO] [nvarchar](35) NOT NULL,
	[Title] [nvarchar](80) NULL,
	[Description] [nvarchar](80) NULL,
	[ReferenceACCT] [nvarchar](35) NULL,
	[ReferenceOrg] [nvarchar](35) NULL,
	[IBAN] [nvarchar](35) NULL,
	[ACCT_TYPE] [nvarchar](10) NOT NULL,
	[ACCT_CLASS] [nvarchar](10) NULL,
	[Currency] [nvarchar](3) NULL,
	[OpenDate] [date] NULL,
	[CSP_Code] [nvarchar](10) NULL,
	[CompanyNo] [nvarchar](10) NULL,
 CONSTRAINT [PK_DEF_ACCT] PRIMARY KEY CLUSTERED 
(
	[DEF_ACCT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


