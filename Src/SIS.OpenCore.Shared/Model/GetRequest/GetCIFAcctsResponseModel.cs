using System;
using System.Linq;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.Account;
using SIS.OpenCore.Shared.Model.Objects.Account.CK;


//namespace SIS.OpenCore.Shared.Model.PostRequest
namespace SIS.OpenCore.Shared.Model.GetRequest
{
    public class GetCIFAcctsResponseModel : BaseResponseModel
    {
        public  IQueryable<BaseCIFACCT>  Gls { get; set; }
    }
}


