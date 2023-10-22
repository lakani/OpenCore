﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using SIS.OpenCore.Shared.Model.Objects.GL;


#nullable disable

namespace SIS.OpenCore.DAL.Context
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

		// TODO : remove the below after completing the cleaning and full migration to the new structure
		//public virtual DbSet<DEF_Zone> DEF_Zone { get; set; }
		public virtual DbSet<DEF_Dep> DEF_Dep { get; set; }
		public virtual DbSet<DEF_Sector> DEF_Sector { get; set; }
		public virtual DbSet<DEF_Unit> DEF_Unit { get; set; }
		public virtual DbSet<DEF_Company> DEF_Company { get; set; }
		public virtual DbSet<DEF_Branch> DEF_Branch { get; set; }



		public virtual DbSet<DEF_ACCT_CLASS> DEF_ACCT_CLASS { get; set; }
        public virtual DbSet<DEF_ACCT_CLASS_ACCT_STRUCT> DEF_ACCT_CLASS_ACCT_STRUCT { get; set; }
		public virtual DbSet<DEF_BusinessDate> DEF_BusinessDate { get; set; }
        public virtual DbSet<DEF_CIF> DEF_CIF { get; set; }
        public virtual DbSet<DEF_CIF_CLASS> DEF_CIF_CLASS { get; set; }
        public virtual DbSet<DEF_CK_ACCT> DEF_CK_ACCT { get; set; }
        public virtual DbSet<DEF_CK_ACCT_ACCT_STRUCT> DEF_CK_ACCT_ACCT_STRUCT { get; set; }
        public virtual DbSet<DEF_Currency> DEF_Currency { get; set; }
        public virtual DbSet<DEF_EMP> DEF_EMP { get; set; }
        public virtual DbSet<DEF_FIXRATE_ACCT> DEF_FIXRATE_ACCT { get; set; }
        public virtual DbSet<DEF_FIXRATE_ACCT_DATES> DEF_FIXRATE_ACCT_DATES { get; set; }
        public virtual DbSet<DEF_GL> DEF_GL { get; set; }
        public virtual DbSet<DEF_SHARE_ACCT> DEF_SHARE_ACCT { get; set; }
        public virtual DbSet<ExchangeRates> ExchangeRates { get; set; }
        public virtual DbSet<LUT_ACCRUAL_BASIS> LUT_ACCRUAL_BASIS { get; set; }
        public virtual DbSet<LUT_ACCT_TYPE> LUT_ACCT_TYPE { get; set; }
        public virtual DbSet<LUT_AE_CATEGORY> LUT_AE_CATEGORY { get; set; }
        public virtual DbSet<LUT_CIF_TYPE> LUT_CIF_TYPE { get; set; }
        public virtual DbSet<LUT_CITY> LUT_CITY { get; set; }
        public virtual DbSet<LUT_COUNTRY> LUT_COUNTRY { get; set; }
        public virtual DbSet<LUT_GL_ACCT_CATEGORY> LUT_GL_ACCT_CATEGORY { get; set; }
        public virtual DbSet<LUT_GLLedgerNature> LUT_GLLedgerNature { get; set; }
        public virtual DbSet<LUT_OBJ_STATUS> LUT_OBJ_STATUS { get; set; }
        public virtual DbSet<LUT_TRN_STATUS> LUT_TRN_STATUS { get; set; }
        public virtual DbSet<PROC_FIXRATE_INTEREST> PROC_FIXRATE_INTEREST { get; set; }
        public virtual DbSet<SettingsModel> Settings { get; set; }
        public virtual DbSet<TRN_LEGS> TRN_LEGS { get; set; }
        public virtual DbSet<TRN_SHARE_ACCT> TRN_SHARE_ACCT { get; set; }
        public virtual DbSet<VW_DEF_GL> VW_DEF_GL { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=OpenCore;Persist Security Info=True;User ID=sa;Password=get@get1;TrustServerCertificate=True");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Arabic_CI_AS");

            modelBuilder.Entity<DEF_ACCT_CLASS>(entity =>
            {
                entity.HasKey(e => e.AccountClassID);

                entity.Property(e => e.Code)
                    .IsRequired()
                    .HasMaxLength(5);

                entity.Property(e => e.Currency).HasMaxLength(5);

                entity.Property(e => e.EFFECTIVE_DT).HasColumnType("datetime");

                entity.Property(e => e.Name).HasMaxLength(80);

                entity.Property(e => e.REFERENCE).IsRequired();

                entity.Property(e => e.Type).HasMaxLength(10);
            });

            modelBuilder.Entity<DEF_ACCT_CLASS_ACCT_STRUCT>(entity =>
            {
                entity.HasKey(e => e.AccountStructID);

                entity.Property(e => e.AccountClassCode)
                    .IsRequired()
                    .HasMaxLength(5);

                entity.Property(e => e.GLComments).HasMaxLength(80);

                entity.Property(e => e.GLNum)
                    .IsRequired()
                    .HasMaxLength(40);
            });

            modelBuilder.Entity<DEF_BusinessDate>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.BusinessDay).HasColumnType("date");

                entity.Property(e => e.ID).ValueGeneratedOnAdd();
            });

            modelBuilder.Entity<DEF_CIF>(entity =>
            {
                //BUILD_ERR : 
                //entity.Property(e => e.BIRTH_DT).HasColumnType("date");

                //entity.Property(e => e.CIF_CLASS_ID).HasMaxLength(10);

                entity.Property(e => e.CIF_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.CREATE_DT).HasColumnType("datetime");

                entity.Property(e => e.FamilyName).HasMaxLength(80);

                entity.Property(e => e.FirstName).HasMaxLength(80);

                //BUILD_ERR : 
                //entity.Property(e => e.Gender).HasMaxLength(10);

                //BUILD_ERR : 
                //entity.Property(e => e.HomeNumber).HasMaxLength(80);

                entity.Property(e => e.LAST_SAVE_DT).HasColumnType("datetime");

                entity.Property(e => e.LastName).HasMaxLength(80);

                entity.Property(e => e.MiddleName).HasMaxLength(80);

                //BUILD_ERR : 
                //entity.Property(e => e.MobileNumber).HasMaxLength(80);

                entity.Property(e => e.RSM).HasMaxLength(35);

                entity.Property(e => e.SearchKey)
                    .IsRequired()
                    .HasMaxLength(35);

                //BUILD_ERR : 
                //entity.Property(e => e.WorkNumber).HasMaxLength(80);
            });

            modelBuilder.Entity<DEF_CIF_CLASS>(entity =>
            {
                entity.HasKey(e => new { e.CIF_CLASS_ID })
                    .HasName("PK__DEF_CIF___A25C5AA6127E02BB");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(80);
            });

            // modelBuilder.Entity<DEF_CIF_Company>(entity =>
            // {
            //     entity.HasKey(e => e.DEF_CIF_Company_ID);

            //     entity.Property(e => e.CIF_NO).HasMaxLength(35);
            // });

            modelBuilder.Entity<DEF_CK_ACCT>(entity =>
            {
                entity.HasKey(e => e.DEF_ACCT_ID)
                    .HasName("PK_DEF_ACCT");

                entity.Property(e => e.ACCT_CLASS).HasMaxLength(10);

                entity.Property(e => e.ACCT_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.ACCT_TYPE)
                    .IsRequired()
                    .HasMaxLength(10);

                entity.Property(e => e.CIF_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.CSP_Code).HasMaxLength(10);

                entity.Property(e => e.Currency).HasMaxLength(3);

                entity.Property(e => e.Description).HasMaxLength(80);

                entity.Property(e => e.IBAN).HasMaxLength(35);

                entity.Property(e => e.OpenDate).HasColumnType("date");

                entity.Property(e => e.ReferenceACCT).HasMaxLength(35);

                entity.Property(e => e.ReferenceOrg).HasMaxLength(35);

                entity.Property(e => e.Title).HasMaxLength(80);
            });

            modelBuilder.Entity<DEF_CK_ACCT_ACCT_STRUCT>(entity =>
            {
                entity.HasKey(e => e.AccountStructID)
                    .HasName("PK_DEF_ACCT_ACCT_STRUCT");

                entity.Property(e => e.AccountCode)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.GLComments).HasMaxLength(80);

                entity.Property(e => e.GLNum)
                    .IsRequired()
                    .HasMaxLength(40);
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

            modelBuilder.Entity<DEF_FIXRATE_ACCT>(entity =>
            {
                entity.HasKey(e => e.DEF_ACCT_ID);

                entity.Property(e => e.ACCT_CLASS).HasMaxLength(10);

                entity.Property(e => e.ACCT_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.ACCT_TYPE)
                    .IsRequired()
                    .HasMaxLength(10);

                entity.Property(e => e.CIF_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.CSP_Code).HasMaxLength(10);

                entity.Property(e => e.CloseDate).HasColumnType("date");

                entity.Property(e => e.CreateDate).HasColumnType("date");

                entity.Property(e => e.Currency).HasMaxLength(3);

                entity.Property(e => e.Description).HasMaxLength(80);

                entity.Property(e => e.IBAN).HasMaxLength(35);

                entity.Property(e => e.OpenDate).HasColumnType("date");

                entity.Property(e => e.Principle).HasColumnType("decimal(28, 2)");

                entity.Property(e => e.Rate).HasColumnType("decimal(28, 26)");

                entity.Property(e => e.ReferenceACCT).HasMaxLength(35);

                entity.Property(e => e.ReferenceOrg).HasMaxLength(35);

                entity.Property(e => e.Title).HasMaxLength(80);
            });

            modelBuilder.Entity<DEF_FIXRATE_ACCT_DATES>(entity =>
            {
                entity.HasKey(e => e.DEF_FIXRATE_ACCT_DATES_ID);

                entity.Property(e => e.ACCT_DATE).HasColumnType("date");

                entity.Property(e => e.ACCT_NO)
                    .IsRequired()
                    .HasMaxLength(35);
            });

            modelBuilder.Entity<DEF_SHARE_ACCT>(entity =>
            {
                entity.HasKey(e => e.DEF_ACCT_ID);

                entity.Property(e => e.ACCT_AMT).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.ACCT_AVG).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.ACCT_CLASS).HasMaxLength(10);

                entity.Property(e => e.ACCT_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.ACCT_P_L).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.ACCT_QTY).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.ACCT_TYPE)
                    .IsRequired()
                    .HasMaxLength(10);

                entity.Property(e => e.CIF_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.CSP_Code).HasMaxLength(10);

                entity.Property(e => e.Currency).HasMaxLength(3);

                entity.Property(e => e.Description).HasMaxLength(80);

                entity.Property(e => e.IBAN).HasMaxLength(35);

                entity.Property(e => e.Name).HasMaxLength(80);

                entity.Property(e => e.OpenDate).HasColumnType("date");

                entity.Property(e => e.ReferenceACCT).HasMaxLength(35);

                entity.Property(e => e.ReferenceOrg).HasMaxLength(35);
            });

            modelBuilder.Entity<ExchangeRates>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.ExRateDate).HasColumnType("datetime");

                entity.Property(e => e.FromCurIsoCode)
                    .IsRequired()
                    .HasMaxLength(3)
                    .IsFixedLength(true);

                entity.Property(e => e.Rate).HasColumnType("decimal(24, 9)");

                entity.Property(e => e.TimeEXC).HasColumnType("datetime");

                entity.Property(e => e.ToCurIsoCode)
                    .IsRequired()
                    .HasMaxLength(3)
                    .IsFixedLength(true);
            });

            modelBuilder.Entity<LUT_ACCRUAL_BASIS>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(10);
            });

            modelBuilder.Entity<LUT_ACCT_TYPE>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.Description).IsRequired();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(10);
            });

            modelBuilder.Entity<LUT_AE_CATEGORY>(entity =>
            {
                entity.Property(e => e.Description).HasMaxLength(80);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(80);
            });

            modelBuilder.Entity<LUT_CIF_TYPE>(entity =>
            {
                entity.HasKey(e => e.ID)
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

            modelBuilder.Entity<LUT_GL_ACCT_CATEGORY>(entity =>
            {
                entity.Property(e => e.Description).HasMaxLength(80);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(80);
            });

            modelBuilder.Entity<LUT_GLLedgerNature>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.CR_DR)
                    .IsRequired()
                    .HasMaxLength(2)
                    .IsFixedLength(true);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
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

            modelBuilder.Entity<PROC_FIXRATE_INTEREST>(entity =>
            {
                entity.HasKey(e => e.PROC_FIXRATE_INTEREST_ID);

                entity.Property(e => e.ACCT_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.CALC_INTEREST_AMT).HasColumnType("decimal(32, 2)");

                entity.Property(e => e.CIF_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.FROM_DATE).HasColumnType("datetime");

                entity.Property(e => e.PRINCIPLE_AMT).HasColumnType("decimal(32, 2)");

                entity.Property(e => e.TO_DATE).HasColumnType("datetime");
            });

            modelBuilder.Entity<SettingsModel>(entity =>
            {
                entity.HasKey(e => e.VerID);

                entity.Property(e => e.ACCTFormat)
                    .HasMaxLength(200)
                    .IsFixedLength(true);

                entity.Property(e => e.ACCTFormatDigits)
                    .HasMaxLength(200)
                    .IsFixedLength(true);

                entity.Property(e => e.ACCTFormatDigitsNum)
                    .HasMaxLength(200)
                    .IsFixedLength(true);

                entity.Property(e => e.BaseCurrency)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsFixedLength(true);

                entity.Property(e => e.CIFFormatDigits)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsFixedLength(true);

                entity.Property(e => e.EffectiveDate).HasColumnType("date");

                entity.Property(e => e.GLFormat)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsFixedLength(true);

                entity.Property(e => e.GLFormatDigits)
                    .HasMaxLength(200)
                    .IsFixedLength(true);
            });

            modelBuilder.Entity<TRN_LEGS>(entity =>
            {
                entity.HasKey(e => e.TRN_LEGS_ID);

                entity.Property(e => e.Acct_CR_DR).HasMaxLength(2);

                entity.Property(e => e.Acct_Curr).HasMaxLength(3);

                entity.Property(e => e.Balance_After).HasColumnType("decimal(28, 3)");

                entity.Property(e => e.Balance_Before).HasColumnType("decimal(28, 3)");

                entity.Property(e => e.CREATE_DT).HasColumnType("datetime");

                entity.Property(e => e.EffDt).HasColumnType("date");

                entity.Property(e => e.Trn_Amt).HasColumnType("decimal(28, 3)");
            });

            modelBuilder.Entity<TRN_SHARE_ACCT>(entity =>
            {
                entity.HasKey(e => e.TRN_SHARE_ACCT_ID);

                entity.Property(e => e.ACCT_AMT).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.ACCT_AVG).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.ACCT_NO)
                    .IsRequired()
                    .HasMaxLength(35);

                entity.Property(e => e.ACCT_P_L).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.ACCT_QTY).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.SETTLMENT_DT).HasColumnType("datetime");

                entity.Property(e => e.TRAN_AMT).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.TRAN_DT).HasColumnType("datetime");

                entity.Property(e => e.TRAN_P_L).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.TRAN_QTY).HasColumnType("decimal(28, 8)");

                entity.Property(e => e.UNIT_PRICE).HasColumnType("decimal(28, 8)");
            });

            modelBuilder.Entity<VW_DEF_GL>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("VW_DEF_GL");

                entity.Property(e => e.BranchName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.CR_DR)
                    .HasMaxLength(2)
                    .IsFixedLength(true);

                entity.Property(e => e.CURR)
                    .IsRequired()
                    .HasMaxLength(4);

                entity.Property(e => e.CompanyName).HasMaxLength(30);

                entity.Property(e => e.DepName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.EFFECTIVE_DT).HasColumnType("datetime");

                entity.Property(e => e.GL)
                    .HasMaxLength(40)
                    .IsFixedLength(true);

                entity.Property(e => e.NatureName).HasMaxLength(30);

                entity.Property(e => e.REFERENCE).IsRequired();

                entity.Property(e => e.SectorName)
                    .IsRequired()
                    .HasMaxLength(30);

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