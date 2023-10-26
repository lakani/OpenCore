using System;
#nullable enable
namespace SIS.OpenCore.Shared.Model.PostRequest
{
    public class PostCIFClassRequestModel : PostBaseRequestModel
    {
        public string? Name { get; set; }
        public short CIF_TYPE { get; set; }
        public string? REFERENCE { get; set; }
    }
}


