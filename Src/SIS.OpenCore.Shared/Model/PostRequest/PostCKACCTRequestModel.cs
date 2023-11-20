using System;

namespace SIS.OpenCore.Shared.Model.PostRequest
{
    public class PostCKACCTRequestModel : PostBaseRequestModel
    {
        public string CIF_NO { get; set; }
        public short ACCT_CLASS_ID { get; set; }
        public short CompanyID { get; set; }
        public string ACCT_NO { get; set; }
        public string Currency { get; set; }
        public string Name { get; set; }
        public string REFERENCE { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string ReferenceACCT { get; set; }
        public string ReferenceOrg { get; set; }
        public string IBAN { get; set; }
        public bool ExternallyManged  { get; set; }
    }
}


