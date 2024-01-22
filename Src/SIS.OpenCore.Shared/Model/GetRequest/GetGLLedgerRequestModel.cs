using System;
using System.Linq;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.GL;

//namespace SIS.OpenCore.Shared.Model.PostRequest
namespace SIS.OpenCore.Shared.Model.GetRequest
{
    public class GetGLLedgerRequestModel : BaseRequesModel
    {
        public short    CompanyNo { get; set; }
        public short?   Zone { get; set; }
        public short?   BranchNo { get; set; }
        public short?   SectorNo { get; set; }
        public short?   DepNo { get; set; }
        public short?   UnitNO { get; set; }
        public short?   ProductNo { get; set; }
        public short?   Nature { get; set; }
        public int?     LedgerNO { get; set; }
        public string?  GL { get; set; }
        public string?  COMMENTS { get; set; }    
        public string?  Name { get; set; } 
    }
}