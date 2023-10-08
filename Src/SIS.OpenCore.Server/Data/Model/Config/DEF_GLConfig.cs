using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model;

namespace SIS.OpenCore.Server.Data.Model.Config
{
    public partial class DEF_GLConfig : IEntityTypeConfiguration<DEF_GL>
    {
        public void Configure(EntityTypeBuilder<DEF_GL> builder)
        {
            builder.HasKey(e => e.GL_DEFID);
            builder.Property(p => p.GL_DEFID).IsRequired();
			builder.Property(p => p.GL_DEFID).ValueGeneratedOnAdd();
            builder.Property(p => p.CompanyNo).IsRequired();
            builder.Property(p => p.Nature).IsRequired();
            builder.Property(p => p.LedgerNO).IsRequired();
            builder.Property(e => e.GL).IsRequired();
            builder.Property(e => e.GL).HasMaxLength(80);
            builder.Property(e => e.COMMENTS).HasMaxLength(200);
            builder.Property(e => e.EFFECTIVE_DT).HasColumnType("datetime");
            builder.Property(e => e.EFFECTIVE_DT).IsRequired();
            builder.Property(e => e.STATUS).IsRequired();
            builder.Property(e => e.REFERENCE).HasMaxLength(200);
        }
    }
}

