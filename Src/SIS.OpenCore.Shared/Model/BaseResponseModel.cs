using System;
#nullable enable

namespace SIS.OpenCore.Shared.Model
{
    public partial class BaseResponseModel
    {
        public bool Successful { get; set; }
		public string? Error { get; set; }
		public DateTime? ServerTimeStamp { get; set; }

		public BaseResponseModel() 
		{
			ServerTimeStamp = DateTime.Now;
		}
    }
}