using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Objects.GL;
using SIS.OpenCore.Shared.Model.Objects.UserData;

namespace SIS.OpenCore.Server.Data.Config
{

    public partial class LUT_GLLedgerNatureConfig : IEntityTypeConfiguration<LUT_GLLedgerNature>
    {
        public void Configure(EntityTypeBuilder<LUT_GLLedgerNature> builder)
        {
            builder.HasKey(p => new { p.ID });
			builder.Property(p => p.ID).IsRequired();
			builder.Property(p => p.ID).ValueGeneratedOnAdd();
			builder.Property(p => p.Name).IsRequired();
			builder.Property(p => p.Name).HasMaxLength(50);
            builder.Property(p => p.CR_DR).IsRequired();
			builder.Property(p => p.CR_DR).HasMaxLength(3);

            builder.HasData(new LUT_GLLedgerNature { ID = 1,   Name = "Asset",      CR_DR = "DR" });
            builder.HasData(new LUT_GLLedgerNature { ID = 2,   Name = "Liability",  CR_DR = "CR" });
            builder.HasData(new LUT_GLLedgerNature { ID = 3,   Name = "Income",     CR_DR = "CR" });
            builder.HasData(new LUT_GLLedgerNature { ID = 4,   Name = "Expense",    CR_DR = "DR" });
            builder.HasData(new LUT_GLLedgerNature { ID = 5,   Name = "Capital",    CR_DR = "CR" });

        }
    }

    public partial class GL_ACCTConfig : IEntityTypeConfiguration<GL_ACCT>
    {
        public void Configure(EntityTypeBuilder<GL_ACCT> builder)
        {
            builder.HasKey(e => e.GL_DEFID);
            builder.Property(p => p.GL_DEFID).IsRequired();
			builder.Property(p => p.GL_DEFID).ValueGeneratedOnAdd();
            builder.Property(p => p.CompanyNo).IsRequired();
            builder.Property(p => p.Nature).IsRequired();
            builder.Property(p => p.LedgerNO).IsRequired();
            builder.Property(e => e.GL).IsRequired();
            builder.Property(e => e.GL).HasMaxLength(80);
            builder.Property(e => e.Name).HasMaxLength(80);
            builder.Property(e => e.Name).IsRequired(false);
            builder.Property(e => e.COMMENTS).HasMaxLength(200);
            builder.Property(e => e.EFFECTIVE_DT).HasColumnType("datetime");
            builder.Property(e => e.EFFECTIVE_DT).IsRequired();
            builder.Property(e => e.STATUS).IsRequired();
            builder.Property(e => e.REFERENCE).HasMaxLength(200);

            builder.HasOne<Company>(s => s.CompanyObj)
                .WithMany()
                .HasForeignKey(r => r.CompanyNo);

            builder.HasOne<Zone>(s => s.ZoneObj)
                .WithMany()
                .HasForeignKey(r => r.Zone);
                
            builder.Property(e => e.BranchNo).IsRequired(false);
            builder
                .HasOne<Branch>(s => s.BranchObj)
                .WithMany()
                .HasForeignKey(r => r.BranchNo);

            builder.HasOne<Sector>(s => s.SectorObj)
                .WithMany()
                .HasForeignKey(r => r.SectorNo);

            builder.Property(e => e.DepNo).IsRequired(false);
            builder.HasOne<Dep>(s => s.DepObj)
                .WithMany()
                .HasForeignKey(r => r.DepNo);

            builder.HasOne<LUT_GLLedgerNature>(s => s.NatureObj)
                .WithMany()
                .HasForeignKey(r => r.Nature);
        }
    }
}

