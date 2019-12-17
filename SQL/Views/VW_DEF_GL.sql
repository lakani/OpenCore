USE [OpenCore]
GO

/****** Object:  View [dbo].[VW_DEF_GL]    Script Date: 17/12/2019 13:27:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VW_DEF_GL]
	AS 
	SELECT	RIGHT('00'+ CONVERT(VARCHAR,GL.Zone),2) + '-' + 
			RIGHT('00'+ CONVERT(VARCHAR,GL.CompanyNo),2) + '-' + 
			RIGHT('00'+ CONVERT(VARCHAR,GL.BranchNo),2) + '-' + 
			RIGHT('00'+ CONVERT(VARCHAR,GL.SectorNo),2) + '-' + 
			RIGHT('00'+ CONVERT(VARCHAR,GL.DepNo),2) + '-' + 
			RIGHT('00'+ CONVERT(VARCHAR,GL.UnitNO),2) + '-' +
			CAST(GL.LedgerNO as nvarchar(MAX))  'GL',
	
			GL.Zone, DEF_Zone.Name 'ZoneName', GL.CompanyNo, DEF_Company.Name 'CompanyName', 
			GL.BranchNo , DEF_Branch.Name 'BranchName', 
			GL.SectorNo, DEF_Sector.Name 'SectorName', GL.DepNo, DEF_Dep.Name 'DepName', 
			GL.UnitNO, DEF_Unit.Name 'UnitName',
			GL.Nature, LUT_LedgerNature.Name 'NatureName', LUT_LedgerNature.CR_DR ,
			GL.PostingLevel, GL.LedgerNO, GL.CURR, 
			CAST(GL.EFFECTIVE_DT AS date) 'EFFECTIVE_DT', GL.TotallingGL, GL.REFERENCE
	from	DEF_GL GL
			INNER JOIN DEF_Zone on DEF_Zone.ID = GL.Zone
			INNER JOIN DEF_Company on DEF_Company.ID = GL.CompanyNo
			INNER JOIN DEF_Branch on DEF_Branch.ID = GL.BranchNo
			INNER JOIN DEF_Sector on DEF_Sector.ID = GL.SectorNo
			INNER JOIN DEF_Dep on DEF_Dep.ID = GL.DepNo
			INNER JOIN DEF_Unit on DEF_Unit.ID = GL.UnitNO
			INNER JOIN LUT_LedgerNature on LUT_LedgerNature.ID = GL.Nature



GO

