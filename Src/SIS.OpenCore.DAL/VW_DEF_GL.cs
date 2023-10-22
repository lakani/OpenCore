using System;
using System.Collections.Generic;

namespace SIS.OpenCore.DAL.TODO // Check the correct table attributes
{
    public partial class VW_DEF_GL
    {
        public string GL { get; set; }
        public short Zone { get; set; }
        public string ZoneName { get; set; }
        public short CompanyNo { get; set; }
        public string CompanyName { get; set; }
        public short BranchNo { get; set; }
        public string BranchName { get; set; }
        public short SectorNo { get; set; }
        public string SectorName { get; set; }
        public short DepNo { get; set; }
        public string DepName { get; set; }
        public short UnitNO { get; set; }
        public string UnitName { get; set; }
        public short Nature { get; set; }
        public string NatureName { get; set; }
        public string CR_DR { get; set; }
        public string LedgerNO { get; set; }
        public string CURR { get; set; }
        public DateTime EFFECTIVE_DT { get; set; }
        public string TotallingGL { get; set; }
        public string REFERENCE { get; set; }
    }
}
