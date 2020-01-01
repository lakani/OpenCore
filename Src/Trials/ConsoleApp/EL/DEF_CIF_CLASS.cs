using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EL
{
    public partial class DEF_CIF_CLASS
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public int CompanyNo { get; set; }
        public DateTime? EFFECTIVE_DT { get; set; }
        public string REFERENCE { get; set; }
    }
}
