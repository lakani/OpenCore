using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace SIS.OpenCore.Shared.Model.Common
{
	public partial class BaseLUTEntity : BaseEntity
	{
		public int GetPrimaryKey ()
        {
            return ID;
        }
		public short ID { get; set; }
		public string Name { get; set; }
	}
}
