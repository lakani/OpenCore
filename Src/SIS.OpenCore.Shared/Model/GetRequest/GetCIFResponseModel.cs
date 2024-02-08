using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.CIF;

namespace SIS.OpenCore.Shared.Model.GetRequest
{
    public class GetCIFResponseModel : BaseResponseModel
    {
        public  IEnumerable<CIF_DESC>?  CIFArr { get; set; }
    }
}
