using System;
#nullable enable

namespace SIS.OpenCore.Shared.Model.Common
{
    public partial class BaseResponseModel
    {
        public bool Successful { get; set; }
		public string? Message { get; set; }
		public DateTime? ServerTimeStamp { get; set; }
		public int? Record { get; set; }

		public BaseResponseModel() 
		{
			ServerTimeStamp = DateTime.Now;
		}
    }
}