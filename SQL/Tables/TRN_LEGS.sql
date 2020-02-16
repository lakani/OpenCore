USE [OpenCore]
GO

/****** Object:  Table [dbo].[TRN_LEGS]    Script Date: 17/12/2019 13:23:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TRN_LEGS](
	[Ref] [uniqueidentifier] NULL,
	[Sequence] [smallint] NULL,
	[Acct_CR_DR] [nvarchar](2) NULL,
	[Acct_No] [nvarchar](max) NULL,
	[GL] [bit] NULL,
	[Balance_Before] [decimal](28, 3) NULL,
	[Acct_Amt] [decimal](28, 3) NULL,
	[Balance_After] [decimal](28, 3) NULL,
	[Acct_Curr] [nvarchar](3) NULL,
	[EffDt] [date] NULL,
	[CREATE_DT] [datetime] NULL,
	[EMP_ID] [smallint] NULL,
	[STATUS_ID] [tinyint] NULL,
	[CHANNEL_ID] [smallint] NULL,
	[Acct_Description] [nvarchar](max) NULL
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
CREATE TABLE dbo.Tmp_TRN_LEGS
	(
	TRN_LEGS_ID int NOT NULL IDENTITY (1, 1),
	Ref uniqueidentifier NULL,
	Sequence smallint NULL,
	Acct_CR_DR nvarchar(2) NULL,
	Acct_No nvarchar(MAX) NULL,
	GL bit NULL,
	Balance_Before decimal(28, 3) NULL,
	Acct_Amt decimal(28, 3) NULL,
	Balance_After decimal(28, 3) NULL,
	Acct_Curr nvarchar(3) NULL,
	EffDt date NULL,
	CREATE_DT datetime NULL,
	EMP_ID smallint NULL,
	STATUS_ID tinyint NULL,
	CHANNEL_ID smallint NULL,
	Acct_Description nvarchar(MAX) NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_TRN_LEGS SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_TRN_LEGS OFF
GO
IF EXISTS(SELECT * FROM dbo.TRN_LEGS)
	 EXEC('INSERT INTO dbo.Tmp_TRN_LEGS (Ref, Sequence, Acct_CR_DR, Acct_No, GL, Balance_Before, Acct_Amt, Balance_After, Acct_Curr, EffDt, CREATE_DT, EMP_ID, STATUS_ID, CHANNEL_ID, Acct_Description)
		SELECT Ref, Sequence, Acct_CR_DR, Acct_No, GL, Balance_Before, Acct_Amt, Balance_After, Acct_Curr, EffDt, CREATE_DT, EMP_ID, STATUS_ID, CHANNEL_ID, Acct_Description FROM dbo.TRN_LEGS WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.TRN_LEGS
GO
EXECUTE sp_rename N'dbo.Tmp_TRN_LEGS', N'TRN_LEGS', 'OBJECT' 
GO
ALTER TABLE dbo.TRN_LEGS ADD CONSTRAINT
	PK_TRN_LEGS PRIMARY KEY CLUSTERED 
	(
	TRN_LEGS_ID
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
ALTER TABLE dbo.TRN_LEGS ADD
	Related_Ref uniqueidentifier NULL
GO
ALTER TABLE dbo.TRN_LEGS SET (LOCK_ESCALATION = TABLE)
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
CREATE TABLE dbo.Tmp_TRN_LEGS
	(
	TRN_LEGS_ID int NOT NULL IDENTITY (1, 1),
	Ref uniqueidentifier NULL,
	Sequence smallint NULL,
	Acct_CR_DR nvarchar(2) NULL,
	Acct_No nvarchar(MAX) NULL,
	GL bit NULL,
	Balance_Before decimal(28, 3) NULL,
	Acct_Amt decimal(28, 3) NULL,
	Balance_After decimal(28, 3) NULL,
	Acct_Curr nvarchar(3) NULL,
	EffDt date NULL,
	CREATE_DT datetime NULL,
	EMP_ID smallint NULL,
	STATUS_ID tinyint NULL,
	CHANNEL_ID smallint NULL,
	Category smallint NULL,
	Acct_Description nvarchar(MAX) NULL,
	Related_Ref uniqueidentifier NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_TRN_LEGS SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_TRN_LEGS ON
GO
IF EXISTS(SELECT * FROM dbo.TRN_LEGS)
	 EXEC('INSERT INTO dbo.Tmp_TRN_LEGS (TRN_LEGS_ID, Ref, Sequence, Acct_CR_DR, Acct_No, GL, Balance_Before, Acct_Amt, Balance_After, Acct_Curr, EffDt, CREATE_DT, EMP_ID, STATUS_ID, CHANNEL_ID, Acct_Description, Related_Ref)
		SELECT TRN_LEGS_ID, Ref, Sequence, Acct_CR_DR, Acct_No, GL, Balance_Before, Acct_Amt, Balance_After, Acct_Curr, EffDt, CREATE_DT, EMP_ID, STATUS_ID, CHANNEL_ID, Acct_Description, Related_Ref FROM dbo.TRN_LEGS WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_TRN_LEGS OFF
GO
DROP TABLE dbo.TRN_LEGS
GO
EXECUTE sp_rename N'dbo.Tmp_TRN_LEGS', N'TRN_LEGS', 'OBJECT' 
GO
ALTER TABLE dbo.TRN_LEGS ADD CONSTRAINT
	PK_TRN_LEGS PRIMARY KEY CLUSTERED 
	(
	TRN_LEGS_ID
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
EXECUTE sp_rename N'dbo.TRN_LEGS.Acct_Amt', N'Tmp_Trn_Amt', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.TRN_LEGS.Tmp_Trn_Amt', N'Trn_Amt', 'COLUMN' 
GO
ALTER TABLE dbo.TRN_LEGS SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
