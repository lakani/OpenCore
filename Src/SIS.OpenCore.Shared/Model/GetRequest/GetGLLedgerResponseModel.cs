using System;
using System.Linq;
using SIS.OpenCore.Shared.Model;


//namespace SIS.OpenCore.Shared.Model.PostRequest
namespace SIS.OpenCore.Shared.Model.GetRequest
{
    public class GetGLLedgerResponseModel : BaseResponseModel
    {
        public  IQueryable<DEF_GL>  Gls { get; set; }
    }
}


