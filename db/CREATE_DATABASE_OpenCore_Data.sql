USE [OpenCore]
GO
SET IDENTITY_INSERT [dbo].[DEF_ACCT_CLASS] ON 
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (1, N'00001', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (2, N'00002', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
INSERT [dbo].[DEF_ACCT_CLASS] ([AccountClassID], [Code], [Name], [Type], [CompanyNo], [Currency], [EFFECTIVE_DT], [REFERENCE]) VALUES (3, N'00003', N'EGP CK Account Class', N'CK', 1, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'')
GO
SET IDENTITY_INSERT [dbo].[DEF_ACCT_CLASS] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ON 
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (2, N'00001', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (3, N'00001', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (4, N'00002', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (5, N'00002', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (6, N'00003', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (7, N'00003', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (8, N'00004', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (9, N'00004', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (10, N'00005', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (11, N'00005', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (12, N'00006', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (13, N'00006', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (14, N'00007', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (15, N'00007', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (16, N'00008', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (17, N'00008', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (18, N'00009', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (19, N'00009', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (20, N'00010', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (21, N'00010', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (22, N'00011', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (23, N'00011', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (24, N'00012', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (25, N'00012', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (26, N'00013', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (27, N'00013', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (28, N'00014', N'2-01-02-0000-00-00-00-0000-1-000043', 1, NULL)
GO
INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] ([AccountStructID], [AccountClassCode], [GLNum], [GLCategory], [GLComments]) VALUES (29, N'00014', N'2-01-02-0000-00-00-00-0000-1-000042', 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_ACCT_CLASS_ACCT_STRUCT] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_Branch] ON 
GO
INSERT [dbo].[DEF_Branch] ([ID], [Name], [CompanyNo]) VALUES (1, N'Br1', NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_Branch] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_BusinessDate] ON 
GO
INSERT [dbo].[DEF_BusinessDate] ([ID], [BusinessDay], [IsClosed], [IsEndOfWeek], [IsEndOfMonth], [IsEndOfQuarter], [IsEndOfYear]) VALUES (1, CAST(N'2019-07-30' AS Date), 0, 0, 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[DEF_BusinessDate] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_CIF] ON 
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (1, N'000000001', N'000000001', N'SOSO', N'', N'', NULL, CAST(N'2020-11-16T15:52:22.637' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (2, N'000000002', N'000000002', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.363' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (3, N'000000003', N'000000003', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.397' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (4, N'000000004', N'000000004', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.473' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (5, N'000000005', N'000000005', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.583' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (6, N'000000006', N'000000006', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.617' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (7, N'000000007', N'000000007', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.643' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (8, N'000000008', N'000000008', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.693' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (9, N'000000009', N'000000009', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.750' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
INSERT [dbo].[DEF_CIF] ([Id], [CIF_NO], [SearchKey], [FirstName], [MiddleName], [LastName], [FamilyName], [CREATE_DT], [CIF_TYPE], [CIF_CLASS], [RSM], [Gender], [Country], [COUNTRY_OF_BIRTH], [GOVERNORATE], [City], [Area], [Address], [Nationality], [BIRTH_DT], [LAST_SAVE_DT], [MobileNumber], [HomeNumber], [WorkNumber], [NationalID]) VALUES (10, N'000000010', N'000000010', N'Dalia Ahmed', N'', N'', NULL, CAST(N'2020-11-16T15:52:23.840' AS DateTime), 1, N'0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, N'123456789')
GO
SET IDENTITY_INSERT [dbo].[DEF_CIF] OFF
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0001', N'CIF Class 1', 1, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0001', N'CIF Class 1', 1, 2, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0002', N'CIF Class 1', 1, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0002', N'CIF Class 1', 1, 2, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0003', N'CIF Class 1', 1, 1, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[DEF_CIF_CLASS] ([Code], [Name], [Type], [CompanyNo], [EFFECTIVE_DT], [REFERENCE]) VALUES (N'0003', N'CIF Class 1', 1, 2, CAST(N'2019-07-30T00:00:00.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_CIF_Company] ON 
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (1, N'000000001', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (2, N'000000001', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (3, N'000000002', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (4, N'000000002', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (5, N'000000003', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (6, N'000000003', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (7, N'000000004', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (8, N'000000004', 2)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (9, N'000000005', 1)
GO
INSERT [dbo].[DEF_CIF_Company] ([DEF_CIF_Company_ID], [CIF_NO], [Company_ID]) VALUES (10, N'000000005', 2)
GO
SET IDENTITY_INSERT [dbo].[DEF_CIF_Company] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_CK_ACCT] ON 
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (2, N'000000001', N'000000000000001', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (3, N'000000001', N'000000000000002', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (4, N'000000001', N'000000000000003', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (5, N'000000001', N'000000000000004', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (6, N'000000001', N'000000000000005', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (7, N'000000001', N'000000000000006', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (8, N'000000001', N'000000000000007', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (9, N'000000001', N'000000000000008', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (10, N'000000001', N'000000000000009', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (11, N'000000001', N'000000000000010', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (12, N'000000001', N'000000000000011', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (13, N'000000001', N'000000000000012', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (14, N'000000001', N'000000000000013', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (15, N'000000001', N'000000000000014', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (16, N'000000001', N'000000000000015', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (17, N'000000001', N'000000000000016', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (18, N'000000001', N'000000000000017', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (19, N'000000001', N'000000000000018', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (20, N'000000001', N'000000000000019', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (21, N'000000001', N'000000000000020', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (22, N'000000001', N'000000000000021', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (23, N'000000001', N'000000000000022', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (24, N'000000001', N'000000000000023', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (25, N'000000001', N'000000000000024', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (26, N'000000001', N'000000000000025', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (27, N'000000001', N'000000000000026', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (28, N'000000001', N'000000000000027', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (29, N'000000001', N'000000000000028', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 2, 1)
GO
INSERT [dbo].[DEF_CK_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CSP_Code], [CompanyNo], [STATUS]) VALUES (30, N'000000001', N'000000000000029', NULL, NULL, NULL, NULL, NULL, N'CK', N'00001', N'EGP', CAST(N'2020-01-01' AS Date), NULL, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[DEF_CK_ACCT] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ON 
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (1, N'000000000000001', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (2, N'000000000000001', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (3, N'000000000000002', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (4, N'000000000000002', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (5, N'000000000000003', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (6, N'000000000000003', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (7, N'000000000000004', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (8, N'000000000000004', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (9, N'000000000000005', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (10, N'000000000000005', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (11, N'000000000000006', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (12, N'000000000000006', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (13, N'000000000000007', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (14, N'000000000000007', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (15, N'000000000000008', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (16, N'000000000000008', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (17, N'000000000000009', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (18, N'000000000000009', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (19, N'000000000000010', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (20, N'000000000000010', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (21, N'000000000000011', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (22, N'000000000000011', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (23, N'000000000000012', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (24, N'000000000000012', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (25, N'000000000000013', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (26, N'000000000000013', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (27, N'000000000000014', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (28, N'000000000000014', N'01-01-01-01-01-01-00001', 2, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (29, N'000000000000015', N'01-01-01-01-01-01-00001', 1, NULL)
GO
INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] ([AccountStructID], [AccountCode], [GLNum], [GLCategory], [GLComments]) VALUES (30, N'000000000000015', N'01-01-01-01-01-01-00001', 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_CK_ACCT_ACCT_STRUCT] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_Company] ON 
GO
INSERT [dbo].[DEF_Company] ([ID], [Name]) VALUES (1, N'Company1')
GO
INSERT [dbo].[DEF_Company] ([ID], [Name]) VALUES (2, N'Retail')
GO
SET IDENTITY_INSERT [dbo].[DEF_Company] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_Currency] ON 
GO
INSERT [dbo].[DEF_Currency] ([CurrencyID], [ISOCode], [Symbol], [Fractions], [Name]) VALUES (1, N'EGP', N'EGP', 2, N'Egyption Pounds')
GO
INSERT [dbo].[DEF_Currency] ([CurrencyID], [ISOCode], [Symbol], [Fractions], [Name]) VALUES (2, N'USD', N'USD', 2, N'Dollar')
GO
INSERT [dbo].[DEF_Currency] ([CurrencyID], [ISOCode], [Symbol], [Fractions], [Name]) VALUES (3, N'AUD', N'AUD', 2, N'Australian dollar')
GO
SET IDENTITY_INSERT [dbo].[DEF_Currency] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_Dep] ON 
GO
INSERT [dbo].[DEF_Dep] ([ID], [Name]) VALUES (1, N'Dep1')
GO
SET IDENTITY_INSERT [dbo].[DEF_Dep] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_FIXRATE_ACCT] ON 
GO
INSERT [dbo].[DEF_FIXRATE_ACCT] ([DEF_ACCT_ID], [CIF_NO], [ACCT_NO], [Title], [Description], [ReferenceACCT], [ReferenceOrg], [IBAN], [ACCT_TYPE], [ACCT_CLASS], [Currency], [OpenDate], [CreateDate], [CloseDate], [Principle], [Rate], [AccrualBasis], [CSP_Code], [CompanyNo], [STATUS_ID]) VALUES (1, N'000000001', N'000000000000001', NULL, NULL, NULL, NULL, NULL, N'FIXRATE', NULL, N'EGP', CAST(N'2020-11-01' AS Date), CAST(N'2020-11-01' AS Date), CAST(N'2020-11-25' AS Date), CAST(1000000.00 AS Decimal(28, 2)), CAST(5.50000000000000000000000000 AS Decimal(28, 26)), NULL, NULL, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[DEF_FIXRATE_ACCT] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_FIXRATE_ACCT_DATES] ON 
GO
INSERT [dbo].[DEF_FIXRATE_ACCT_DATES] ([DEF_FIXRATE_ACCT_DATES_ID], [DEF_ACCT_ID], [ACCT_NO], [ACCT_DATE]) VALUES (1, 1, N'000000000000001', CAST(N'2020-11-25' AS Date))
GO
SET IDENTITY_INSERT [dbo].[DEF_FIXRATE_ACCT_DATES] OFF
GO
SET IDENTITY_INSERT [dbo].[DEF_GL] ON 
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (301, 1, 2, 0, 0, 0, 0, 0, 2, 1, 1, N'2-01-02-0000-00-00-00-0000-1-000001     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (302, 1, 2, 0, 0, 0, 0, 0, 2, 1, 2, N'2-01-02-0000-00-00-00-0000-1-000002     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (303, 1, 2, 0, 0, 0, 0, 0, 2, 1, 3, N'2-01-02-0000-00-00-00-0000-1-000003     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (304, 1, 2, 0, 0, 0, 0, 0, 2, 1, 4, N'2-01-02-0000-00-00-00-0000-1-000004     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (305, 1, 2, 0, 0, 0, 0, 0, 2, 1, 5, N'2-01-02-0000-00-00-00-0000-1-000005     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (306, 1, 2, 0, 0, 0, 0, 0, 2, 1, 6, N'2-01-02-0000-00-00-00-0000-1-000006     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (307, 1, 2, 0, 0, 0, 0, 0, 2, 1, 7, N'2-01-02-0000-00-00-00-0000-1-000007     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (308, 1, 2, 0, 0, 0, 0, 0, 2, 1, 8, N'2-01-02-0000-00-00-00-0000-1-000008     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (309, 1, 2, 0, 0, 0, 0, 0, 2, 1, 9, N'2-01-02-0000-00-00-00-0000-1-000009     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (310, 1, 2, 0, 0, 0, 0, 0, 2, 1, 10, N'2-01-02-0000-00-00-00-0000-1-000010     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (311, 1, 2, 0, 0, 0, 0, 0, 2, 1, 11, N'2-01-02-0000-00-00-00-0000-1-000011     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (312, 1, 2, 0, 0, 0, 0, 0, 2, 1, 12, N'2-01-02-0000-00-00-00-0000-1-000012     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (313, 1, 2, 0, 0, 0, 0, 0, 2, 1, 13, N'2-01-02-0000-00-00-00-0000-1-000013     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (314, 1, 2, 0, 0, 0, 0, 0, 2, 1, 14, N'2-01-02-0000-00-00-00-0000-1-000014     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (315, 1, 2, 0, 0, 0, 0, 0, 2, 1, 15, N'2-01-02-0000-00-00-00-0000-1-000015     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (316, 1, 2, 0, 0, 0, 0, 0, 2, 1, 16, N'2-01-02-0000-00-00-00-0000-1-000016     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (317, 1, 2, 0, 0, 0, 0, 0, 2, 1, 17, N'2-01-02-0000-00-00-00-0000-1-000017     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (318, 1, 2, 0, 0, 0, 0, 0, 2, 1, 18, N'2-01-02-0000-00-00-00-0000-1-000018     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (319, 1, 2, 0, 0, 0, 0, 0, 2, 1, 19, N'2-01-02-0000-00-00-00-0000-1-000019     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (320, 1, 2, 0, 0, 0, 0, 0, 2, 1, 20, N'2-01-02-0000-00-00-00-0000-1-000020     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (321, 1, 2, 0, 0, 0, 0, 0, 2, 1, 21, N'2-01-02-0000-00-00-00-0000-1-000021     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (322, 1, 2, 0, 0, 0, 0, 0, 2, 1, 22, N'2-01-02-0000-00-00-00-0000-1-000022     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (323, 1, 2, 0, 0, 0, 0, 0, 2, 1, 23, N'2-01-02-0000-00-00-00-0000-1-000023     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (324, 1, 2, 0, 0, 0, 0, 0, 2, 1, 24, N'2-01-02-0000-00-00-00-0000-1-000024     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (325, 1, 2, 0, 0, 0, 0, 0, 2, 1, 25, N'2-01-02-0000-00-00-00-0000-1-000025     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (326, 1, 2, 0, 0, 0, 0, 0, 2, 1, 26, N'2-01-02-0000-00-00-00-0000-1-000026     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (327, 1, 2, 0, 0, 0, 0, 0, 2, 1, 27, N'2-01-02-0000-00-00-00-0000-1-000027     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (328, 1, 2, 0, 0, 0, 0, 0, 2, 1, 28, N'2-01-02-0000-00-00-00-0000-1-000028     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (329, 1, 2, 0, 0, 0, 0, 0, 2, 1, 29, N'2-01-02-0000-00-00-00-0000-1-000029     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
INSERT [dbo].[DEF_GL] ([GL_DEFID], [Zone], [CompanyNo], [BranchNo], [SectorNo], [DepNo], [UnitNO], [ProductNo], [Nature], [PostingLevel], [LedgerNO], [GL], [CURR], [COMMENTS], [EFFECTIVE_DT], [STATUS], [REFERENCE]) VALUES (330, 1, 2, 0, 0, 0, 0, 0, 2, 1, 30, N'2-01-02-0000-00-00-00-0000-1-000030     ', N'EGP', N'', CAST(N'2020-01-01T00:00:00.000' AS DateTime), 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[DEF_GL] OFF
GO
INSERT [dbo].[DEF_Sector] ([ID], [Name]) VALUES (1, N'Sector1')
GO
INSERT [dbo].[DEF_Unit] ([ID], [Name]) VALUES (1, N'Unit')
GO
INSERT [dbo].[DEF_Zone] ([ID], [Name]) VALUES (1, N'Zone1')
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'EGP', CAST(1.000000000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'AED', CAST(0.226411000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'ARS', CAST(3.571883000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'AUD', CAST(0.091184000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'BGN', CAST(0.109738000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'BRL', CAST(0.255191000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'BSD', CAST(0.061659000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CAD', CAST(0.081748000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CHF', CAST(0.061578000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CLP', CAST(44.000000000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CNY', CAST(0.436681000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'COP', CAST(210.951765000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'CZK', CAST(1.446417000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'DKK', CAST(0.418450000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'DOP', CAST(3.239325000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'EUR', CAST(0.056022000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'FJD', CAST(0.135650000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'GBP', CAST(0.049170000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'GTQ', CAST(0.479163000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'HKD', CAST(0.484742000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'HRK', CAST(0.417213000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'HUF', CAST(18.565401000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'IDR', CAST(880.000000000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'ILS', CAST(0.216930000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'INR', CAST(4.400000000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'ISK', CAST(7.746479000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'JPY', CAST(6.697108000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'KRW', CAST(73.333333000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'KZT', CAST(24.022685000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'MXN', CAST(1.190476000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'MYR', CAST(0.258793000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'NOK', CAST(0.562804000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'NZD', CAST(0.098105000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PAB', CAST(0.061659000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PEN', CAST(0.207918000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PHP', CAST(3.186097000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PKR', CAST(9.640797000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PLN', CAST(0.241415000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'PYG', CAST(396.646079000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'RON', CAST(0.266054000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'RUB', CAST(3.971119000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'SAR', CAST(0.231107000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'SEK', CAST(0.606562000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'SGD', CAST(0.084565000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'THB', CAST(1.879539000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'TRY', CAST(0.365479000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'TWD', CAST(1.892662000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'UAH', CAST(1.504274000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'USD', CAST(0.061794000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'UYU', CAST(2.294476000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'VND', CAST(1426.972909000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[ExchangeRates] ([FromCurIsoCode], [ToCurIsoCode], [Rate], [ExRateDate], [TimeEXC]) VALUES (N'EGP', N'ZAR', CAST(0.913432000 AS Decimal(24, 9)), CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2019-10-16T11:10:50.000' AS DateTime))
GO
INSERT [dbo].[LUT_ACCT_TYPE] ([ID], [Name], [Description]) VALUES (1, N'CK', N'Current Account')
GO
SET IDENTITY_INSERT [dbo].[LUT_AE_CATEGORY] ON 
GO
INSERT [dbo].[LUT_AE_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (1, N'Treasury', N'', 0)
GO
INSERT [dbo].[LUT_AE_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (2, N'Amortization', N'', 1)
GO
INSERT [dbo].[LUT_AE_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (3, N'Book Up Front', N'', 2)
GO
SET IDENTITY_INSERT [dbo].[LUT_AE_CATEGORY] OFF
GO
INSERT [dbo].[LUT_CIF_TYPE] ([Code], [Name]) VALUES (1, N'Personal')
GO
INSERT [dbo].[LUT_CIF_TYPE] ([Code], [Name]) VALUES (2, N'Non Personal')
GO
SET IDENTITY_INSERT [dbo].[LUT_GL_ACCT_CATEGORY] ON 
GO
INSERT [dbo].[LUT_GL_ACCT_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (1, N'Principle', N'', 0)
GO
INSERT [dbo].[LUT_GL_ACCT_CATEGORY] ([ID], [Name], [Description], [ParentCat]) VALUES (2, N'Lib', N'', 0)
GO
SET IDENTITY_INSERT [dbo].[LUT_GL_ACCT_CATEGORY] OFF
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (1, N'Asset', N'DR')
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (2, N'Liability', N'CR')
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (3, N'Income', N'CR')
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (4, N'Expense', N'DR')
GO
INSERT [dbo].[LUT_LedgerNature] ([ID], [Name], [CR_DR]) VALUES (5, N'Capital', N'CR')
GO
INSERT [dbo].[LUT_LedgerPostingLevel] ([ID], [PostingLevel]) VALUES (1, N'OnBalance')
GO
INSERT [dbo].[LUT_LedgerPostingLevel] ([ID], [PostingLevel]) VALUES (2, N'OffBalance')
GO
SET IDENTITY_INSERT [dbo].[LUT_TRN_STATUS] ON 
GO
INSERT [dbo].[LUT_TRN_STATUS] ([STATUS_ID], [NAME]) VALUES (1, N'Completed')
GO
INSERT [dbo].[LUT_TRN_STATUS] ([STATUS_ID], [NAME]) VALUES (2, N'Reversed')
GO
SET IDENTITY_INSERT [dbo].[LUT_TRN_STATUS] OFF
GO
SET IDENTITY_INSERT [dbo].[PROC_FIXRATE_INTEREST] ON 
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (1, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-11-02T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (2, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-02T00:00:00.000' AS DateTime), CAST(N'2020-11-03T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (3, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-03T00:00:00.000' AS DateTime), CAST(N'2020-11-04T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (4, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-04T00:00:00.000' AS DateTime), CAST(N'2020-11-05T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (5, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-05T00:00:00.000' AS DateTime), CAST(N'2020-11-06T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (6, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-06T00:00:00.000' AS DateTime), CAST(N'2020-11-07T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (7, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-08T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (8, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-08T00:00:00.000' AS DateTime), CAST(N'2020-11-09T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (9, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-09T00:00:00.000' AS DateTime), CAST(N'2020-11-10T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (10, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-10T00:00:00.000' AS DateTime), CAST(N'2020-11-11T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (11, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(N'2020-11-12T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (12, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(N'2020-11-13T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (13, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(N'2020-11-14T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (14, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-14T00:00:00.000' AS DateTime), CAST(N'2020-11-15T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (15, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-15T00:00:00.000' AS DateTime), CAST(N'2020-11-16T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (16, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-16T00:00:00.000' AS DateTime), CAST(N'2020-11-17T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (17, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-17T00:00:00.000' AS DateTime), CAST(N'2020-11-18T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (18, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-18T00:00:00.000' AS DateTime), CAST(N'2020-11-19T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (19, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-19T00:00:00.000' AS DateTime), CAST(N'2020-11-20T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (20, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-20T00:00:00.000' AS DateTime), CAST(N'2020-11-21T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (21, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-21T00:00:00.000' AS DateTime), CAST(N'2020-11-22T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (22, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-22T00:00:00.000' AS DateTime), CAST(N'2020-11-23T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (23, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-23T00:00:00.000' AS DateTime), CAST(N'2020-11-24T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PROC_FIXRATE_INTEREST] ([PROC_FIXRATE_INTEREST_ID], [CIF_NO], [ACCT_NO], [PRINCIPLE_AMT], [CALC_INTEREST_AMT], [FROM_DATE], [TO_DATE], [STATUS_ID]) VALUES (24, N'000000001', N'000000000000001', CAST(1000000.00 AS Decimal(32, 2)), CAST(15277.78 AS Decimal(32, 2)), CAST(N'2020-11-24T00:00:00.000' AS DateTime), CAST(N'2020-11-25T00:00:00.000' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[PROC_FIXRATE_INTEREST] OFF
GO
SET IDENTITY_INSERT [dbo].[Settings] ON 
GO
INSERT [dbo].[Settings] ([VerID], [EffectiveDate], [GLFormat], [GLFormatDigits], [BaseCurrency], [ACCTFormatDigits], [ACCTFormatDigitsNum], [ACCTFormat], [CIFFormatDigits]) VALUES (1, CAST(N'2019-07-30' AS Date), N'01-01-01-%GL                                                                                                                                                                                            ', N'00000                                                                                                                                                                                                   ', N'EGP       ', N'000000000                                                                                                                                                                                               ', N'4                                                                                                                                                                                                       ', NULL, N'000000000                                                                                           ')
GO
INSERT [dbo].[Settings] ([VerID], [EffectiveDate], [GLFormat], [GLFormatDigits], [BaseCurrency], [ACCTFormatDigits], [ACCTFormatDigitsNum], [ACCTFormat], [CIFFormatDigits]) VALUES (2, CAST(N'2019-07-30' AS Date), N'01-01-01-%GL                                                                                                                                                                                            ', N'00000                                                                                                                                                                                                   ', N'EGP       ', N'000000000                                                                                                                                                                                               ', N'4                                                                                                                                                                                                       ', NULL, N'000000000                                                                                           ')
GO
INSERT [dbo].[Settings] ([VerID], [EffectiveDate], [GLFormat], [GLFormatDigits], [BaseCurrency], [ACCTFormatDigits], [ACCTFormatDigitsNum], [ACCTFormat], [CIFFormatDigits]) VALUES (3, CAST(N'2019-07-30' AS Date), N'Nature-Zone-CompanyNo-BranchNo-SectorNo-DepNo-UnitNo-ProductNo-PostingLevel-LedgerNo                                                                                                                    ', N'#-##-##-####-##-##-##-####-#-######                                                                                                                                                                     ', N'EGP       ', N'000000000                                                                                                                                                                                               ', N'4                                                                                                                                                                                                       ', NULL, N'000000000                                                                                           ')
GO
SET IDENTITY_INSERT [dbo].[Settings] OFF
GO
SET IDENTITY_INSERT [dbo].[TRN_LEGS] ON 
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (1, N'173ffa8d-a1af-4289-b312-bb4fb9525063', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T12:49:37.153' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (2, N'173ffa8d-a1af-4289-b312-bb4fb9525063', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T12:49:37.153' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (3, N'173ffa8d-a1af-4289-b312-bb4fb9525063', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T12:49:37.153' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (4, N'173ffa8d-a1af-4289-b312-bb4fb9525063', 4, N'CR', N'000000000000001', 0, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T12:49:37.153' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (5, N'77135f40-ef72-4748-a001-ff014abda2fd', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:33:57.970' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (6, N'77135f40-ef72-4748-a001-ff014abda2fd', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:33:57.970' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (7, N'77135f40-ef72-4748-a001-ff014abda2fd', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:33:57.970' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (8, N'77135f40-ef72-4748-a001-ff014abda2fd', 4, N'CR', N'000000000000001', 0, CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:33:57.970' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (9, N'37729909-b545-4666-af93-1ad2105ec088', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:37:19.980' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (10, N'37729909-b545-4666-af93-1ad2105ec088', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(-300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:37:19.980' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (11, N'37729909-b545-4666-af93-1ad2105ec088', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:37:19.980' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (12, N'37729909-b545-4666-af93-1ad2105ec088', 4, N'CR', N'000000000000001', 0, CAST(300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:37:19.980' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (13, N'f9ea522c-e1b6-4715-b00f-1b52001fdf4c', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:39:42.390' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (14, N'f9ea522c-e1b6-4715-b00f-1b52001fdf4c', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(-450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:39:42.390' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (15, N'f9ea522c-e1b6-4715-b00f-1b52001fdf4c', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:39:42.390' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (16, N'f9ea522c-e1b6-4715-b00f-1b52001fdf4c', 4, N'CR', N'000000000000001', 0, CAST(450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-24' AS Date), CAST(N'2020-09-24T22:39:42.390' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (17, N'df8dfa05-c520-4997-904c-bf8f3a6bf082', 1, N'CR', N'01-01-01-01-01-01-00010', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-25' AS Date), CAST(N'2020-09-25T15:48:41.903' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (18, N'df8dfa05-c520-4997-904c-bf8f3a6bf082', 2, N'DR', N'01-01-01-01-01-01-00002', 1, CAST(-600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-25' AS Date), CAST(N'2020-09-25T15:48:41.903' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (19, N'df8dfa05-c520-4997-904c-bf8f3a6bf082', 3, N'DR', N'01-01-01-01-01-01-00010', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(0.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-25' AS Date), CAST(N'2020-09-25T15:48:41.903' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (20, N'df8dfa05-c520-4997-904c-bf8f3a6bf082', 4, N'CR', N'000000000000001', 0, CAST(600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-09-25' AS Date), CAST(N'2020-09-25T15:48:41.903' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (21, N'43f64a9b-e47e-4bc3-9bc7-815fd9e2c3a5', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:11:51.230' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (22, N'43f64a9b-e47e-4bc3-9bc7-815fd9e2c3a5', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:11:51.230' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (23, N'43f64a9b-e47e-4bc3-9bc7-815fd9e2c3a5', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:11:51.230' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (24, N'43f64a9b-e47e-4bc3-9bc7-815fd9e2c3a5', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(0.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:11:51.230' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (25, N'47163e0d-f513-4360-8377-cb7210b615fd', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:13:50.450' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (26, N'47163e0d-f513-4360-8377-cb7210b615fd', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:13:50.450' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (27, N'47163e0d-f513-4360-8377-cb7210b615fd', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:13:50.450' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (28, N'47163e0d-f513-4360-8377-cb7210b615fd', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(150000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(300000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:13:50.450' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (29, N'c23d7b62-b896-4e9d-9410-f6bde3cb3b38', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:28.167' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (30, N'c23d7b62-b896-4e9d-9410-f6bde3cb3b38', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:28.167' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (31, N'c23d7b62-b896-4e9d-9410-f6bde3cb3b38', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:28.167' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (32, N'c23d7b62-b896-4e9d-9410-f6bde3cb3b38', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(300000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(450000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:28.167' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (33, N'82b5eb92-458e-4ece-8ce3-bfd22312ff51', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:58.113' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (34, N'82b5eb92-458e-4ece-8ce3-bfd22312ff51', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:58.113' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (35, N'82b5eb92-458e-4ece-8ce3-bfd22312ff51', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:58.113' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (36, N'82b5eb92-458e-4ece-8ce3-bfd22312ff51', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(450000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(600000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07T13:18:58.113' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (37, N'd9345aa5-3415-4878-8da8-d7060d6e01cd', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-12' AS Date), CAST(N'2020-11-12T10:37:25.710' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (38, N'd9345aa5-3415-4878-8da8-d7060d6e01cd', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-12' AS Date), CAST(N'2020-11-12T10:37:25.710' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (39, N'd9345aa5-3415-4878-8da8-d7060d6e01cd', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-12' AS Date), CAST(N'2020-11-12T10:37:25.710' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (40, N'd9345aa5-3415-4878-8da8-d7060d6e01cd', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(600000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(750000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-12' AS Date), CAST(N'2020-11-12T10:37:25.710' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (41, N'10173a26-27b9-4112-b4b6-8c79290c9e84', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(750000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(900000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:40:00.507' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (42, N'10173a26-27b9-4112-b4b6-8c79290c9e84', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-750000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-900000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:40:00.507' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (43, N'10173a26-27b9-4112-b4b6-8c79290c9e84', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-750000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-900000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:40:00.507' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (44, N'10173a26-27b9-4112-b4b6-8c79290c9e84', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(750000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(900000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:40:00.507' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (45, N'84cffc51-aedf-4a95-aedd-4d9de0ef0d12', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(900000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(1050000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:52:31.463' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (46, N'84cffc51-aedf-4a95-aedd-4d9de0ef0d12', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-900000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-1050000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:52:31.463' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (47, N'84cffc51-aedf-4a95-aedd-4d9de0ef0d12', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-900000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-1050000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:52:31.463' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (48, N'84cffc51-aedf-4a95-aedd-4d9de0ef0d12', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(900000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(1050000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-16' AS Date), CAST(N'2020-11-16T15:52:31.463' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (49, N'6c42c6a2-ce7d-47eb-a179-9ea0d25ea49b', 1, N'CR', N'2-01-02-0000-00-00-00-0000-1-000050', 1, CAST(1050000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(1200000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-19' AS Date), CAST(N'2020-11-19T15:54:39.287' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (50, N'6c42c6a2-ce7d-47eb-a179-9ea0d25ea49b', 2, N'DR', N'2-01-02-0000-00-00-00-0000-1-000049', 1, CAST(-1050000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-1200000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-19' AS Date), CAST(N'2020-11-19T15:54:39.287' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (51, N'6c42c6a2-ce7d-47eb-a179-9ea0d25ea49b', 3, N'DR', N'2-01-02-0000-00-00-00-0000-1-000048', 1, CAST(-1050000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(-1200000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-19' AS Date), CAST(N'2020-11-19T15:54:39.287' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[TRN_LEGS] ([TRN_LEGS_ID], [Ref], [Sequence], [Acct_CR_DR], [Acct_No], [GL], [Balance_Before], [Trn_Amt], [Balance_After], [Acct_Curr], [EffDt], [CREATE_DT], [EMP_ID], [STATUS_ID], [CHANNEL_ID], [Category], [Acct_Description], [Related_Ref]) VALUES (52, N'6c42c6a2-ce7d-47eb-a179-9ea0d25ea49b', 4, N'CR', N'2-01-02-0000-00-00-00-0000-1-000047', 1, CAST(1050000.000 AS Decimal(28, 3)), CAST(150000.000 AS Decimal(28, 3)), CAST(1200000.000 AS Decimal(28, 3)), N'EGP', CAST(N'2020-11-19' AS Date), CAST(N'2020-11-19T15:54:39.287' AS DateTime), 1, 1, 1, 3, N'Cash Deposit', N'00000000-0000-0000-0000-000000000000')
GO
SET IDENTITY_INSERT [dbo].[TRN_LEGS] OFF
GO
