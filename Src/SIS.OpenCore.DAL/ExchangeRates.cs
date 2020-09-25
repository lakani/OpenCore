using System;
using System.Collections.Generic;

namespace SIS.OpenCore.DAL.TODO // Check the correct table attributes
{
    public partial class ExchangeRates
    {
        public string FromCurIsoCode { get; set; }
        public string ToCurIsoCode { get; set; }
        public decimal? Rate { get; set; }
        public DateTime? ExRateDate { get; set; }
        public DateTime? TimeEXC { get; set; }
    }
}
