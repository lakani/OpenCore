using System;
using System.Collections.Generic;
using System.Text.Json;

#nullable disable

namespace SIS.OpenCore.Shared.Model.Common
{
    public partial class DEF_Posting : BaseEntity
    {
        public int GetPrimaryKey ()
        {
            return PostingId;
        }

        public int PostingId { get; set; }
        public int PostingLinkedId { get; set; }
        public int TradeId { get; set; }
        public int ProductId { get; set; }
        public DateTime SentDate { get; set; }
        public DateTime EffectiveDate { get; set; }
        public string PostingType { get; set; }
        public float Amount { get; set; }
        public string EventType { get; set; }
        public string PostingDescription { get; set; }
        public string ProductDescription { get; set; }
        public string PostingCurrency { get; set; }
        public string ExternalDebitAccount { get; set; }
        public string DebitAccount { get; set; }
        public string ExternalCreditAccount { get; set; }
        public string CreditAccount { get; set; }
        public string OriginalEvent { get; set; }
        public string AccountingRule { get; set; }
        public short TradeStatus { get; set; }
        public string BookName { get; set; }
        public string AccountingBookName { get; set; }
        public DateTime BookingDate { get; set; }
        public DateTime CreationDate { get; set; }
        public string Manual { get; set; }
        public string EnteredUser { get; set; }
        public float PostingOtherAmount { get; set; }
        public string PostingStatus { get; set; }
    }
}