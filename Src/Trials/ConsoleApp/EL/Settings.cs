using System;
using System.Collections.Generic;

namespace ConsoleApp.EF
{
    public partial class Settings
    {
        public int VerId { get; set; }
        public DateTime? EffectiveDate { get; set; }
        public string Glformat { get; set; }
        public string GlformatDigits { get; set; }
        public string BaseCurrency { get; set; }
        public string AcctformatDigits { get; set; }
        public string AcctformatDigitsNum { get; set; }
        public string Acctformat { get; set; }
        public string CifformatDigits { get; set; }
    }
}
