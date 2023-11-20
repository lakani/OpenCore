using System;

namespace SIS.OpenCore.Shared.Model.PostRequest
{
    public class PostACCTClassRequestModel : PostBaseRequestModel
    {
        public string Name { get; set; }
        public short ACCT_TYPE { get; set; }
        public string REFERENCE { get; set; }
        public bool ExternallyManged  { get; set; }
    }
}


