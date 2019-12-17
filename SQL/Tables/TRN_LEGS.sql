USE [OpenCore]
GO

/****** Object:  Table [dbo].[TRN_LEGS]    Script Date: 17/12/2019 13:23:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TRN_LEGS](
	[Ref] [uniqueidentifier] NULL,
	[Sequence] [smallint] NULL,
	[Acct_CR_DR] [nvarchar](2) NULL,
	[Acct_No] [nvarchar](max) NULL,
	[GL] [bit] NULL,
	[Balance_Before] [decimal](28, 3) NULL,
	[Acct_Amt] [decimal](28, 3) NULL,
	[Balance_After] [decimal](28, 3) NULL,
	[Acct_Curr] [nvarchar](3) NULL,
	[EffDt] [date] NULL,
	[CREATE_DT] [datetime] NULL,
	[EMP_ID] [smallint] NULL,
	[STATUS_ID] [tinyint] NULL,
	[CHANNEL_ID] [smallint] NULL,
	[Acct_Description] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

