﻿using System;
using System.Collections.Generic;

namespace SIS.OpenCore.DAL.TODO // Check the correct table attributes
{
    public partial class DEF_Currency
    {
        public short CurrencyID { get; set; }
        public string ISOCode { get; set; }
        public string Symbol { get; set; }
        public short Fractions { get; set; }
        public string Name { get; set; }
    }
}
