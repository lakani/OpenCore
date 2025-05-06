using System;
using SIS.OpenCore.Shared.Model.Common;
using System.Collections.Generic;
using System.Text.Json;
using System.Runtime.InteropServices;

namespace SIS.OpenCore.Shared.Model.Transactions.Posting
{
    public partial class AccountingPosting : BaseEntity
    {
        public int GetPrimaryKey ()
        {
            return PostingId;
        }

        public required int PostingId { get; set; }
        public int? PostingLinkedId { get; set; } = 0;
        public int? TradeId { get; set; } = 0;
        public int? ProductId { get; set; } = 0;
        public string? PostingType { get; set; } = string.Empty;
        public required float Amount { get; set; }
        public string? EventType { get; set; } = string.Empty;
        public string? PostingDescription { get; set; } = string.Empty;
        public string? ProductDescription { get; set; } = string.Empty;
        public required string PostingCurrency { get; set; } = string.Empty;
        public string? ExternalDebitAccount { get; set; } = string.Empty;
        public string? DebitAccount { get; set; } = string.Empty;
        public required int DebitAccountID { get; set; } 
        public string? ExternalCreditAccount { get; set; } = string.Empty;
        public string? CreditAccount { get; set; } = string.Empty;
        public required int CreditAccountID { get; set; }
        public string? OriginalEvent { get; set; } = string.Empty;
        public string? AccountingRule { get; set; } = string.Empty;
        public short? TradeStatus { get; set; } = 0;
        public string? BookName { get; set; } = string.Empty;
        public string? AccountingBookName { get; set; } = string.Empty;

        public short? PostingChannel { get; set; } = 0; //LUT_POSTING_CHANNEL
        
        public required DateTime CreationDate { get; set; }
        public DateTime? SentDate { get; set; }
        public required DateTime EffectiveDate { get; set; }

        public string? Manual { get; set; } = string.Empty;
        public string? EnteredUser { get; set; } = string.Empty;
        public float? PostingOtherAmount { get; set; } = 0;
        public required string Status { get; set; } = string.Empty;
    }
}