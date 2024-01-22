using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.GL;

//namespace SIS.OpenCore.Shared.Model.PostRequest
namespace SIS.OpenCore.Shared.Model.GetRequest
{
    public class GetGLLedgerResponseModel : BaseResponseModel
    {
        public  IEnumerable<GL_ACCT>  Gls { get; set; }
    }
}


