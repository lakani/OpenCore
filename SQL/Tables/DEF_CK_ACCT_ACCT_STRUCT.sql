USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_CK_ACCT_ACCT_STRUCT]    Script Date: 20/02/2020 13:42:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_CK_ACCT_ACCT_STRUCT](
	[AccountStructID] [smallint] IDENTITY(1,1) NOT NULL,
	[AccountCode] [nvarchar](35) NOT NULL,
	[GLNum] [nvarchar](40) NOT NULL,
	[GLCategory] [smallint] NOT NULL,
	[GLComments] [nvarchar](80) NULL,
 CONSTRAINT [PK_DEF_ACCT_ACCT_STRUCT] PRIMARY KEY CLUSTERED 
(
	[AccountStructID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


