USE [OpenCore]
GO

/****** Object:  View [dbo].[VW_DEF_GL]    Script Date: 17/02/2020 17:49:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[VW_DEF_GL]
AS
SELECT        RIGHT('00' + CONVERT(VARCHAR, ISNULL(GL.Zone, 0)), 2) + '-' + RIGHT('00' + CONVERT(VARCHAR, GL.CompanyNo), 2) + '-' + RIGHT('00' + CONVERT(VARCHAR, ISNULL(GL.BranchNo, 0)), 2) 
                         + '-' + RIGHT('00' + CONVERT(VARCHAR, ISNULL(GL.SectorNo, 0)), 2) + '-' + RIGHT('00' + CONVERT(VARCHAR, ISNULL(GL.DepNo, 0)), 2) + '-' + RIGHT('00' + CONVERT(VARCHAR, ISNULL(GL.UnitNO, 0)), 2) 
                         + '-' + CAST(GL.LedgerNO AS nvarchar(MAX)) AS GL, ISNULL(GL.Zone, 0) AS Zone, ISNULL(dbo.DEF_Zone.Name, '') AS ZoneName, GL.CompanyNo, dbo.DEF_Company.Name AS CompanyName, ISNULL(GL.BranchNo, 0) 
                         AS BranchNo, ISNULL(dbo.DEF_Branch.Name, '') AS BranchName, ISNULL(GL.SectorNo, 0) AS SectorNo, ISNULL(dbo.DEF_Sector.Name, '') AS SectorName, ISNULL(GL.DepNo, 0) AS DepNo, ISNULL(dbo.DEF_Dep.Name, '') 
                         AS DepName, ISNULL(GL.UnitNO, 0) AS UnitNO, ISNULL(dbo.DEF_Unit.Name, '') AS UnitName, ISNULL(GL.Nature, 0) AS Nature, dbo.LUT_LedgerNature.Name AS NatureName, dbo.LUT_LedgerNature.CR_DR, GL.PostingLevel, 
                         GL.LedgerNO, GL.CURR, GL.EFFECTIVE_DT, ISNULL(GL.TotallingGL, '') AS TotallingGL, ISNULL(GL.REFERENCE, '') AS REFERENCE
FROM            dbo.DEF_GL AS GL LEFT OUTER JOIN
                         dbo.DEF_Zone ON dbo.DEF_Zone.ID = GL.Zone LEFT OUTER JOIN
                         dbo.DEF_Company ON dbo.DEF_Company.ID = GL.CompanyNo LEFT OUTER JOIN
                         dbo.DEF_Branch ON dbo.DEF_Branch.ID = GL.BranchNo LEFT OUTER JOIN
                         dbo.DEF_Sector ON dbo.DEF_Sector.ID = GL.SectorNo LEFT OUTER JOIN
                         dbo.DEF_Dep ON dbo.DEF_Dep.ID = GL.DepNo LEFT OUTER JOIN
                         dbo.DEF_Unit ON dbo.DEF_Unit.ID = GL.UnitNO LEFT OUTER JOIN
                         dbo.LUT_LedgerNature ON dbo.LUT_LedgerNature.ID = GL.Nature
GO

IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'VW_DEF_GL', NULL,NULL))
	EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "GL"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Zone"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Company"
            Begin Extent = 
               Top = 102
               Left = 246
               Bottom = 198
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Branch"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Sector"
            Begin Extent = 
               Top = 198
               Left = 246
               Bottom = 294
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Dep"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 348
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Unit"
            Begin Extent = 
               Top = 294
               Left = 246
               Bottom = 390
               Right = 416
            End
            DisplayFlags' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
ELSE
BEGIN
	EXEC sys.sp_updateextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "GL"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Zone"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Company"
            Begin Extent = 
               Top = 102
               Left = 246
               Bottom = 198
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Branch"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Sector"
            Begin Extent = 
               Top = 198
               Left = 246
               Bottom = 294
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Dep"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 348
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DEF_Unit"
            Begin Extent = 
               Top = 294
               Left = 246
               Bottom = 390
               Right = 416
            End
            DisplayFlags' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
END
GO

IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_DiagramPane2' , N'SCHEMA',N'dbo', N'VIEW',N'VW_DEF_GL', NULL,NULL))
	EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 280
            TopColumn = 0
         End
         Begin Table = "LUT_LedgerNature"
            Begin Extent = 
               Top = 348
               Left = 38
               Bottom = 461
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5070
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
ELSE
BEGIN
	EXEC sys.sp_updateextendedproperty @name=N'MS_DiagramPane2', @value=N' = 280
            TopColumn = 0
         End
         Begin Table = "LUT_LedgerNature"
            Begin Extent = 
               Top = 348
               Left = 38
               Bottom = 461
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5070
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
END
GO

IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'VW_DEF_GL', NULL,NULL))
	EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
ELSE
BEGIN
	EXEC sys.sp_updateextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_DEF_GL'
END
GO


