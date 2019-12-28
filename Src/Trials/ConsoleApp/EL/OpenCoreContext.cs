using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace SIS.OpenCore.EF
{
    public partial class OpenCoreContext : DbContext
    {
        public OpenCoreContext()
        {
        }

        public OpenCoreContext(DbContextOptions<OpenCoreContext> options)
            : base(options)
        {
        }

        public virtual DbSet<DefBranch> DefBranch { get; set; }
        public virtual DbSet<DefBusinessDate> DefBusinessDate { get; set; }
        public virtual DbSet<DefCif> DefCif { get; set; }
        public virtual DbSet<DefCifClass> DefCifClass { get; set; }
        public virtual DbSet<DefCifCompany> DefCifCompany { get; set; }
        public virtual DbSet<DefCompany> DefCompany { get; set; }
        public virtual DbSet<DefCurrency> DefCurrency { get; set; }
        public virtual DbSet<DefDep> DefDep { get; set; }
        public virtual DbSet<DefEmp> DefEmp { get; set; }
        public virtual DbSet<DefGl> DefGl { get; set; }
        public virtual DbSet<DefSector> DefSector { get; set; }
        public virtual DbSet<DefUnit> DefUnit { get; set; }
        public virtual DbSet<DefZone> DefZone { get; set; }
        public virtual DbSet<ExchangeRates> ExchangeRates { get; set; }
        public virtual DbSet<LutAcctType> LutAcctType { get; set; }
        public virtual DbSet<LutCifType> LutCifType { get; set; }
        public virtual DbSet<LutCity> LutCity { get; set; }
        public virtual DbSet<LutCountry> LutCountry { get; set; }
        public virtual DbSet<LutLedgerNature> LutLedgerNature { get; set; }
        public virtual DbSet<LutLedgerPostingLevel> LutLedgerPostingLevel { get; set; }
        public virtual DbSet<LutObjStatus> LutObjStatus { get; set; }
        public virtual DbSet<LutTrnStatus> LutTrnStatus { get; set; }
        public virtual DbSet<Settings> Settings { get; set; }
        public virtual DbSet<TrnLegs> TrnLegs { get; set; }
        public virtual DbSet<VwDefGl> VwDefGl { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=localhost;Database=OpenCore;UID=sa;password=get@get1");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DefBranch>(entity =>
            {
                entity.ToTable("DEF_Branch");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .ValueGeneratedNever();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DefBusinessDate>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("DEF_BusinessDate");

                entity.Property(e => e.BusinessDay).HasColumnType("date");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .ValueGeneratedOnAdd();
            });

            modelBuilder.Entity<DefCif>(entity =>
            {
                entity.ToTable("DEF_CIF");

                entity.Property(e => e.BirthDt)
                    .HasColumnName("BIRTH_DT")
                    .HasColumnType("date");

                entity.Property(e => e.CifClass)
                    .HasColumnName("CIF_CLASS")
                    .HasMaxLength(10);

                entity.Property(e => e.CifNo)
                    .IsRequired()
                    .HasColumnName("CIF_NO");

                entity.Property(e => e.CifType).HasColumnName("CIF_TYPE");

                entity.Property(e => e.CountryOfBirth).HasColumnName("COUNTRY_OF_BIRTH");

                entity.Property(e => e.CreateDt)
                    .HasColumnName("CREATE_DT")
                    .HasColumnType("datetime");

                entity.Property(e => e.FamilyName).HasMaxLength(80);

                entity.Property(e => e.FirstName).HasMaxLength(80);

                entity.Property(e => e.Gender).HasMaxLength(10);

                entity.Property(e => e.Governorate).HasColumnName("GOVERNORATE");

                entity.Property(e => e.HomeNumber).HasMaxLength(80);

                entity.Property(e => e.LastName).HasMaxLength(80);

                entity.Property(e => e.LastSaveDt)
                    .HasColumnName("LAST_SAVE_DT")
                    .HasColumnType("datetime");

                entity.Property(e => e.MiddleName).HasMaxLength(80);

                entity.Property(e => e.MobileNumber).HasMaxLength(80);

                entity.Property(e => e.NationalId).HasColumnName("NationalID");

                entity.Property(e => e.SearchKey).IsRequired();

                entity.Property(e => e.WorkNumber).HasMaxLength(80);
            });

            modelBuilder.Entity<DefCifClass>(entity =>
            {
                entity.HasKey(e => new { e.Code, e.CompanyNo })
                    .HasName("PK__DEF_CIF___A25C5AA6127E02BB");

                entity.ToTable("DEF_CIF_CLASS");

                entity.Property(e => e.Code).HasMaxLength(10);

                entity.Property(e => e.EffectiveDt)
                    .HasColumnName("EFFECTIVE_DT")
                    .HasColumnType("datetime");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(80);

                entity.Property(e => e.Reference).HasColumnName("REFERENCE");
            });

            modelBuilder.Entity<DefCifCompany>(entity =>
            {
                entity.ToTable("DEF_CIF_Company");

                entity.Property(e => e.DefCifCompanyId).HasColumnName("DEF_CIF_Company_ID");

                entity.Property(e => e.CifNo).HasColumnName("CIF_NO");

                entity.Property(e => e.CompanyId).HasColumnName("Company_ID");
            });

            modelBuilder.Entity<DefCompany>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("DEF_Company");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DefCurrency>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("DEF_Currency");

                entity.Property(e => e.CurrencyId)
                    .HasColumnName("CurrencyID")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Isocode)
                    .IsRequired()
                    .HasColumnName("ISOCode")
                    .HasMaxLength(3);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Symbol)
                    .IsRequired()
                    .HasMaxLength(3);
            });

            modelBuilder.Entity<DefDep>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("DEF_Dep");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DefEmp>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("DEF_EMP");

                entity.Property(e => e.CifNo).HasColumnName("CIF_NO");

                entity.Property(e => e.CreateDt)
                    .HasColumnName("CREATE_DT")
                    .HasColumnType("datetime");

                entity.Property(e => e.EmpId)
                    .HasColumnName("EMP_ID")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.FamilyName).HasMaxLength(80);

                entity.Property(e => e.FirstName).HasMaxLength(80);

                entity.Property(e => e.HomeNumber).HasMaxLength(80);

                entity.Property(e => e.LastName).HasMaxLength(80);

                entity.Property(e => e.LastSaveDt)
                    .HasColumnName("LAST_SAVE_DT")
                    .HasColumnType("datetime");

                entity.Property(e => e.MiddleName).HasMaxLength(80);

                entity.Property(e => e.MobileNumber).HasMaxLength(80);

                entity.Property(e => e.StatusId).HasColumnName("STATUS_ID");

                entity.Property(e => e.WorkNumber).HasMaxLength(80);
            });

            modelBuilder.Entity<DefGl>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("DEF_GL");

                entity.Property(e => e.Comments)
                    .HasColumnName("COMMENTS")
                    .HasMaxLength(200);

                entity.Property(e => e.Curr)
                    .IsRequired()
                    .HasColumnName("CURR")
                    .HasMaxLength(4);

                entity.Property(e => e.EffectiveDt)
                    .HasColumnName("EFFECTIVE_DT")
                    .HasColumnType("datetime");

                entity.Property(e => e.LedgerNo)
                    .IsRequired()
                    .HasColumnName("LedgerNO")
                    .HasMaxLength(15);

                entity.Property(e => e.Reference).HasColumnName("REFERENCE");

                entity.Property(e => e.Status).HasColumnName("STATUS");

                entity.Property(e => e.TotallingGl)
                    .HasColumnName("TotallingGL")
                    .HasMaxLength(35);

                entity.Property(e => e.UnitNo).HasColumnName("UnitNO");
            });

            modelBuilder.Entity<DefSector>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("DEF_Sector");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DefUnit>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("DEF_Unit");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DefZone>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("DEF_Zone");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<ExchangeRates>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.ExRateDate).HasColumnType("datetime");

                entity.Property(e => e.FromCurIsoCode)
                    .IsRequired()
                    .HasMaxLength(3)
                    .IsFixedLength();

                entity.Property(e => e.Rate).HasColumnType("decimal(24, 9)");

                entity.Property(e => e.TimeExc)
                    .HasColumnName("TimeEXC")
                    .HasColumnType("datetime");

                entity.Property(e => e.ToCurIsoCode)
                    .IsRequired()
                    .HasMaxLength(3)
                    .IsFixedLength();
            });

            modelBuilder.Entity<LutAcctType>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("LUT_ACCT_TYPE");

                entity.Property(e => e.Description).IsRequired();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(10);
            });

            modelBuilder.Entity<LutCifType>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PK__LUT_CIF___A25C5AA6A1F27BC6");

                entity.ToTable("LUT_CIF_TYPE");

                entity.Property(e => e.Name).HasMaxLength(80);
            });

            modelBuilder.Entity<LutCity>(entity =>
            {
                entity.HasKey(e => e.Code);

                entity.ToTable("LUT_CITY");

                entity.Property(e => e.Code).HasMaxLength(10);

                entity.Property(e => e.CountryCode)
                    .IsRequired()
                    .HasMaxLength(10);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(80);
            });

            modelBuilder.Entity<LutCountry>(entity =>
            {
                entity.HasKey(e => e.Code);

                entity.ToTable("LUT_COUNTRY");

                entity.Property(e => e.Code).HasMaxLength(10);

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name).HasMaxLength(80);
            });

            modelBuilder.Entity<LutLedgerNature>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("LUT_LedgerNature");

                entity.Property(e => e.CrDr)
                    .IsRequired()
                    .HasColumnName("CR_DR")
                    .HasMaxLength(2)
                    .IsFixedLength();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<LutLedgerPostingLevel>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("LUT_LedgerPostingLevel");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.PostingLevel)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<LutObjStatus>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("LUT_OBJ_STATUS");

                entity.Property(e => e.Name)
                    .HasColumnName("NAME")
                    .HasMaxLength(80);

                entity.Property(e => e.StatusId)
                    .HasColumnName("STATUS_ID")
                    .ValueGeneratedOnAdd();
            });

            modelBuilder.Entity<LutTrnStatus>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("LUT_TRN_STATUS");

                entity.Property(e => e.Name)
                    .HasColumnName("NAME")
                    .HasMaxLength(80);

                entity.Property(e => e.StatusId)
                    .HasColumnName("STATUS_ID")
                    .ValueGeneratedOnAdd();
            });

            modelBuilder.Entity<Settings>(entity =>
            {
                entity.HasKey(e => e.VerId);

                entity.Property(e => e.VerId).HasColumnName("VerID");

                entity.Property(e => e.Acctformat)
                    .HasColumnName("ACCTFormat")
                    .HasMaxLength(200)
                    .IsFixedLength();

                entity.Property(e => e.AcctformatDigits)
                    .HasColumnName("ACCTFormatDigits")
                    .HasMaxLength(200)
                    .IsFixedLength();

                entity.Property(e => e.AcctformatDigitsNum)
                    .HasColumnName("ACCTFormatDigitsNum")
                    .HasMaxLength(200)
                    .IsFixedLength();

                entity.Property(e => e.BaseCurrency)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsFixedLength();

                entity.Property(e => e.CifformatDigits)
                    .IsRequired()
                    .HasColumnName("CIFFormatDigits")
                    .HasMaxLength(100)
                    .IsFixedLength();

                entity.Property(e => e.EffectiveDate).HasColumnType("date");

                entity.Property(e => e.Glformat)
                    .IsRequired()
                    .HasColumnName("GLFormat")
                    .HasMaxLength(200)
                    .IsFixedLength();

                entity.Property(e => e.GlformatDigits)
                    .HasColumnName("GLFormatDigits")
                    .HasMaxLength(200)
                    .IsFixedLength();
            });

            modelBuilder.Entity<TrnLegs>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("TRN_LEGS");

                entity.Property(e => e.AcctAmt)
                    .HasColumnName("Acct_Amt")
                    .HasColumnType("decimal(28, 3)");

                entity.Property(e => e.AcctCrDr)
                    .HasColumnName("Acct_CR_DR")
                    .HasMaxLength(2);

                entity.Property(e => e.AcctCurr)
                    .HasColumnName("Acct_Curr")
                    .HasMaxLength(3);

                entity.Property(e => e.AcctDescription).HasColumnName("Acct_Description");

                entity.Property(e => e.AcctNo).HasColumnName("Acct_No");

                entity.Property(e => e.BalanceAfter)
                    .HasColumnName("Balance_After")
                    .HasColumnType("decimal(28, 3)");

                entity.Property(e => e.BalanceBefore)
                    .HasColumnName("Balance_Before")
                    .HasColumnType("decimal(28, 3)");

                entity.Property(e => e.ChannelId).HasColumnName("CHANNEL_ID");

                entity.Property(e => e.CreateDt)
                    .HasColumnName("CREATE_DT")
                    .HasColumnType("datetime");

                entity.Property(e => e.EffDt).HasColumnType("date");

                entity.Property(e => e.EmpId).HasColumnName("EMP_ID");

                entity.Property(e => e.Gl).HasColumnName("GL");

                entity.Property(e => e.StatusId).HasColumnName("STATUS_ID");
            });

            modelBuilder.Entity<VwDefGl>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("VW_DEF_GL");

                entity.Property(e => e.BranchName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.CompanyName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.CrDr)
                    .IsRequired()
                    .HasColumnName("CR_DR")
                    .HasMaxLength(2)
                    .IsFixedLength();

                entity.Property(e => e.Curr)
                    .IsRequired()
                    .HasColumnName("CURR")
                    .HasMaxLength(4);

                entity.Property(e => e.DepName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.EffectiveDt)
                    .HasColumnName("EFFECTIVE_DT")
                    .HasColumnType("date");

                entity.Property(e => e.Gl).HasColumnName("GL");

                entity.Property(e => e.LedgerNo)
                    .IsRequired()
                    .HasColumnName("LedgerNO")
                    .HasMaxLength(15);

                entity.Property(e => e.NatureName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.Reference).HasColumnName("REFERENCE");

                entity.Property(e => e.SectorName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.TotallingGl)
                    .HasColumnName("TotallingGL")
                    .HasMaxLength(35);

                entity.Property(e => e.UnitName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.UnitNo).HasColumnName("UnitNO");

                entity.Property(e => e.ZoneName)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
