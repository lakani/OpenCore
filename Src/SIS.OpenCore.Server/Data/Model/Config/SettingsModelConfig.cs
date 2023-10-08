using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model;

namespace SIS.OpenCore.Server.Data.Model.Config
{
    public partial class SettingsModelConfig : IEntityTypeConfiguration<SettingsModel>
    {
        public void Configure(EntityTypeBuilder<SettingsModel> builder)
        {
            builder.HasKey(e => e.VerID);
            builder.Property(p => p.VerID).IsRequired();
			builder.Property(p => p.VerID).ValueGeneratedOnAdd();
            
            builder.Property(p => p.EffectiveDate).IsRequired();
            builder.Property(p => p.EffectiveDate).HasColumnType("datetime");

            builder.Property(p => p.GLFormat).IsRequired();
            builder.Property(p => p.GLFormat).HasMaxLength(200);
            
            builder.Property(e => e.GLFormatDigits).IsRequired();
            builder.Property(e => e.GLFormatDigits).HasMaxLength(200);
            
            builder.Property(e => e.BaseCurrency).IsRequired();
            builder.Property(e => e.BaseCurrency).HasMaxLength(5);
            
            builder.Property(e => e.ACCTFormatDigits).IsRequired();
            builder.Property(e => e.ACCTFormatDigits).HasMaxLength(200);
            
            builder.Property(e => e.ACCTFormatDigitsNum).IsRequired();
            builder.Property(e => e.ACCTFormatDigitsNum).HasMaxLength(200);

            builder.Property(e => e.ACCTFormat).IsRequired();
            builder.Property(e => e.ACCTFormat).HasMaxLength(200);

            builder.Property(e => e.CIFFormatDigits).IsRequired();
            builder.Property(e => e.CIFFormatDigits).HasMaxLength(200);
        }
    }
}


