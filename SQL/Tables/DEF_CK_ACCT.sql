USE [OpenCore]
GO

/****** Object:  Table [dbo].[DEF_CK_ACCT]    Script Date: 20/02/2020 15:38:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DEF_CK_ACCT](
	[DEF_ACCT_ID] [int] IDENTITY(1,1) NOT NULL,
	[CIF_NO] [nvarchar](35) NOT NULL,
	[ACCT_NO] [nvarchar](35) NOT NULL,
	[Title] [nvarchar](80) NULL,
	[Description] [nvarchar](80) NULL,
	[ReferenceACCT] [nvarchar](35) NULL,
	[ReferenceOrg] [nvarchar](35) NULL,
	[IBAN] [nvarchar](35) NULL,
	[ACCT_TYPE] [nvarchar](10) NOT NULL,
	[ACCT_CLASS] [nvarchar](10) NULL,
	[Currency] [nvarchar](3) NULL,
	[OpenDate] [date] NULL,
	[CSP_Code] [nvarchar](10) NULL,
	[CompanyNo] [nvarchar](10) NULL,
	[STATUS] [tinyint] NULL,
 CONSTRAINT [PK_DEF_ACCT] PRIMARY KEY CLUSTERED 
(
	[DEF_ACCT_ID] ASC
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
CREATE TABLE dbo.Tmp_DEF_CK_ACCT
	(
	DEF_ACCT_ID int NOT NULL IDENTITY (1, 1),
	CIF_NO nvarchar(35) NOT NULL,
	ACCT_NO nvarchar(35) NOT NULL,
	Title nvarchar(80) NULL,
	Description nvarchar(80) NULL,
	ReferenceACCT nvarchar(35) NULL,
	ReferenceOrg nvarchar(35) NULL,
	IBAN nvarchar(35) NULL,
	ACCT_TYPE nvarchar(10) NOT NULL,
	ACCT_CLASS nvarchar(10) NULL,
	Currency nvarchar(3) NULL,
	OpenDate date NULL,
	CSP_Code nvarchar(10) NULL,
	CompanyNo int NULL,
	STATUS tinyint NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_DEF_CK_ACCT SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_CK_ACCT ON
GO
IF EXISTS(SELECT * FROM dbo.DEF_CK_ACCT)
	 EXEC('INSERT INTO dbo.Tmp_DEF_CK_ACCT (DEF_ACCT_ID, CIF_NO, ACCT_NO, Title, Description, ReferenceACCT, ReferenceOrg, IBAN, ACCT_TYPE, ACCT_CLASS, Currency, OpenDate, CSP_Code, CompanyNo, STATUS)
		SELECT DEF_ACCT_ID, CIF_NO, ACCT_NO, Title, Description, ReferenceACCT, ReferenceOrg, IBAN, ACCT_TYPE, ACCT_CLASS, Currency, OpenDate, CSP_Code, CONVERT(smallint, CompanyNo), STATUS FROM dbo.DEF_CK_ACCT WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_CK_ACCT OFF
GO
DROP TABLE dbo.DEF_CK_ACCT
GO
EXECUTE sp_rename N'dbo.Tmp_DEF_CK_ACCT', N'DEF_CK_ACCT', 'OBJECT' 
GO
ALTER TABLE dbo.DEF_CK_ACCT ADD CONSTRAINT
	PK_DEF_ACCT PRIMARY KEY CLUSTERED 
	(
	DEF_ACCT_ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT

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
CREATE TABLE dbo.Tmp_DEF_CK_ACCT
	(
	DEF_ACCT_ID int NOT NULL IDENTITY (1, 1),
	CIF_NO nvarchar(35) NOT NULL,
	ACCT_NO nvarchar(35) NOT NULL,
	Title nvarchar(80) NULL,
	Description nvarchar(80) NULL,
	ReferenceACCT nvarchar(35) NULL,
	ReferenceOrg nvarchar(35) NULL,
	IBAN nvarchar(35) NULL,
	ACCT_TYPE nvarchar(10) NOT NULL,
	ACCT_CLASS nvarchar(10) NULL,
	Currency nvarchar(3) NULL,
	OpenDate date NULL,
	CSP_Code nvarchar(10) NULL,
	CompanyNo int NOT NULL,
	STATUS tinyint NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_DEF_CK_ACCT SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_CK_ACCT ON
GO
IF EXISTS(SELECT * FROM dbo.DEF_CK_ACCT)
	 EXEC('INSERT INTO dbo.Tmp_DEF_CK_ACCT (DEF_ACCT_ID, CIF_NO, ACCT_NO, Title, Description, ReferenceACCT, ReferenceOrg, IBAN, ACCT_TYPE, ACCT_CLASS, Currency, OpenDate, CSP_Code, CompanyNo, STATUS)
		SELECT DEF_ACCT_ID, CIF_NO, ACCT_NO, Title, Description, ReferenceACCT, ReferenceOrg, IBAN, ACCT_TYPE, ACCT_CLASS, Currency, OpenDate, CSP_Code, CompanyNo, STATUS FROM dbo.DEF_CK_ACCT WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_DEF_CK_ACCT OFF
GO
DROP TABLE dbo.DEF_CK_ACCT
GO
EXECUTE sp_rename N'dbo.Tmp_DEF_CK_ACCT', N'DEF_CK_ACCT', 'OBJECT' 
GO
ALTER TABLE dbo.DEF_CK_ACCT ADD CONSTRAINT
	PK_DEF_ACCT PRIMARY KEY CLUSTERED 
	(
	DEF_ACCT_ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
