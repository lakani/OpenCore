USE [OpenCore]
GO

/****** Object:  UserDefinedTableType [dbo].[TYPE_POST_TRAN_PARAM]    Script Date: 17/12/2019 13:26:27 ******/
CREATE TYPE [dbo].[TYPE_POST_TRAN_PARAM] AS TABLE(
	[Row_NUM] [int] IDENTITY(1,1) NOT NULL,
	[Acct_CR_DR] [nvarchar](2) NULL,
	[Acct_No] [nvarchar](max) NULL,
	[GL] [bit] NULL,
	[Acct_Amt] [decimal](28, 3) NULL,
	[Acct_Curr] [nvarchar](3) NULL,
	[EffDt] [datetime] NULL,
	[Acct_Description] [nvarchar](max) NULL
)
GO

EXEC sys.sp_addextendedproperty @name=N'DESCRIPTION', @value=N'Account number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TYPE',@level1name=N'TYPE_POST_TRAN_PARAM', @level2type=N'COLUMN',@level2name=N'Acct_No'
GO

