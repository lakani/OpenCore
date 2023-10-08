using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SIS.OpenCore.Shared.Model;
using BAL = SIS.OpenCore.Server.BL;
using SIS.OpenCore.Server.BL;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SIS.OpenCore.Server.Controllers
{
	//v1/api/Identity/Anonymous/RegisterUser
	//("v1/api/OpenCore/system/Settings/UserData")]
	[Route("v1/api/OpenCore/system/Settings/Settings")]
	[ApiController]
	public class SettingsController : ControllerBase
	{
		[HttpGet]
		public SettingsModel GetLastSettings()
		{
			return BAL.Settings.GetLastVersion();
		}
	}
}
