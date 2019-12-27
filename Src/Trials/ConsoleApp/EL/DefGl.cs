using System;
using System.Collections.Generic;

namespace ConsoleApp.EF
{
    public partial class DefGl
    {
        public byte Zone { get; set; }
        public short CompanyNo { get; set; }
        public short BranchNo { get; set; }
        public byte SectorNo { get; set; }
        public byte DepNo { get; set; }
        public byte UnitNo { get; set; }
        public byte Nature { get; set; }
        public byte PostingLevel { get; set; }
        public string LedgerNo { get; set; }
        public string Curr { get; set; }
        public string TotallingGl { get; set; }
        public string Comments { get; set; }
        public DateTime EffectiveDt { get; set; }
        public byte Status { get; set; }
        public string Reference { get; set; }
    }
}
