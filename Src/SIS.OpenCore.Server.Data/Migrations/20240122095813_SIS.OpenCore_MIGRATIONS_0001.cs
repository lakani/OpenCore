﻿using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace SIS.OpenCore.Server.Data.Migrations
{
    /// <inheritdoc />
    public partial class SISOpenCore_MIGRATIONS_0001 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AccountingPosting",
                columns: table => new
                {
                    PostingId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PostingLinkedId = table.Column<int>(type: "int", nullable: false),
                    TradeId = table.Column<int>(type: "int", nullable: false),
                    ProductId = table.Column<int>(type: "int", nullable: false),
                    SentDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    EffectiveDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    PostingType = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Amount = table.Column<float>(type: "real", nullable: false),
                    EventType = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    PostingDescription = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    ProductDescription = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    PostingCurrency = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: true),
                    ExternalDebitAccount = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    DebitAccount = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    ExternalCreditAccount = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    CreditAccount = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    OriginalEvent = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    AccountingRule = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    TradeStatus = table.Column<short>(type: "smallint", nullable: false),
                    BookName = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    AccountingBookName = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    BookingDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    CreationDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    Manual = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    EnteredUser = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    PostingOtherAmount = table.Column<float>(type: "real", nullable: false),
                    PostingStatus = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AccountingPosting", x => x.PostingId);
                });

            migrationBuilder.CreateTable(
                name: "ACCTDataSource",
                columns: table => new
                {
                    ACCTDataSource_ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    REFERENCE = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    CONNECTIONTYPE = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    CONNECTIONSTRING = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    SERVER = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    DATABASE = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    USERNAME = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    PASSWORD = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    QUERY = table.Column<string>(type: "nvarchar(360)", maxLength: 360, nullable: true),
                    PREVIEWQUERY = table.Column<string>(type: "nvarchar(360)", maxLength: 360, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ACCTDataSource", x => x.ACCTDataSource_ID);
                });

            migrationBuilder.CreateTable(
                name: "AspNetRoles",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUsers",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    CreatedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastLoginDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CivilNumber = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UserName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedUserName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedEmail = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    EmailConfirmed = table.Column<bool>(type: "bit", nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    SecurityStamp = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PhoneNumberConfirmed = table.Column<bool>(type: "bit", nullable: false),
                    TwoFactorEnabled = table.Column<bool>(type: "bit", nullable: false),
                    LockoutEnd = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: true),
                    LockoutEnabled = table.Column<bool>(type: "bit", nullable: false),
                    AccessFailedCount = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUsers", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Branch",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CompanyNo = table.Column<int>(type: "int", nullable: true),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Branch", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "CIF_CK_ACCT",
                columns: table => new
                {
                    DEF_ACCT_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CIF_NO = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    ACCT_CLASS_ID = table.Column<short>(type: "smallint", nullable: false),
                    CompanyID = table.Column<short>(type: "smallint", nullable: false),
                    ACCT_NO = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    Currency = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: false),
                    Name = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    REFERENCE = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    Title = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    Description = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    ReferenceACCT = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    ReferenceOrg = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    IBAN = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    OpenDate = table.Column<DateTime>(type: "datetime", nullable: true),
                    ExternallyManged = table.Column<bool>(type: "bit", nullable: false),
                    STATUS = table.Column<short>(type: "smallint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CIF_CK_ACCT", x => x.DEF_ACCT_ID);
                });

            migrationBuilder.CreateTable(
                name: "Company",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Company", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Currency",
                columns: table => new
                {
                    CurrencyID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ISOCode = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: false),
                    Symbol = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: true),
                    Fractions = table.Column<short>(type: "smallint", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Currency", x => x.CurrencyID);
                });

            migrationBuilder.CreateTable(
                name: "Dep",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Dep", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "DeviceCodes",
                columns: table => new
                {
                    UserCode = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    DeviceCode = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    SubjectId = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    SessionId = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    ClientId = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    CreationTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Expiration = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Data = table.Column<string>(type: "nvarchar(max)", maxLength: 50000, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeviceCodes", x => x.UserCode);
                });

            migrationBuilder.CreateTable(
                name: "ExchangeRates",
                columns: table => new
                {
                    ExchangeRateID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FromCurrency = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: false),
                    ToCurrency = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: false),
                    Rate = table.Column<decimal>(type: "decimal(18,3)", nullable: false),
                    EffectiveDate = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ExchangeRates", x => x.ExchangeRateID);
                });

            migrationBuilder.CreateTable(
                name: "Keys",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Version = table.Column<int>(type: "int", nullable: false),
                    Created = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Use = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    Algorithm = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    IsX509Certificate = table.Column<bool>(type: "bit", nullable: false),
                    DataProtected = table.Column<bool>(type: "bit", nullable: false),
                    Data = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Keys", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "LUT_ACCT_TYPE",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LUT_ACCT_TYPE", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "LUT_CIF_TYPE",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LUT_CIF_TYPE", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "LUT_GLLedgerNature",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    CR_DR = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LUT_GLLedgerNature", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "LUT_PRODUCT_CHANNEL",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LUT_PRODUCT_CHANNEL", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "LUT_PRODUCT_FAMILY",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LUT_PRODUCT_FAMILY", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "LUT_PRODUCT_LOB",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LUT_PRODUCT_LOB", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "PersistedGrants",
                columns: table => new
                {
                    Key = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Type = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    SubjectId = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    SessionId = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    ClientId = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    CreationTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Expiration = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ConsumedTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Data = table.Column<string>(type: "nvarchar(max)", maxLength: 50000, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PersistedGrants", x => x.Key);
                });

            migrationBuilder.CreateTable(
                name: "PRODUCT_CLASS",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    PRODUCT_TYPE = table.Column<short>(type: "smallint", nullable: false),
                    CURRENCY = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: true),
                    PRODUCT_FAMILY = table.Column<short>(type: "smallint", nullable: false),
                    PRODUCT_SUB_TYPE = table.Column<short>(type: "smallint", nullable: false),
                    PRODUCT_CHANNEL = table.Column<short>(type: "smallint", nullable: false),
                    DESCRIPTION = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PRODUCT_CLASS", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "PRODUCT_DESC",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    PRODUCT_TYPE = table.Column<short>(type: "smallint", nullable: false),
                    PRODUCT_CLASS = table.Column<short>(type: "smallint", nullable: false),
                    CURRENCY = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: true),
                    PRODUCT_FAMILY = table.Column<short>(type: "smallint", nullable: false),
                    PRODUCT_SUB_TYPE = table.Column<short>(type: "smallint", nullable: false),
                    PRODUCT_CHANNEL = table.Column<short>(type: "smallint", nullable: false),
                    DESCRIPTION = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PRODUCT_DESC", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "PRODUCT_SUB_TYPE",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    PRODUCT_TYPE = table.Column<short>(type: "smallint", nullable: false),
                    PRODUCT_FAMILY = table.Column<short>(type: "smallint", nullable: false),
                    PRODUCT_CHANNEL = table.Column<short>(type: "smallint", nullable: false),
                    DESCRIPTION = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PRODUCT_SUB_TYPE", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "PRODUCT_TYPE",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    PRODUCT_FAMILY = table.Column<short>(type: "smallint", nullable: false),
                    PRODUCT_CHANNEL = table.Column<short>(type: "smallint", nullable: false),
                    DESCRIPTION = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PRODUCT_TYPE", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Sector",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Sector", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Settings",
                columns: table => new
                {
                    VerID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CompanyNo = table.Column<short>(type: "smallint", nullable: true),
                    EffectiveDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    GLFormat = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    GLFormatDigits = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    BaseCurrency = table.Column<string>(type: "nvarchar(5)", maxLength: 5, nullable: false),
                    ACCTFormatDigits = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    ACCTFormatDigitsNum = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    ACCTFormat = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    CIFFormatDigits = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Settings", x => x.VerID);
                });

            migrationBuilder.CreateTable(
                name: "Unit",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Unit", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Zone",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Zone", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "AspNetRoleClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RoleId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ClaimType = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ClaimValue = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoleClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetRoleClaims_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ClaimType = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ClaimValue = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetUserClaims_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserLogins",
                columns: table => new
                {
                    LoginProvider = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ProviderKey = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ProviderDisplayName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserLogins", x => new { x.LoginProvider, x.ProviderKey });
                    table.ForeignKey(
                        name: "FK_AspNetUserLogins_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserRoles",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    RoleId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserRoles", x => new { x.UserId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserTokens",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    LoginProvider = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Value = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserTokens", x => new { x.UserId, x.LoginProvider, x.Name });
                    table.ForeignKey(
                        name: "FK_AspNetUserTokens_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CIF_ACCT_CLASS",
                columns: table => new
                {
                    ACCT_CLASS_ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    ACCT_TYPE = table.Column<short>(type: "smallint", nullable: false),
                    REFERENCE = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    ExternallyManged = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CIF_ACCT_CLASS", x => x.ACCT_CLASS_ID);
                    table.ForeignKey(
                        name: "FK_CIF_ACCT_CLASS_LUT_ACCT_TYPE_ACCT_TYPE",
                        column: x => x.ACCT_TYPE,
                        principalTable: "LUT_ACCT_TYPE",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CIF_CLASS",
                columns: table => new
                {
                    CIF_CLASS_ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    CIF_TYPE = table.Column<short>(type: "smallint", nullable: false),
                    REFERENCE = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CIF_CLASS", x => x.CIF_CLASS_ID);
                    table.ForeignKey(
                        name: "FK_CIF_CLASS_LUT_CIF_TYPE_CIF_TYPE",
                        column: x => x.CIF_TYPE,
                        principalTable: "LUT_CIF_TYPE",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "GL_ACCT",
                columns: table => new
                {
                    GL_DEFID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CompanyNo = table.Column<short>(type: "smallint", nullable: false),
                    Zone = table.Column<short>(type: "smallint", nullable: true),
                    BranchNo = table.Column<short>(type: "smallint", nullable: true),
                    SectorNo = table.Column<short>(type: "smallint", nullable: true),
                    DepNo = table.Column<short>(type: "smallint", nullable: true),
                    UnitNO = table.Column<short>(type: "smallint", nullable: true),
                    UnitObjID = table.Column<short>(type: "smallint", nullable: true),
                    ProductNo = table.Column<short>(type: "smallint", nullable: true),
                    Nature = table.Column<short>(type: "smallint", nullable: false),
                    LedgerNO = table.Column<int>(type: "int", nullable: false),
                    GL = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    COMMENTS = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Name = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    EFFECTIVE_DT = table.Column<DateTime>(type: "datetime", nullable: false),
                    STATUS = table.Column<short>(type: "smallint", nullable: false),
                    REFERENCE = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GL_ACCT", x => x.GL_DEFID);
                    table.ForeignKey(
                        name: "FK_GL_ACCT_Branch_BranchNo",
                        column: x => x.BranchNo,
                        principalTable: "Branch",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_GL_ACCT_Company_CompanyNo",
                        column: x => x.CompanyNo,
                        principalTable: "Company",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_GL_ACCT_Dep_DepNo",
                        column: x => x.DepNo,
                        principalTable: "Dep",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_GL_ACCT_LUT_GLLedgerNature_Nature",
                        column: x => x.Nature,
                        principalTable: "LUT_GLLedgerNature",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_GL_ACCT_Sector_SectorNo",
                        column: x => x.SectorNo,
                        principalTable: "Sector",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_GL_ACCT_Unit_UnitObjID",
                        column: x => x.UnitObjID,
                        principalTable: "Unit",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_GL_ACCT_Zone_Zone",
                        column: x => x.Zone,
                        principalTable: "Zone",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "CIF_DESC",
                columns: table => new
                {
                    CIF_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CIF_NO = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    SearchKey = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    FirstName = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    MiddleName = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    LastName = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    FamilyName = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    CREATE_DT = table.Column<DateTime>(type: "datetime", nullable: false),
                    CLASS_ID = table.Column<short>(type: "smallint", nullable: false),
                    RSM = table.Column<string>(type: "nvarchar(35)", maxLength: 35, nullable: true),
                    REFERENCE = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    LAST_SAVE_DT = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CIF_DESC", x => x.CIF_ID);
                    table.ForeignKey(
                        name: "FK_CIF_DESC_CIF_CLASS_CLASS_ID",
                        column: x => x.CLASS_ID,
                        principalTable: "CIF_CLASS",
                        principalColumn: "CIF_CLASS_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CIF_PERSONAL",
                columns: table => new
                {
                    CIF_PERSONALID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Country = table.Column<short>(type: "smallint", nullable: true),
                    GOVERNORATE = table.Column<short>(type: "smallint", nullable: true),
                    City = table.Column<short>(type: "smallint", nullable: true),
                    Area = table.Column<int>(type: "int", nullable: true),
                    Address = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: true),
                    Gender = table.Column<bool>(type: "bit", nullable: false),
                    COUNTRY_OF_BIRTH = table.Column<short>(type: "smallint", nullable: true),
                    Nationality = table.Column<short>(type: "smallint", nullable: true),
                    BIRTH_DT = table.Column<DateTime>(type: "datetime", nullable: true),
                    MobileNumber = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    HomeNumber = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    WorkNumber = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    NationalID = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    CIF_ID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CIF_PERSONAL", x => x.CIF_PERSONALID);
                    table.ForeignKey(
                        name: "FK_CIF_PERSONAL_CIF_DESC_CIF_ID",
                        column: x => x.CIF_ID,
                        principalTable: "CIF_DESC",
                        principalColumn: "CIF_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Currency",
                columns: new[] { "CurrencyID", "Fractions", "ISOCode", "Name", "Symbol" },
                values: new object[,]
                {
                    { (short)1, (short)2, "EGP", "Egyptian Pound", null },
                    { (short)2, (short)2, "USD", "US Dollar", null },
                    { (short)3, (short)2, "SAR", "Saudi Riyal ", null }
                });

            migrationBuilder.InsertData(
                table: "LUT_ACCT_TYPE",
                columns: new[] { "ID", "Name" },
                values: new object[] { (short)1, "CK" });

            migrationBuilder.InsertData(
                table: "LUT_CIF_TYPE",
                columns: new[] { "ID", "Name" },
                values: new object[,]
                {
                    { (short)1, "Personal" },
                    { (short)2, "Non Personal" }
                });

            migrationBuilder.InsertData(
                table: "LUT_GLLedgerNature",
                columns: new[] { "ID", "CR_DR", "Name" },
                values: new object[,]
                {
                    { (short)1, "DR", "Asset" },
                    { (short)2, "CR", "Liability" },
                    { (short)3, "CR", "Income" },
                    { (short)4, "DR", "Expense" },
                    { (short)5, "CR", "Capital" }
                });

            migrationBuilder.InsertData(
                table: "LUT_PRODUCT_CHANNEL",
                columns: new[] { "ID", "Name" },
                values: new object[] { (short)1, "TRSDEALER" });

            migrationBuilder.InsertData(
                table: "LUT_PRODUCT_FAMILY",
                columns: new[] { "ID", "Name" },
                values: new object[] { (short)1, "Treasury" });

            migrationBuilder.InsertData(
                table: "LUT_PRODUCT_LOB",
                columns: new[] { "ID", "Name" },
                values: new object[] { (short)1, "Banking" });

            migrationBuilder.InsertData(
                table: "Settings",
                columns: new[] { "VerID", "ACCTFormat", "ACCTFormatDigits", "ACCTFormatDigitsNum", "BaseCurrency", "CIFFormatDigits", "CompanyNo", "EffectiveDate", "GLFormat", "GLFormatDigits" },
                values: new object[] { (short)1, "", "000000000", "4", "EGP", "000000000", (short)1, new DateTime(2024, 1, 22, 11, 58, 13, 447, DateTimeKind.Local).AddTicks(3653), "Nature-CompanyNo-ProductNo-LedgerNo", "#-##-####-######" });

            migrationBuilder.CreateIndex(
                name: "IX_AspNetRoleClaims_RoleId",
                table: "AspNetRoleClaims",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "RoleNameIndex",
                table: "AspNetRoles",
                column: "NormalizedName",
                unique: true,
                filter: "[NormalizedName] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserClaims_UserId",
                table: "AspNetUserClaims",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserLogins_UserId",
                table: "AspNetUserLogins",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserRoles_RoleId",
                table: "AspNetUserRoles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "EmailIndex",
                table: "AspNetUsers",
                column: "NormalizedEmail");

            migrationBuilder.CreateIndex(
                name: "UserNameIndex",
                table: "AspNetUsers",
                column: "NormalizedUserName",
                unique: true,
                filter: "[NormalizedUserName] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_CIF_ACCT_CLASS_ACCT_TYPE",
                table: "CIF_ACCT_CLASS",
                column: "ACCT_TYPE");

            migrationBuilder.CreateIndex(
                name: "IX_CIF_CLASS_CIF_TYPE",
                table: "CIF_CLASS",
                column: "CIF_TYPE");

            migrationBuilder.CreateIndex(
                name: "IX_CIF_DESC_CLASS_ID",
                table: "CIF_DESC",
                column: "CLASS_ID");

            migrationBuilder.CreateIndex(
                name: "IX_CIF_PERSONAL_CIF_ID",
                table: "CIF_PERSONAL",
                column: "CIF_ID",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DeviceCodes_DeviceCode",
                table: "DeviceCodes",
                column: "DeviceCode",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DeviceCodes_Expiration",
                table: "DeviceCodes",
                column: "Expiration");

            migrationBuilder.CreateIndex(
                name: "IX_GL_ACCT_BranchNo",
                table: "GL_ACCT",
                column: "BranchNo");

            migrationBuilder.CreateIndex(
                name: "IX_GL_ACCT_CompanyNo",
                table: "GL_ACCT",
                column: "CompanyNo");

            migrationBuilder.CreateIndex(
                name: "IX_GL_ACCT_DepNo",
                table: "GL_ACCT",
                column: "DepNo");

            migrationBuilder.CreateIndex(
                name: "IX_GL_ACCT_Nature",
                table: "GL_ACCT",
                column: "Nature");

            migrationBuilder.CreateIndex(
                name: "IX_GL_ACCT_SectorNo",
                table: "GL_ACCT",
                column: "SectorNo");

            migrationBuilder.CreateIndex(
                name: "IX_GL_ACCT_UnitObjID",
                table: "GL_ACCT",
                column: "UnitObjID");

            migrationBuilder.CreateIndex(
                name: "IX_GL_ACCT_Zone",
                table: "GL_ACCT",
                column: "Zone");

            migrationBuilder.CreateIndex(
                name: "IX_Keys_Use",
                table: "Keys",
                column: "Use");

            migrationBuilder.CreateIndex(
                name: "IX_PersistedGrants_ConsumedTime",
                table: "PersistedGrants",
                column: "ConsumedTime");

            migrationBuilder.CreateIndex(
                name: "IX_PersistedGrants_Expiration",
                table: "PersistedGrants",
                column: "Expiration");

            migrationBuilder.CreateIndex(
                name: "IX_PersistedGrants_SubjectId_ClientId_Type",
                table: "PersistedGrants",
                columns: new[] { "SubjectId", "ClientId", "Type" });

            migrationBuilder.CreateIndex(
                name: "IX_PersistedGrants_SubjectId_SessionId_Type",
                table: "PersistedGrants",
                columns: new[] { "SubjectId", "SessionId", "Type" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AccountingPosting");

            migrationBuilder.DropTable(
                name: "ACCTDataSource");

            migrationBuilder.DropTable(
                name: "AspNetRoleClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserLogins");

            migrationBuilder.DropTable(
                name: "AspNetUserRoles");

            migrationBuilder.DropTable(
                name: "AspNetUserTokens");

            migrationBuilder.DropTable(
                name: "CIF_ACCT_CLASS");

            migrationBuilder.DropTable(
                name: "CIF_CK_ACCT");

            migrationBuilder.DropTable(
                name: "CIF_PERSONAL");

            migrationBuilder.DropTable(
                name: "Currency");

            migrationBuilder.DropTable(
                name: "DeviceCodes");

            migrationBuilder.DropTable(
                name: "ExchangeRates");

            migrationBuilder.DropTable(
                name: "GL_ACCT");

            migrationBuilder.DropTable(
                name: "Keys");

            migrationBuilder.DropTable(
                name: "LUT_PRODUCT_CHANNEL");

            migrationBuilder.DropTable(
                name: "LUT_PRODUCT_FAMILY");

            migrationBuilder.DropTable(
                name: "LUT_PRODUCT_LOB");

            migrationBuilder.DropTable(
                name: "PersistedGrants");

            migrationBuilder.DropTable(
                name: "PRODUCT_CLASS");

            migrationBuilder.DropTable(
                name: "PRODUCT_DESC");

            migrationBuilder.DropTable(
                name: "PRODUCT_SUB_TYPE");

            migrationBuilder.DropTable(
                name: "PRODUCT_TYPE");

            migrationBuilder.DropTable(
                name: "Settings");

            migrationBuilder.DropTable(
                name: "AspNetRoles");

            migrationBuilder.DropTable(
                name: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "LUT_ACCT_TYPE");

            migrationBuilder.DropTable(
                name: "CIF_DESC");

            migrationBuilder.DropTable(
                name: "Branch");

            migrationBuilder.DropTable(
                name: "Company");

            migrationBuilder.DropTable(
                name: "Dep");

            migrationBuilder.DropTable(
                name: "LUT_GLLedgerNature");

            migrationBuilder.DropTable(
                name: "Sector");

            migrationBuilder.DropTable(
                name: "Unit");

            migrationBuilder.DropTable(
                name: "Zone");

            migrationBuilder.DropTable(
                name: "CIF_CLASS");

            migrationBuilder.DropTable(
                name: "LUT_CIF_TYPE");
        }
    }
}