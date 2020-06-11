USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_Branch]    Script Date: 17/12/2019 13:16:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_Branch](
	[ID] [smallint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_DEF_Branch] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
CREATE TABLE dbo.Tmp_DEF_Branch
	(
	ID int NOT NULL IDENTITY (1, 1),
	Name nvarchar(30) NOT NULL,
	CompanyNo int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_DEF_Branch SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_Branch ON
GO
IF EXISTS(SELECT * FROM dbo.DEF_Branch)
	 EXEC('INSERT INTO dbo.Tmp_DEF_Branch (ID, Name, CompanyNo)
		SELECT CONVERT(int, ID), Name, CompanyNo FROM dbo.DEF_Branch WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_Branch OFF
GO
DROP TABLE dbo.DEF_Branch
GO
EXECUTE sp_rename N'dbo.Tmp_DEF_Branch', N'DEF_Branch', 'OBJECT' 
GO
ALTER TABLE dbo.DEF_Branch ADD CONSTRAINT
	PK_DEF_Branch PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
