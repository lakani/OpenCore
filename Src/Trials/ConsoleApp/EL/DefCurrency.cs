using System;
using System.Collections.Generic;

namespace ConsoleApp.EF
{
    public partial class DefCurrency
    {
        public short CurrencyId { get; set; }
        public string Isocode { get; set; }
        public string Symbol { get; set; }
        public short Fractions { get; set; }
        public string Name { get; set; }
    }
}
