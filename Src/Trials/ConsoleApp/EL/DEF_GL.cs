using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EL
{
    public partial class DEF_GL
    {
        public byte Zone { get; set; }
        public short CompanyNo { get; set; }
        public short BranchNo { get; set; }
        public byte SectorNo { get; set; }
        public byte DepNo { get; set; }
        public byte UnitNO { get; set; }
        public byte Nature { get; set; }
        public byte PostingLevel { get; set; }
        public string LedgerNO { get; set; }
        public string CURR { get; set; }
        public string TotallingGL { get; set; }
        public string COMMENTS { get; set; }
        public DateTime EFFECTIVE_DT { get; set; }
        public byte STATUS { get; set; }
        public string REFERENCE { get; set; }
    }
}
