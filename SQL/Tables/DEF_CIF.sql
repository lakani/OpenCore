USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_CIF]    Script Date: 17/12/2019 13:17:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_CIF](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](max) NOT NULL,
	[SearchKey] [nvarchar](max) NOT NULL,
	[FirstName] [nvarchar](80) NULL,
	[MiddleName] [nvarchar](80) NULL,
	[LastName] [nvarchar](80) NULL,
	[FamilyName] [nvarchar](80) NULL,
	[CREATE_DT] [datetime] NULL,
	[CIF_TYPE] [smallint] NULL,
	[CIF_CLASS] [nvarchar](10) NULL,
	[Gender] [nvarchar](10) NULL,
	[Country] [int] NULL,
	[COUNTRY_OF_BIRTH] [int] NULL,
	[GOVERNORATE] [int] NULL,
	[City] [int] NULL,
	[Area] [int] NULL,
	[Address] [nvarchar](max) NULL,
	[Nationality] [int] NULL,
	[BIRTH_DT] [date] NULL,
	[LAST_SAVE_DT] [datetime] NULL,
	[MobileNumber] [nvarchar](80) NULL,
	[HomeNumber] [nvarchar](80) NULL,
	[WorkNumber] [nvarchar](80) NULL,
	[NationalID] [nvarchar](max) NULL,
 CONSTRAINT [PK__tmp_ms_x__3214EC073F31DDF2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

