USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_BusinessDate]    Script Date: 17/12/2019 13:17:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_BusinessDate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BusinessDay] [date] NULL,
	[IsClosed] [bit] NULL,
	[IsEndOfWeek] [bit] NULL,
	[IsEndOfMonth] [bit] NULL,
	[IsEndOfQuarter] [bit] NULL,
	[IsEndOfYear] [bit] NULL
) ON [PRIMARY]
GO

