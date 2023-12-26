using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model.Objects.Product;


namespace SIS.OpenCore.Server.Data.Config
{
	public partial class LUT_PRODUCT_LOBConfig : IEntityTypeConfiguration<LUT_PRODUCT_LOB>
    {
        public void Configure(EntityTypeBuilder<LUT_PRODUCT_LOB> builder)
        {
            builder.HasKey(e => e.ID);
            builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);

            builder.HasData(new LUT_PRODUCT_LOB{ ID = 1, Name="Banking"});
        }
    }

   	public partial class LUT_PRODUCT_CHANNELConfig : IEntityTypeConfiguration<LUT_PRODUCT_CHANNEL>
    {
        public void Configure(EntityTypeBuilder<LUT_PRODUCT_CHANNEL> builder)
        {
            builder.HasKey(e => e.ID);
            builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);

            builder.HasData(new LUT_PRODUCT_CHANNEL{ ID = 1, Name="TRSDEALER"});
        }
    }

    public partial class LUT_PRODUCT_FAMILYConfig : IEntityTypeConfiguration<LUT_PRODUCT_FAMILY>
    {
        public void Configure(EntityTypeBuilder<LUT_PRODUCT_FAMILY> builder)
        {
            builder.HasKey(e => e.ID);
            builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);

            builder.HasData(new LUT_PRODUCT_FAMILY{ ID = 1, Name="Treasury"});
        }
    }

    public partial class PRODUCT_CLASSConfig : IEntityTypeConfiguration<PRODUCT_CLASS>
    {
        public void Configure(EntityTypeBuilder<PRODUCT_CLASS> builder)
        {
            builder.HasKey(e => e.ID);
            builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
            builder.Property(p => p.PRODUCT_TYPE).IsRequired();
            builder.Property(p => p.CURRENCY).HasMaxLength(5);
            builder.Property(p => p.PRODUCT_FAMILY).IsRequired();
            builder.Property(p => p.PRODUCT_SUB_TYPE).IsRequired();
            builder.Property(p => p.PRODUCT_CHANNEL).IsRequired();
            builder.Property(p => p.DESCRIPTION).HasMaxLength(80);

        }
    }

    public partial class PRODUCT_TYPEConfig : IEntityTypeConfiguration<PRODUCT_TYPE>
    {
        public void Configure(EntityTypeBuilder<PRODUCT_TYPE> builder)
        {
            builder.HasKey(e => e.ID);
            builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
            builder.Property(p => p.PRODUCT_FAMILY).IsRequired();
            builder.Property(p => p.PRODUCT_CHANNEL).IsRequired();
            builder.Property(p => p.DESCRIPTION).HasMaxLength(80);
        }
    }

    public partial class PRODUCT_SUB_TYPEConfig : IEntityTypeConfiguration<PRODUCT_SUB_TYPE>
    {
        public void Configure(EntityTypeBuilder<PRODUCT_SUB_TYPE> builder)
        {
            //PRODUCT_SUB_TYPE (ID, NAME, PRODUCT_TYPE, PRODUCT_FAMILY, PRODUCT_CHANNEL , DESCRIPTION )
            builder.HasKey(e => e.ID);
            builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
            builder.Property(p => p.PRODUCT_TYPE).IsRequired();
            builder.Property(p => p.PRODUCT_FAMILY).IsRequired();
            builder.Property(p => p.PRODUCT_CHANNEL).IsRequired();
            builder.Property(p => p.DESCRIPTION).HasMaxLength(80);
        }
    }


    public partial class PRODUCT_DESCConfig : IEntityTypeConfiguration<PRODUCT_DESC>
    {
        public void Configure(EntityTypeBuilder<PRODUCT_DESC> builder)
        {
            //PRODUCT_DESC (ID, NAME, PRODUCT_TYPE, PRODUCT_CLASS, CURRENCY, PRODUCT_FAMILY, PRODUCT_SUB_TYPE, PRODUCT_CHANNEL , DESCRIPTION )
            builder.HasKey(e => e.ID);
            builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
            builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
            builder.Property(p => p.PRODUCT_TYPE).IsRequired();
            builder.Property(p => p.PRODUCT_CLASS).IsRequired();
            builder.Property(p => p.CURRENCY).HasMaxLength(5);
            builder.Property(p => p.PRODUCT_FAMILY).IsRequired();
            builder.Property(p => p.PRODUCT_SUB_TYPE).IsRequired();
            builder.Property(p => p.PRODUCT_CHANNEL).IsRequired();
            builder.Property(p => p.DESCRIPTION).HasMaxLength(80);
        }
    }

    
}
