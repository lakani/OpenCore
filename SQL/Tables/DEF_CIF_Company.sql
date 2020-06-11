USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_CIF_Company]    Script Date: 17/12/2019 13:18:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_CIF_Company](
	[DEF_CIF_Company_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](max) NULL,
	[Company_ID] [smallint] NULL,
 CONSTRAINT [PK_DEF_CIF_Company] PRIMARY KEY CLUSTERED 
(
	[DEF_CIF_Company_ID] ASC
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
CREATE TABLE dbo.Tmp_DEF_CIF_Company
	(
	DEF_CIF_Company_ID int NOT NULL IDENTITY (1, 1),
	CIF_NO nvarchar(35) NULL,
	Company_ID smallint NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_DEF_CIF_Company SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_CIF_Company ON
GO
IF EXISTS(SELECT * FROM dbo.DEF_CIF_Company)
	 EXEC('INSERT INTO dbo.Tmp_DEF_CIF_Company (DEF_CIF_Company_ID, CIF_NO, Company_ID)
		SELECT DEF_CIF_Company_ID, CONVERT(nvarchar(35), CIF_NO), Company_ID FROM dbo.DEF_CIF_Company WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_CIF_Company OFF
GO
DROP TABLE dbo.DEF_CIF_Company
GO
EXECUTE sp_rename N'dbo.Tmp_DEF_CIF_Company', N'DEF_CIF_Company', 'OBJECT' 
GO
ALTER TABLE dbo.DEF_CIF_Company ADD CONSTRAINT
	PK_DEF_CIF_Company PRIMARY KEY CLUSTERED 
	(
	DEF_CIF_Company_ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
