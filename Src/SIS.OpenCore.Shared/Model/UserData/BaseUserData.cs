using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace SIS.OpenCore.Shared.Model.UserData
{
	public partial class BaseUserData : BaseEntity
	{
		public short ID { get; set; }
		public string Name { get; set; }
	}
}
