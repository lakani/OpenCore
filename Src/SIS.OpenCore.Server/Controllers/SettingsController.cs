using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Server.BL;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Identity;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Server.Data.Repository.Interface;
using System;

namespace SIS.OpenCore.Server.Controllers
{
	//v1/api/Identity/Anonymous/RegisterUser
	//("v1/api/OpenCore/system/Settings/UserData")]
	[Route("v1/api/OpenCore/system/Settings/Settings")]
	[ApiController]
	public class SettingsController : ControllerBase
	{
		private readonly ILogger<SettingsController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly ISettingsRepository<SettingsModel> _SettingsRepository;

		public SettingsController(
		ILogger<SettingsController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		ISettingsRepository<SettingsModel> SettingsRepository) : base()
		{
			_logger = logger;
			_configuration = Configuration;
			_signInManager = signInManager;
			_SettingsRepository = SettingsRepository;

			_logger.Log(LogLevel.Information, "SettingsController() : constructor");
		}

		[HttpGet]
		public ActionResult<SettingsModel>  GetLastSettings()
		{
			try{
				_logger.LogInformation("GetLastSettings() --> Begin");
				var Ret = _SettingsRepository.Search(new BaseRequesModel()).First();

				//Settings.InitServices(_logger, _configuration, _SettingsRepository);
				//return Settings.GetLastVersion();
				_logger.LogInformation("GetLastSettings() --> End");
				return Ok(Ret);
			}
			catch(Exception ex) {
				_logger.LogError("SettingsController -> GetLastSettings()");
				_logger.LogError(ex.Message);
				if(ex.InnerException != null)
					_logger.LogError(ex.InnerException.Message);
				return BadRequest(new BaseResponseModel{ Message=ex.Message, Successful=false});
			}
			
		}
	}
}
