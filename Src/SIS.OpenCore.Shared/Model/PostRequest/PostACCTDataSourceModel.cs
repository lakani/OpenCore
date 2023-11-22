using System;

namespace SIS.OpenCore.Shared.Model.PostRequest
{
    public class PostACCTDataSourceModel : PostBaseRequestModel
    {
        public string Name { get; set; }
        public string REFERENCE { get; set; }
        public string CONNECTIONTYPE  { get; set; }
        public string CONNECTIONSTRING  { get; set; }
        public string SERVER  { get; set; }
        public string DATABASE  { get; set; }
        public string USERNAME  { get; set; }
        public string PASSWORD  { get; set; }
        public string QUERY  { get; set; }
        public string PREVIEWQUERY  { get; set; }
    }
}