using System;
using System.Collections.Generic;
using SIS.OpenCore.Shared.Model.Common;
#nullable enable
namespace SIS.OpenCore.Shared.Model.PostRequest
{
    public class PostUserDataRequestModel : BaseRequesModel
    {
        public string? Configuration { get; set; }
        public IEnumerable<short>? ids { get; set; }
        public IEnumerable<string>? Values { get; set; }
    }
}



