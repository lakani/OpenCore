using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.Account;
using SIS.OpenCore.Shared.Model.Objects.Account.CK;

namespace SIS.OpenCore.Server.Data.Config.Common
{
    public partial class  AccountingPostingConfig : IEntityTypeConfiguration<AccountingPosting>
    {
        public void Configure(EntityTypeBuilder<AccountingPosting> builder)
        {
            builder.HasKey(e => e.PostingId);
            builder.Property(p => p.PostingId).IsRequired();
			builder.Property(p => p.PostingId).ValueGeneratedOnAdd();
            
            builder.Property(p => p.SentDate).IsRequired();
            builder.Property(p => p.SentDate).HasColumnType("datetime");
            builder.Property(p => p.EffectiveDate).IsRequired();
            builder.Property(p => p.EffectiveDate).HasColumnType("datetime");
            builder.Property(p => p.PostingType).HasMaxLength(20);
            builder.Property(p => p.Amount).IsRequired();
            builder.Property(p => p.EventType).HasMaxLength(20);
            builder.Property(p => p.PostingDescription).IsRequired();
			builder.Property(p => p.PostingDescription).HasMaxLength(80);
            builder.Property(p => p.ProductDescription).HasMaxLength(30);
            builder.Property(p => p.PostingCurrency).HasMaxLength(5);
            builder.Property(p => p.ExternalDebitAccount).HasMaxLength(30);
            builder.Property(p => p.DebitAccount).HasMaxLength(30);
            builder.Property(p => p.ExternalCreditAccount).HasMaxLength(30);
            builder.Property(p => p.CreditAccount).HasMaxLength(30);
            builder.Property(p => p.OriginalEvent).HasMaxLength(20);
            builder.Property(p => p.AccountingRule).HasMaxLength(30);
            builder.Property(p => p.BookName).HasMaxLength(30);
            builder.Property(p => p.AccountingBookName).HasMaxLength(30);
            builder.Property(p => p.BookingDate).IsRequired();
            builder.Property(p => p.BookingDate).HasColumnType("datetime");
            builder.Property(p => p.CreationDate).IsRequired();
            builder.Property(p => p.CreationDate).HasColumnType("datetime");
            builder.Property(p => p.Manual).HasMaxLength(30);
            builder.Property(p => p.EnteredUser).HasMaxLength(30);
            builder.Property(p => p.PostingStatus).HasMaxLength(30);

           
        }
    }
}

