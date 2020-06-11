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


/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_DEF_CIF
	(
	Id int NOT NULL IDENTITY (1, 1),
	CIF_NO nvarchar(35) NOT NULL,
	SearchKey nvarchar(35) NOT NULL,
	FirstName nvarchar(80) NULL,
	MiddleName nvarchar(80) NULL,
	LastName nvarchar(80) NULL,
	FamilyName nvarchar(80) NULL,
	CREATE_DT datetime NULL,
	CIF_TYPE smallint NULL,
	CIF_CLASS nvarchar(10) NULL,
	RSM nvarchar(35) NULL,
	Gender nvarchar(10) NULL,
	Country int NULL,
	COUNTRY_OF_BIRTH int NULL,
	GOVERNORATE int NULL,
	City int NULL,
	Area int NULL,
	Address nvarchar(MAX) NULL,
	Nationality int NULL,
	BIRTH_DT date NULL,
	LAST_SAVE_DT datetime NULL,
	MobileNumber nvarchar(80) NULL,
	HomeNumber nvarchar(80) NULL,
	WorkNumber nvarchar(80) NULL,
	NationalID nvarchar(MAX) NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_DEF_CIF SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_CIF ON
GO
IF EXISTS(SELECT * FROM dbo.DEF_CIF)
	 EXEC('INSERT INTO dbo.Tmp_DEF_CIF (Id, CIF_NO, SearchKey, FirstName, MiddleName, LastName, FamilyName, CREATE_DT, CIF_TYPE, CIF_CLASS, Gender, Country, COUNTRY_OF_BIRTH, GOVERNORATE, City, Area, Address, Nationality, BIRTH_DT, LAST_SAVE_DT, MobileNumber, HomeNumber, WorkNumber, NationalID)
		SELECT Id, CONVERT(nvarchar(35), CIF_NO), CONVERT(nvarchar(35), SearchKey), FirstName, MiddleName, LastName, FamilyName, CREATE_DT, CIF_TYPE, CIF_CLASS, Gender, Country, COUNTRY_OF_BIRTH, GOVERNORATE, City, Area, Address, Nationality, BIRTH_DT, LAST_SAVE_DT, MobileNumber, HomeNumber, WorkNumber, NationalID FROM dbo.DEF_CIF WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_CIF OFF
GO
DROP TABLE dbo.DEF_CIF
GO
EXECUTE sp_rename N'dbo.Tmp_DEF_CIF', N'DEF_CIF', 'OBJECT' 
GO
ALTER TABLE dbo.DEF_CIF ADD CONSTRAINT
	PK__tmp_ms_x__3214EC073F31DDF2 PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
