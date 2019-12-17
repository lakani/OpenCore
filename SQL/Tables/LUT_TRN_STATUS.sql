USE [OpenCore]
GO

/****** Object:  Table [dbo].[LUT_TRN_STATUS]    Script Date: 17/12/2019 13:23:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LUT_TRN_STATUS](
	[STATUS_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](80) NULL
) ON [PRIMARY]
GO

