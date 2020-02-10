using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace SIS.OpenCore.EL
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

        public virtual DbSet<DEF_ACCT_CLASS> DEF_ACCT_CLASS { get; set; }
        public virtual DbSet<DEF_Branch> DEF_Branch { get; set; }
        public virtual DbSet<DEF_BusinessDate> DEF_BusinessDate { get; set; }
        public virtual DbSet<DEF_CIF> DEF_CIF { get; set; }
        public virtual DbSet<DEF_CIF_CLASS> DEF_CIF_CLASS { get; set; }
        public virtual DbSet<DEF_CIF_Company> DEF_CIF_Company { get; set; }
        public virtual DbSet<DEF_Company> DEF_Company { get; set; }
        public virtual DbSet<DEF_Currency> DEF_Currency { get; set; }
        public virtual DbSet<DEF_Dep> DEF_Dep { get; set; }
        public virtual DbSet<DEF_EMP> DEF_EMP { get; set; }
        public virtual DbSet<DEF_GL> DEF_GL { get; set; }
        public virtual DbSet<DEF_Sector> DEF_Sector { get; set; }
        public virtual DbSet<DEF_Unit> DEF_Unit { get; set; }
        public virtual DbSet<DEF_Zone> DEF_Zone { get; set; }
        public virtual DbSet<ExchangeRates> ExchangeRates { get; set; }
        public virtual DbSet<LUT_ACCT_TYPE> LUT_ACCT_TYPE { get; set; }
        public virtual DbSet<LUT_CIF_TYPE> LUT_CIF_TYPE { get; set; }
        public virtual DbSet<LUT_CITY> LUT_CITY { get; set; }
        public virtual DbSet<LUT_COUNTRY> LUT_COUNTRY { get; set; }
        public virtual DbSet<LUT_LedgerNature> LUT_LedgerNature { get; set; }
        public virtual DbSet<LUT_LedgerPostingLevel> LUT_LedgerPostingLevel { get; set; }
        public virtual DbSet<LUT_OBJ_STATUS> LUT_OBJ_STATUS { get; set; }
        public virtual DbSet<LUT_TRN_STATUS> LUT_TRN_STATUS { get; set; }
        public virtual DbSet<Settings> Settings { get; set; }
        public virtual DbSet<TRN_LEGS> TRN_LEGS { get; set; }
        public virtual DbSet<VW_DEF_GL> VW_DEF_GL { get; set; }

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
            modelBuilder.Entity<DEF_ACCT_CLASS>(entity =>
            {
                entity.HasKey(e => e.Code);

                entity.Property(e => e.Code).HasMaxLength(5);

                entity.Property(e => e.EFFECTIVE_DT).HasColumnType("datetime");

                entity.Property(e => e.Name).HasMaxLength(80);

                entity.Property(e => e.REFERENCE).IsRequired();

                entity.Property(e => e.Type).HasMaxLength(10);
            });

            modelBuilder.Entity<DEF_Branch>(entity =>
            {
                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DEF_BusinessDate>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.BusinessDay).HasColumnType("date");

                entity.Property(e => e.ID).ValueGeneratedOnAdd();
            });

            modelBuilder.Entity<DEF_CIF>(entity =>
            {
                entity.Property(e => e.BIRTH_DT).HasColumnType("date");

                entity.Property(e => e.CIF_CLASS).HasMaxLength(10);

                entity.Property(e => e.CIF_NO).IsRequired();

                entity.Property(e => e.CREATE_DT).HasColumnType("datetime");

                entity.Property(e => e.FamilyName).HasMaxLength(80);

                entity.Property(e => e.FirstName).HasMaxLength(80);

                entity.Property(e => e.Gender).HasMaxLength(10);

                entity.Property(e => e.HomeNumber).HasMaxLength(80);

                entity.Property(e => e.LAST_SAVE_DT).HasColumnType("datetime");

                entity.Property(e => e.LastName).HasMaxLength(80);

                entity.Property(e => e.MiddleName).HasMaxLength(80);

                entity.Property(e => e.MobileNumber).HasMaxLength(80);

                entity.Property(e => e.SearchKey).IsRequired();

                entity.Property(e => e.WorkNumber).HasMaxLength(80);
            });

            modelBuilder.Entity<DEF_CIF_CLASS>(entity =>
            {
                entity.HasKey(e => new { e.Code, e.CompanyNo })
                    .HasName("PK__DEF_CIF___A25C5AA6127E02BB");

                entity.Property(e => e.Code).HasMaxLength(10);

                entity.Property(e => e.EFFECTIVE_DT).HasColumnType("datetime");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(80);
            });

            modelBuilder.Entity<DEF_CIF_Company>(entity =>
            {
                entity.HasKey(e => e.DEF_CIF_Company_ID);
            });

            modelBuilder.Entity<DEF_Company>(entity =>
            {
                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DEF_Currency>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.CurrencyID).ValueGeneratedOnAdd();

                entity.Property(e => e.ISOCode)
                    .IsRequired()
                    .HasMaxLength(3);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Symbol)
                    .IsRequired()
                    .HasMaxLength(3);
            });

            modelBuilder.Entity<DEF_Dep>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.ID).ValueGeneratedOnAdd();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DEF_EMP>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.CREATE_DT).HasColumnType("datetime");

                entity.Property(e => e.EMP_ID).ValueGeneratedOnAdd();

                entity.Property(e => e.FamilyName).HasMaxLength(80);

                entity.Property(e => e.FirstName).HasMaxLength(80);

                entity.Property(e => e.HomeNumber).HasMaxLength(80);

                entity.Property(e => e.LAST_SAVE_DT).HasColumnType("datetime");

                entity.Property(e => e.LastName).HasMaxLength(80);

                entity.Property(e => e.MiddleName).HasMaxLength(80);

                entity.Property(e => e.MobileNumber).HasMaxLength(80);

                entity.Property(e => e.WorkNumber).HasMaxLength(80);
            });

            modelBuilder.Entity<DEF_GL>(entity =>
            {
                entity.HasKey(e => e.GL_DEFID);

                entity.Property(e => e.COMMENTS).HasMaxLength(200);

                entity.Property(e => e.CURR)
                    .IsRequired()
                    .HasMaxLength(4);

                entity.Property(e => e.EFFECTIVE_DT).HasColumnType("datetime");

                entity.Property(e => e.LedgerNO)
                    .IsRequired()
                    .HasMaxLength(15);

                entity.Property(e => e.TotallingGL).HasMaxLength(35);
            });

            modelBuilder.Entity<DEF_Sector>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DEF_Unit>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<DEF_Zone>(entity =>
            {
                entity.HasNoKey();

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

                entity.Property(e => e.TimeEXC).HasColumnType("datetime");

                entity.Property(e => e.ToCurIsoCode)
                    .IsRequired()
                    .HasMaxLength(3)
                    .IsFixedLength();
            });

            modelBuilder.Entity<LUT_ACCT_TYPE>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.Description).IsRequired();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(10);
            });

            modelBuilder.Entity<LUT_CIF_TYPE>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PK__LUT_CIF___A25C5AA6A1F27BC6");

                entity.Property(e => e.Name).HasMaxLength(80);
            });

            modelBuilder.Entity<LUT_CITY>(entity =>
            {
                entity.HasKey(e => e.Code);

                entity.Property(e => e.Code).HasMaxLength(10);

                entity.Property(e => e.CountryCode)
                    .IsRequired()
                    .HasMaxLength(10);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(80);
            });

            modelBuilder.Entity<LUT_COUNTRY>(entity =>
            {
                entity.HasKey(e => e.Code);

                entity.Property(e => e.Code).HasMaxLength(10);

                entity.Property(e => e.Name).HasMaxLength(80);
            });

            modelBuilder.Entity<LUT_LedgerNature>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.CR_DR)
                    .IsRequired()
                    .HasMaxLength(2)
                    .IsFixedLength();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<LUT_LedgerPostingLevel>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.PostingLevel)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<LUT_OBJ_STATUS>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.NAME).HasMaxLength(80);

                entity.Property(e => e.STATUS_ID).ValueGeneratedOnAdd();
            });

            modelBuilder.Entity<LUT_TRN_STATUS>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.NAME).HasMaxLength(80);

                entity.Property(e => e.STATUS_ID).ValueGeneratedOnAdd();
            });

            modelBuilder.Entity<Settings>(entity =>
            {
                entity.HasKey(e => e.VerID);

                entity.Property(e => e.ACCTFormat)
                    .HasMaxLength(200)
                    .IsFixedLength();

                entity.Property(e => e.ACCTFormatDigits)
                    .HasMaxLength(200)
                    .IsFixedLength();

                entity.Property(e => e.ACCTFormatDigitsNum)
                    .HasMaxLength(200)
                    .IsFixedLength();

                entity.Property(e => e.BaseCurrency)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsFixedLength();

                entity.Property(e => e.CIFFormatDigits)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsFixedLength();

                entity.Property(e => e.EffectiveDate).HasColumnType("date");

                entity.Property(e => e.GLFormat)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsFixedLength();

                entity.Property(e => e.GLFormatDigits)
                    .HasMaxLength(200)
                    .IsFixedLength();
            });

            modelBuilder.Entity<TRN_LEGS>(entity =>
            {
                entity.HasKey(e => e.TRN_LEGS_ID);

                entity.Property(e => e.Acct_Amt).HasColumnType("decimal(28, 3)");

                entity.Property(e => e.Acct_CR_DR).HasMaxLength(2);

                entity.Property(e => e.Acct_Curr).HasMaxLength(3);

                entity.Property(e => e.Balance_After).HasColumnType("decimal(28, 3)");

                entity.Property(e => e.Balance_Before).HasColumnType("decimal(28, 3)");

                entity.Property(e => e.CREATE_DT).HasColumnType("datetime");

                entity.Property(e => e.EffDt).HasColumnType("date");
            });

            modelBuilder.Entity<VW_DEF_GL>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("VW_DEF_GL");

                entity.Property(e => e.BranchName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.CR_DR)
                    .IsRequired()
                    .HasMaxLength(2)
                    .IsFixedLength();

                entity.Property(e => e.CURR)
                    .IsRequired()
                    .HasMaxLength(4);

                entity.Property(e => e.CompanyName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.DepName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.EFFECTIVE_DT).HasColumnType("date");

                entity.Property(e => e.LedgerNO)
                    .IsRequired()
                    .HasMaxLength(15);

                entity.Property(e => e.NatureName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.SectorName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.TotallingGL).HasMaxLength(35);

                entity.Property(e => e.UnitName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.ZoneName)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
