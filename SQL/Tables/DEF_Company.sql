USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_Company]    Script Date: 17/12/2019 13:18:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_Company](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO

