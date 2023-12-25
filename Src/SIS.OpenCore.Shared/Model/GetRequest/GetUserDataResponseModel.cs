using System;
using System.Linq;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System.Collections;
using System.Collections.Generic;

namespace SIS.OpenCore.Shared.Model.GetRequest
{
    public class GetUserDataResponseModel : BaseResponseModel
    {
        //public  BaseUserData[]  Records { get; set; }
        public  IEnumerable<BaseUserData> Records { get; set; }
    }
}


