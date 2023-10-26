using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model.Objects.Account;

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

    public partial class  DEF_ACCT_CLASSConfig : IEntityTypeConfiguration<DEF_ACCT_CLASS>
    {
        public void Configure(EntityTypeBuilder<DEF_ACCT_CLASS> builder)
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
                .WithMany( t => t.DEF_ACCT_CLASS)
                .HasForeignKey( c => c.ACCT_TYPE)
                .IsRequired();
        }
    }

    
}

