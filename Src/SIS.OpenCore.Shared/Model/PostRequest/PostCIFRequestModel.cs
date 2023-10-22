using System;

namespace SIS.OpenCore.Shared.Model.PostRequest
{
    public partial class PostCIFRequestModel : PostBaseRequestModel
    {
        public string CIF_NO { get; set; }
        public string SearchKey { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string FamilyName { get; set; }
        public DateTime CREATE_DT { get; set; }
        public short CLASS_ID { get; set; }
        public string RSM { get; set; }
        public string REFERENCE { get; set; }
    }
}


