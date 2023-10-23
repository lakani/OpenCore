using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Server.Data.Config.Common
{
    public partial class  ExchangeRatesConfig : IEntityTypeConfiguration<ExchangeRates>
    {
        public void Configure(EntityTypeBuilder<ExchangeRates> builder)
        {
            builder.HasKey(e => e.ExchangeRateID);
            builder.Property(p => p.ExchangeRateID).IsRequired();
			builder.Property(p => p.ExchangeRateID).ValueGeneratedOnAdd();
            builder.Property(p => p.FromCurrency).IsRequired();
			builder.Property(p => p.FromCurrency).HasMaxLength(5);
            builder.Property(p => p.ToCurrency).IsRequired();
			builder.Property(p => p.ToCurrency).HasMaxLength(5);
            builder.Property(p => p.Rate).IsRequired();
            builder.Property(p => p.EffectiveDate).IsRequired();
			builder.Property(p => p.EffectiveDate).HasColumnType("datetime");
        }

    }
}
