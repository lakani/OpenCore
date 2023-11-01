using SIS.OpenCore.Shared.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
#nullable enable


namespace SIS.OpenCore.Shared.Model.Common
{
	public class ApplicationUser : IdentityUser, BaseEntity
	{
		public int GetPrimaryKey ()
        {
            return 1;
        }
		public DateTime CreatedOn { get; set; }
		public DateTime LastLoginDate { get; set; }

		public string? CivilNumber { get; set; }
	}
}