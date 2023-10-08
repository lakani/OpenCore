using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
#nullable enable

namespace SIS.OpenCore.Shared.Model
{
	public partial class BaseRequesModel
	{
		public BaseRequesModel()
		{
			ClientTimeStamp = DateTime.Now;
			ClientVersion = "1";
			ResponseMaxRecords = 20;
		}
		public DateTime? ClientTimeStamp { get; set; }
		public string? ClientVersion { get; set; }
		public ushort ResponseMaxRecords { get; set; }
	}
}
