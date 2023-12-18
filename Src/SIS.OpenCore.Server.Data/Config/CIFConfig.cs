using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model.Objects.CIF;



namespace SIS.OpenCore.Server.Data.Config.CIF
{
    public partial class CIF_CLASSConfig : IEntityTypeConfiguration<CIF_CLASS>
    {
        public void Configure(EntityTypeBuilder<CIF_CLASS> builder)
        {
            builder.HasKey(e => e.CIF_CLASS_ID);
            builder.Property(p => p.CIF_CLASS_ID).IsRequired();
			builder.Property(p => p.CIF_CLASS_ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(80);
            builder.Property(p => p.CIF_TYPE).IsRequired();
            builder.Property(e => e.REFERENCE).HasMaxLength(200);

            builder 
                .HasOne( c => c.lUT_CIF_TYPE)
                .WithMany( t => t.CIF_CLASS)
                .HasForeignKey( c => c.CIF_TYPE)
                .IsRequired();
        }

    }
    
    public partial class CIF_PERSONALConfig : IEntityTypeConfiguration<CIF_PERSONAL>
    {
        public void Configure(EntityTypeBuilder<CIF_PERSONAL> builder)
        {
            builder.HasKey(e => e.CIF_PERSONALID);
            builder.Property(e => e.CIF_PERSONALID).IsRequired();
            builder.Property(e => e.CIF_PERSONALID).ValueGeneratedOnAdd();
            builder.Property(p => p.Gender).IsRequired();
            builder.Property(p => p.Address).HasMaxLength(80);
            builder.Property(p => p.BIRTH_DT).HasColumnType("datetime");
            builder.Property(e => e.MobileNumber).HasMaxLength(50);
            builder.Property(e => e.HomeNumber).HasMaxLength(50);
            builder.Property(e => e.WorkNumber).HasMaxLength(50);
            builder.Property(e => e.NationalID).HasMaxLength(50);
            builder.Property(e => e.CIF_ID).IsRequired();
        }
    }

    public partial class CIF_DESCConfig : IEntityTypeConfiguration<CIF_DESC>
    {
        public void Configure(EntityTypeBuilder<CIF_DESC> builder)
        {
            // TODO : check the generated tables against the Backup database
            builder.HasKey(e => e.CIF_ID);
            builder.Property(p => p.CIF_ID).IsRequired();
			builder.Property(p => p.CIF_ID).ValueGeneratedOnAdd();
            builder.Property(p => p.CIF_NO).IsRequired();
			builder.Property(p => p.CIF_NO).HasMaxLength(50);
            builder.Property(p => p.SearchKey).IsRequired();
			builder.Property(p => p.SearchKey).HasMaxLength(50);
            builder.Property(p => p.FirstName).IsRequired();
			builder.Property(p => p.FirstName).HasMaxLength(80);
            builder.Property(e => e.MiddleName).HasMaxLength(80);
            builder.Property(p => p.FamilyName).HasMaxLength(80);
            builder.Property(p => p.LastName).HasMaxLength(80);
            builder.Property(p => p.CREATE_DT).IsRequired();
			builder.Property(p => p.CREATE_DT).HasColumnType("datetime");
            builder.Property(p => p.CLASS_ID).IsRequired();
            builder.Property(p => p.LAST_SAVE_DT).HasColumnType("datetime");
            builder.Property(e => e.RSM).HasMaxLength(35);
            builder.Property(e => e.REFERENCE).HasMaxLength(200);

            // one to one for the CIF_PERSONAL table
            builder
                .HasOne( c => c.PERSONAL)
                .WithOne(ad => ad.CIF_DESC)
                .HasForeignKey<CIF_PERSONAL>(ad => ad.CIF_ID)
                .IsRequired();

            // one to Many for the CIF_CLASS table
            builder
                .HasOne( c => c.CIF_CLASS)
                .WithMany(t => t.CIF_DESC)
                .HasForeignKey(c => c.CLASS_ID)
                .IsRequired();

        }
    }

    public partial class LUT_CIF_TYPEConfig : IEntityTypeConfiguration<LUT_CIF_TYPE>
    {
        public void Configure(EntityTypeBuilder<LUT_CIF_TYPE> builder)
        {
            builder.HasKey(e => e.ID);
            builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);

            builder.HasData(new LUT_CIF_TYPE{ ID = 1, Name="Personal"});
            builder.HasData(new LUT_CIF_TYPE{ ID = 2, Name="Non Personal"});
        }
    }
}

