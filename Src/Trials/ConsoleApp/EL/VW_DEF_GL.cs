using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EL
{
    public partial class VW_DEF_GL
    {
        public string GL { get; set; }
        public byte Zone { get; set; }
        public string ZoneName { get; set; }
        public short CompanyNo { get; set; }
        public string CompanyName { get; set; }
        public short BranchNo { get; set; }
        public string BranchName { get; set; }
        public byte SectorNo { get; set; }
        public string SectorName { get; set; }
        public byte DepNo { get; set; }
        public string DepName { get; set; }
        public byte UnitNO { get; set; }
        public string UnitName { get; set; }
        public byte Nature { get; set; }
        public string NatureName { get; set; }
        public string CR_DR { get; set; }
        public byte PostingLevel { get; set; }
        public string LedgerNO { get; set; }
        public string CURR { get; set; }
        public DateTime EFFECTIVE_DT { get; set; }
        public string TotallingGL { get; set; }
        public string REFERENCE { get; set; }
    }
}
