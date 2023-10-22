using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using SIS.OpenCore.Shared.Model.PostRequest;
using SIS.OpenCore.Server.Data.Repository.Interface;
using System;
using System.Collections.Generic;
//using SIS.OpenCore.DAL.TODO;
using System.Linq;
using System.Threading.Tasks;

#nullable enable

namespace SIS.OpenCore.Server.Controllers
{
	[ApiController]
	[Route("v1/api/OpenCore/system/Settings/UserData")]
	public class UserDataController : ControllerBase
	{
		private readonly ILogger<UserDataController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IUserDataRepository<DEF_Zone> _ZoneRepository;
		private readonly IUserDataRepository<DEF_Company> _CompanyRepository;
		private readonly IUserDataRepository<DEF_Branch> _BranchRepository;
		private readonly IUserDataRepository<DEF_Sector> _SectorRepository;
		private readonly IUserDataRepository<DEF_Dep> _DepRepository;
		private readonly IUserDataRepository<DEF_Unit> _UnitRepository;

		public UserDataController(
		ILogger<UserDataController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IUserDataRepository<DEF_Zone> ZoneRepository,
		IUserDataRepository<DEF_Company> CompanyRepository,
		IUserDataRepository<DEF_Branch> BranchRepository,
		IUserDataRepository<DEF_Sector> SectorRepository,
		IUserDataRepository<DEF_Dep> DepRepository,
		IUserDataRepository<DEF_Unit> UnitRepository) : base()
		{
			_logger = logger;
			_configuration = Configuration;
			_signInManager = signInManager;
			_ZoneRepository = ZoneRepository;
			_CompanyRepository = CompanyRepository;
			_BranchRepository = BranchRepository;
			_SectorRepository = SectorRepository;
			_DepRepository = DepRepository;
			_UnitRepository = UnitRepository;

			_logger.Log(LogLevel.Information, "UserDataController() : constructor");
		}


	
		public static IEnumerable<string> GetSettings()
		{
			var settingsKeys = new List<string>();

			settingsKeys.Add("Zone");
			settingsKeys.Add("Company");
			settingsKeys.Add("Branch");
			settingsKeys.Add("Sector");
			settingsKeys.Add("Dep");
			settingsKeys.Add("Unit");

			return settingsKeys;
		}

		protected IEnumerable<string> GetList(string Configuration)
		{
			IQueryable<BaseUserData> Arr = Enumerable.Empty<BaseUserData>().AsQueryable();

			switch (Configuration)
			{
				case "Zone":
					Arr = (IQueryable<BaseUserData>)_ZoneRepository.GetAll();
					break;
				case "Company":
					Arr = (IQueryable<BaseUserData>)_CompanyRepository.GetAll();
					break;
				case "Branch":
					Arr = (IQueryable<BaseUserData>)_BranchRepository.GetAll();
					break;
				case "Sector":
					Arr = (IQueryable<BaseUserData>)_SectorRepository.GetAll();
					break;
				case "Dep":
					Arr = (IQueryable<BaseUserData>)_DepRepository.GetAll();
					break;
				case "Unit":
					Arr = (IQueryable<BaseUserData>)_UnitRepository.GetAll();
					break;
			}

			if (Arr.Count() > 0)
				return Arr.Select(x => x.Name);
			else
				return Enumerable.Empty<String>().AsQueryable();
		}

		[HttpGet]
		public async Task<IEnumerable<string>> GetLastSettings(string? Configuration)
		{
			var settings = new List<string>();

			if(string.IsNullOrEmpty(Configuration))
			{
				//return await Task.Run(GetSettings());
				return GetSettings();
			}

			return GetList(Configuration);
		}
		
		[HttpPost]
		public async Task<IActionResult> Post(string Configuration, IEnumerable<string> values)
		{
			try
			{
				foreach (string st in values)
				{
					switch (Configuration)
					{
						case "Zone":
							var tmpZone = new DEF_Zone { Name = st };
							await _ZoneRepository.Create(tmpZone);
							break;
						case "Company":
							var tmpCompany = new DEF_Company { Name = st };
							await _CompanyRepository.Create(tmpCompany);
							break;
						case "Branch":
							var tmpBranch = new DEF_Branch { Name = st };
							await _BranchRepository.Create(tmpBranch);
							break;
						case "Sector":
							var tmpSector = new DEF_Sector { Name = st };
							await _SectorRepository.Create(tmpSector);
							break;
						case "Dep":
							var tmpDep = new DEF_Dep { Name = st };
							await _DepRepository.Create(tmpDep);
							break;
						case "Unit":
							var tmpUnit = new DEF_Unit { Name = st };
							await _UnitRepository.Create(tmpUnit);
							break;
					}
				}
				return Ok(new PostBaseResponseModel{ Successful=true});
			}
			catch (Exception ex) 
			{ 
				return BadRequest(new PostBaseResponseModel{ Message=ex.Message, Successful=false} );
			}
		}
	}
}
