﻿using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EL
{
    public partial class DEF_ACCT_CLASS
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public short? CompanyNo { get; set; }
        public DateTime? EFFECTIVE_DT { get; set; }
        public string REFERENCE { get; set; }
    }
}
