using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EF
{
    public partial class DefCifClass
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public byte Type { get; set; }
        public short CompanyNo { get; set; }
        public DateTime? EffectiveDt { get; set; }
        public string Reference { get; set; }
    }
}
