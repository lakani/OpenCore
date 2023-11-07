using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace SIS.OpenCore.Server.Migrations
{
    /// <inheritdoc />
    public partial class SISOpenCore_MIGRATIONS_0001 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
                name: "DEF_Branch",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CompanyNo = table.Column<int>(type: "int", nullable: true),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_Branch", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "DEF_CK_ACCT",
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
                    OpenDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    STATUS = table.Column<short>(type: "smallint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_CK_ACCT", x => x.DEF_ACCT_ID);
                });

            migrationBuilder.CreateTable(
                name: "DEF_Company",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_Company", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "DEF_Currency",
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
                    table.PrimaryKey("PK_DEF_Currency", x => x.CurrencyID);
                });

            migrationBuilder.CreateTable(
                name: "DEF_Dep",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_Dep", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "DEF_GL",
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
                    ProductNo = table.Column<short>(type: "smallint", nullable: true),
                    Nature = table.Column<short>(type: "smallint", nullable: false),
                    LedgerNO = table.Column<int>(type: "int", nullable: false),
                    GL = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    COMMENTS = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    EFFECTIVE_DT = table.Column<DateTime>(type: "datetime", nullable: false),
                    STATUS = table.Column<short>(type: "smallint", nullable: false),
                    REFERENCE = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_GL", x => x.GL_DEFID);
                });

            migrationBuilder.CreateTable(
                name: "DEF_Sector",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_Sector", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "DEF_Unit",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_Unit", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "DEF_Zone",
                columns: table => new
                {
                    ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_Zone", x => x.ID);
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
                    Rate = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
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
                    LoginProvider = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    ProviderKey = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
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
                    LoginProvider = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    Name = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
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
                name: "DEF_ACCT_CLASS",
                columns: table => new
                {
                    ACCT_CLASS_ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    ACCT_TYPE = table.Column<short>(type: "smallint", nullable: false),
                    REFERENCE = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_ACCT_CLASS", x => x.ACCT_CLASS_ID);
                    table.ForeignKey(
                        name: "FK_DEF_ACCT_CLASS_LUT_ACCT_TYPE_ACCT_TYPE",
                        column: x => x.ACCT_TYPE,
                        principalTable: "LUT_ACCT_TYPE",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DEF_CIF_CLASS",
                columns: table => new
                {
                    CIF_CLASS_ID = table.Column<short>(type: "smallint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(80)", maxLength: 80, nullable: false),
                    CIF_TYPE = table.Column<short>(type: "smallint", nullable: false),
                    REFERENCE = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DEF_CIF_CLASS", x => x.CIF_CLASS_ID);
                    table.ForeignKey(
                        name: "FK_DEF_CIF_CLASS_LUT_CIF_TYPE_CIF_TYPE",
                        column: x => x.CIF_TYPE,
                        principalTable: "LUT_CIF_TYPE",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DEF_CIF",
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
                    table.PrimaryKey("PK_DEF_CIF", x => x.CIF_ID);
                    table.ForeignKey(
                        name: "FK_DEF_CIF_DEF_CIF_CLASS_CLASS_ID",
                        column: x => x.CLASS_ID,
                        principalTable: "DEF_CIF_CLASS",
                        principalColumn: "CIF_CLASS_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DEF_CIF_PERSONAL",
                columns: table => new
                {
                    DEF_CIF_PERSONALID = table.Column<int>(type: "int", nullable: false)
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
                    table.PrimaryKey("PK_DEF_CIF_PERSONAL", x => x.DEF_CIF_PERSONALID);
                    table.ForeignKey(
                        name: "FK_DEF_CIF_PERSONAL_DEF_CIF_CIF_ID",
                        column: x => x.CIF_ID,
                        principalTable: "DEF_CIF",
                        principalColumn: "CIF_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "DEF_Currency",
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
                table: "Settings",
                columns: new[] { "VerID", "ACCTFormat", "ACCTFormatDigits", "ACCTFormatDigitsNum", "BaseCurrency", "CIFFormatDigits", "CompanyNo", "EffectiveDate", "GLFormat", "GLFormatDigits" },
                values: new object[] { (short)1, "", "000000000", "4", "EGP", "000000000", (short)1, new DateTime(2023, 11, 7, 11, 49, 24, 209, DateTimeKind.Local).AddTicks(2257), "Nature-CompanyNo-ProductNo-LedgerNo", "#-##-####-######" });

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
                name: "IX_DEF_ACCT_CLASS_ACCT_TYPE",
                table: "DEF_ACCT_CLASS",
                column: "ACCT_TYPE");

            migrationBuilder.CreateIndex(
                name: "IX_DEF_CIF_CLASS_ID",
                table: "DEF_CIF",
                column: "CLASS_ID");

            migrationBuilder.CreateIndex(
                name: "IX_DEF_CIF_CLASS_CIF_TYPE",
                table: "DEF_CIF_CLASS",
                column: "CIF_TYPE");

            migrationBuilder.CreateIndex(
                name: "IX_DEF_CIF_PERSONAL_CIF_ID",
                table: "DEF_CIF_PERSONAL",
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
                name: "DEF_ACCT_CLASS");

            migrationBuilder.DropTable(
                name: "DEF_Branch");

            migrationBuilder.DropTable(
                name: "DEF_CIF_PERSONAL");

            migrationBuilder.DropTable(
                name: "DEF_CK_ACCT");

            migrationBuilder.DropTable(
                name: "DEF_Company");

            migrationBuilder.DropTable(
                name: "DEF_Currency");

            migrationBuilder.DropTable(
                name: "DEF_Dep");

            migrationBuilder.DropTable(
                name: "DEF_GL");

            migrationBuilder.DropTable(
                name: "DEF_Sector");

            migrationBuilder.DropTable(
                name: "DEF_Unit");

            migrationBuilder.DropTable(
                name: "DEF_Zone");

            migrationBuilder.DropTable(
                name: "DeviceCodes");

            migrationBuilder.DropTable(
                name: "ExchangeRates");

            migrationBuilder.DropTable(
                name: "Keys");

            migrationBuilder.DropTable(
                name: "PersistedGrants");

            migrationBuilder.DropTable(
                name: "Settings");

            migrationBuilder.DropTable(
                name: "AspNetRoles");

            migrationBuilder.DropTable(
                name: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "LUT_ACCT_TYPE");

            migrationBuilder.DropTable(
                name: "DEF_CIF");

            migrationBuilder.DropTable(
                name: "DEF_CIF_CLASS");

            migrationBuilder.DropTable(
                name: "LUT_CIF_TYPE");
        }
    }
}
