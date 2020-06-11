using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EL
{
    public partial class DEF_ACCT_CLASS
    {
        public short AccountClassID { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public int? CompanyNo { get; set; }
        public string Currency { get; set; }
        public DateTime? EFFECTIVE_DT { get; set; }
        public string REFERENCE { get; set; }
    }
}
