using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EL
{
    public partial class VW_DEF_GL
    {
        public string GL { get; set; }
        public int Zone { get; set; }
        public string ZoneName { get; set; }
        public int CompanyNo { get; set; }
        public string CompanyName { get; set; }
        public int BranchNo { get; set; }
        public string BranchName { get; set; }
        public int SectorNo { get; set; }
        public string SectorName { get; set; }
        public int DepNo { get; set; }
        public string DepName { get; set; }
        public int UnitNO { get; set; }
        public string UnitName { get; set; }
        public int Nature { get; set; }
        public string NatureName { get; set; }
        public string CR_DR { get; set; }
        public int PostingLevel { get; set; }
        public string LedgerNO { get; set; }
        public string CURR { get; set; }
        public DateTime? EFFECTIVE_DT { get; set; }
        public string REFERENCE { get; set; }
    }
}
