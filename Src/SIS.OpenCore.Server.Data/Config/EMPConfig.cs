using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model.Objects.Common;


namespace SIS.OpenCore.Server.Data.Config.Common
{
    public partial class EMPConfig  : IEntityTypeConfiguration<EMP>
    {
        public void Configure(EntityTypeBuilder<EMP> builder)
        {
            builder.HasKey(e => e.EMP_ID);
            builder.Property(p => p.EMP_ID).IsRequired();
            builder.Property(p => p.EMP_ID).ValueGeneratedOnAdd();

            // builder.HasKey(e => e.CurrencyID);
            // builder.Property(p => p.ISOCode).IsRequired();
			// builder.Property(p => p.ISOCode).HasMaxLength(5);
            // builder.Property(p => p.Symbol).HasMaxLength(5);
            // builder.Property(p => p.Fractions).IsRequired();
            // builder.Property(p => p.Name).IsRequired();
			// builder.Property(p => p.Name).HasMaxLength(50);

            // builder.HasData(new Currency{ CurrencyID = 1, Fractions = 2, ISOCode = "EGP", Name="Egyptian Pound"});
            // builder.HasData(new Currency{ CurrencyID = 2, Fractions = 2, ISOCode = "USD", Name="US Dollar"});
            // builder.HasData(new Currency{ CurrencyID = 3, Fractions = 2, ISOCode = "SAR", Name="Saudi Riyal "});
        }

    }
}
