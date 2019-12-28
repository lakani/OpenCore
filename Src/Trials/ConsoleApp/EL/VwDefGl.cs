using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EF
{
    public partial class VwDefGl
    {
        public string Gl { get; set; }
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
        public byte UnitNo { get; set; }
        public string UnitName { get; set; }
        public byte Nature { get; set; }
        public string NatureName { get; set; }
        public string CrDr { get; set; }
        public byte PostingLevel { get; set; }
        public string LedgerNo { get; set; }
        public string Curr { get; set; }
        public DateTime? EffectiveDt { get; set; }
        public string TotallingGl { get; set; }
        public string Reference { get; set; }
    }
}
