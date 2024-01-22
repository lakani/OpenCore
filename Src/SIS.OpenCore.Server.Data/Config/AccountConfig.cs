﻿using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model.Objects.Account;
using SIS.OpenCore.Shared.Model.Objects.Account.CK;

namespace SIS.OpenCore.Server.Data.Config.Account
{
    public partial class  LUT_ACCT_TYPEConfig : IEntityTypeConfiguration<LUT_ACCT_TYPE>
    {
        public void Configure(EntityTypeBuilder<LUT_ACCT_TYPE> builder)
        {
            builder.HasKey(e => e.ID);
            builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);

            builder.HasData(new LUT_ACCT_TYPE{ ID = 1, Name="CK"});
        }
    }

    public partial class  CIF_ACCT_CLASSConfig : IEntityTypeConfiguration<CIF_ACCT_CLASS>
    {
        public void Configure(EntityTypeBuilder<CIF_ACCT_CLASS> builder)
        {
            builder.HasKey(e => e.ACCT_CLASS_ID);
            builder.Property(p => p.ACCT_CLASS_ID).IsRequired();
			builder.Property(p => p.ACCT_CLASS_ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(80);
            builder.Property(p => p.ACCT_TYPE).IsRequired();
            builder.Property(e => e.REFERENCE).HasMaxLength(200);

            builder 
                .HasOne( c => c.lUT_ACCT_TYPE)
                .WithMany( t => t.CIF_ACCT_CLASS)
                .HasForeignKey( c => c.ACCT_TYPE)
                .IsRequired();
        }
    }

    public partial class  ACCTDataSourceConfig : IEntityTypeConfiguration<ACCTDataSource>
    {
        public void Configure(EntityTypeBuilder<ACCTDataSource> builder)
        {
            builder.HasKey(e => e.ACCTDataSource_ID);
            builder.Property(p => p.ACCTDataSource_ID).IsRequired();
			builder.Property(p => p.ACCTDataSource_ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
            builder.Property(p => p.Name).HasMaxLength(50);

            builder.Property(p => p.REFERENCE).HasMaxLength(50);

            // TODO : determine which fields are required or not
            //builder.Property(p => p.CONNECTIONTYPE).IsRequired();
            builder.Property(p => p.CONNECTIONTYPE).HasMaxLength(80);

            //builder.Property(p => p.CONNECTIONSTRING).IsRequired();
            builder.Property(p => p.CONNECTIONSTRING).HasMaxLength(80);

            //builder.Property(p => p.SERVER).IsRequired();
            builder.Property(p => p.SERVER).HasMaxLength(80);

            //builder.Property(p => p.DATABASE).IsRequired();
            builder.Property(p => p.DATABASE).HasMaxLength(80);

            //builder.Property(p => p.USERNAME).IsRequired();
            builder.Property(p => p.USERNAME).HasMaxLength(80);

            //builder.Property(p => p.PASSWORD).IsRequired();
            builder.Property(p => p.PASSWORD).HasMaxLength(80);

            //builder.Property(p => p.QUERY).IsRequired();
            builder.Property(p => p.QUERY).HasMaxLength(360);

            //builder.Property(p => p.PREVIEWQUERY).IsRequired();
            builder.Property(p => p.PREVIEWQUERY).HasMaxLength(360);
        }
    }


    public partial class  CIF_CK_ACCTConfig : IEntityTypeConfiguration<CIF_CK_ACCT>
    {
        public void Configure(EntityTypeBuilder<CIF_CK_ACCT> builder)
        {
            builder.HasKey(e => e.DEF_ACCT_ID);
            builder.Property(p => p.DEF_ACCT_ID).IsRequired();
			builder.Property(p => p.DEF_ACCT_ID).ValueGeneratedOnAdd();
            builder.Property(p => p.CIF_NO).IsRequired();
            builder.Property(p => p.CIF_NO).HasMaxLength(50);
            builder.Property(p => p.ACCT_CLASS_ID).IsRequired();
            builder.Property(p => p.CompanyID).IsRequired();
            builder.Property(p => p.ACCT_NO).IsRequired();
            builder.Property(p => p.ACCT_NO).HasMaxLength(80);
            builder.Property(p => p.Currency).IsRequired();
            builder.Property(p => p.Currency).HasMaxLength(5);
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(80);
            //REFERENCE is optional
            builder.Property(p => p.REFERENCE).HasMaxLength(80);
            //Title is optional
            builder.Property(p => p.Title).HasMaxLength(80);
            //Description is optional
            builder.Property(p => p.Description).HasMaxLength(80);
            //ReferenceACCT  is optional
            builder.Property(p => p.ReferenceACCT).HasMaxLength(80);
            //ReferenceOrg  is optional
            builder.Property(p => p.ReferenceOrg).HasMaxLength(80);
            //IBAN   is optional
            builder.Property(p => p.IBAN).HasMaxLength(80);
            //OpenDate      
            builder.Property(p => p.OpenDate).HasColumnType("datetime");      

        }
    }

    
}
