USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_Dep]    Script Date: 17/12/2019 13:20:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_Dep](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL
) ON [PRIMARY]
GO

