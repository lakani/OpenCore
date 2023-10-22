using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.Shared.Model.Common;


namespace SIS.OpenCore.Shared.Model.Objects.UserData
{
	public partial class BaseUserData : BaseEntity
	{
		public short ID { get; set; }
		public string Name { get; set; }
	}
}
