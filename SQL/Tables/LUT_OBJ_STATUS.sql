USE [OpenCore]
GO

/****** Object:  Table [dbo].[LUT_OBJ_STATUS]    Script Date: 17/12/2019 13:23:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LUT_OBJ_STATUS](
	[STATUS_ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](80) NULL
) ON [PRIMARY]
GO

