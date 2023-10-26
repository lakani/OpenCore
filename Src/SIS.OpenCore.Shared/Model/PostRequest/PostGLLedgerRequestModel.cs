using System;
#nullable enable
namespace SIS.OpenCore.Shared.Model.PostRequest
{
    public class PostGLLedgerRequestModel : PostBaseRequestModel
    {
        public short CompanyNo { get; set; }
        public short? Zone { get; set; }
        public short? BranchNo { get; set; }
        public short? SectorNo { get; set; }
        public short? DepNo { get; set; }
        public short? UnitNO { get; set; }
        public short? ProductNo { get; set; }
        public short Nature { get; set; }
        public int LedgerNO { get; set; }
        
        //public string CURR { get; set; } // its not on the parent level
        public string? COMMENTS { get; set; }
        public DateTime EFFECTIVE_DT { get; set; }
        public short STATUS { get; set; }
        public string? REFERENCE { get; set; }
    }
}


