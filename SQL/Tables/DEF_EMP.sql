USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_EMP]    Script Date: 17/12/2019 13:20:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_EMP](
	[EMP_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](max) NULL,
	[FirstName] [nvarchar](80) NULL,
	[MiddleName] [nvarchar](80) NULL,
	[LastName] [nvarchar](80) NULL,
	[FamilyName] [nvarchar](80) NULL,
	[CREATE_DT] [datetime] NULL,
	[LAST_SAVE_DT] [datetime] NULL,
	[MobileNumber] [nvarchar](80) NULL,
	[HomeNumber] [nvarchar](80) NULL,
	[WorkNumber] [nvarchar](80) NULL,
	[STATUS_ID] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

