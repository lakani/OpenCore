using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EL
{
    public partial class Settings
    {
        public int VerID { get; set; }
        public DateTime? EffectiveDate { get; set; }
        public string GLFormat { get; set; }
        public string GLFormatDigits { get; set; }
        public string BaseCurrency { get; set; }
        public string ACCTFormatDigits { get; set; }
        public string ACCTFormatDigitsNum { get; set; }
        public string ACCTFormat { get; set; }
        public string CIFFormatDigits { get; set; }
    }
}
