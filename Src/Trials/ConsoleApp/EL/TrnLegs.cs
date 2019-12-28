using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EF
{
    public partial class TrnLegs
    {
        public Guid? Ref { get; set; }
        public short? Sequence { get; set; }
        public string AcctCrDr { get; set; }
        public string AcctNo { get; set; }
        public bool? Gl { get; set; }
        public decimal? BalanceBefore { get; set; }
        public decimal? AcctAmt { get; set; }
        public decimal? BalanceAfter { get; set; }
        public string AcctCurr { get; set; }
        public DateTime? EffDt { get; set; }
        public DateTime? CreateDt { get; set; }
        public short? EmpId { get; set; }
        public byte? StatusId { get; set; }
        public short? ChannelId { get; set; }
        public string AcctDescription { get; set; }
    }
}
