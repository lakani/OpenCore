using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using SIS.OpenCore.Shared.Model.PostRequest;
using SIS.OpenCore.Server.Data.Repository.Interface;
using System;
using System.Collections.Generic;
using SIS.OpenCore.Shared.Model.GetRequest;
//using SIS.OpenCore.Server.Data.TODO;
using System.Linq;
using System.Threading.Tasks;

#nullable enable

namespace SIS.OpenCore.Server.Controllers
{
	[ApiController]
	[Route("v1/api/OpenCore/system/Settings/[controller]")]
	public partial class UserDataController : ControllerBase
	{
		private readonly ILogger<UserDataController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IUserDataRepository<Zone> _ZoneRepository;
		private readonly IUserDataRepository<Company > _CompanyRepository;
		private readonly IUserDataRepository<Branch> _BranchRepository;
		private readonly IUserDataRepository<Sector> _SectorRepository;
		private readonly IUserDataRepository<Dep> _DepRepository;
		private readonly IUserDataRepository<Unit> _UnitRepository;

		public UserDataController(
		ILogger<UserDataController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IUserDataRepository<Zone> ZoneRepository,
		IUserDataRepository<Company > CompanyRepository,
		IUserDataRepository<Branch> BranchRepository,
		IUserDataRepository<Sector> SectorRepository,
		IUserDataRepository<Dep> DepRepository,
		IUserDataRepository<Unit> UnitRepository) : base()
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

		protected IQueryable<BaseUserData> GetList(string Configuration)
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
			{
				return Arr;
			}
			else
				return Enumerable.Empty<BaseUserData>().AsQueryable();
		}

        [HttpGet]
        public ActionResult<GetUserDataResponseModel> GetLastSettings(string? Configuration)
        {
            if (string.IsNullOrEmpty(Configuration))
            {
                //return await Task.Run(GetSettings());
                return Ok(GetSettings());
            }

			var reponse = new  GetUserDataResponseModel();
			reponse.Records = GetList(Configuration);
			reponse.Successful = true;

            return Ok(reponse);
        }

		protected async Task<int> AddorUpdate(string Configuration,  short Recordid, string value)
		{
			int newID = Recordid;
			switch (Configuration)
			{
				case "Zone":
					if(Recordid == 0) // new : to insert
					{
						var tmpZone = new Zone { Name = value };
						newID = await _ZoneRepository.Create(tmpZone);
					}
					else // update
					{
						var tmpZone = new Zone { Name = value, ID = Recordid };
						await _ZoneRepository.Update(Recordid, tmpZone);
					}
					break;
				case "Company":
					if(Recordid == 0) // new : to insert
					{
						var tmpCompany = new Company { Name = value };
						newID = await _CompanyRepository.Create(tmpCompany);
					}
					else // update
					{
						var tmpCompany = new Company { Name = value, ID = Recordid };
						await _CompanyRepository.Update(Recordid, tmpCompany);
					}
					break;
				case "Branch":
					if(Recordid == 0) // new : to insert
					{
						var tmpBranch = new Branch { Name = value };
						newID = await _BranchRepository.Create(tmpBranch);
					}
					else // update
					{
						var tmpBranch = new Branch { Name = value, ID = Recordid };
						await _BranchRepository.Update(Recordid, tmpBranch);
					}
					break;
				case "Sector":
					if(Recordid == 0) // new : to insert
					{
						var tmpSector = new Sector { Name = value };
						newID = await _SectorRepository.Create(tmpSector);
					}
					else // update
					{
						var tmpSector = new Sector { Name = value, ID = Recordid };
						await _SectorRepository.Update(Recordid, tmpSector);
					}
					break;
				case "Dep":
					if(Recordid == 0) // new : to insert
					{
						var tmpDep = new Dep { Name = value };
						newID = await _DepRepository.Create(tmpDep);
					}
					else // update
					{
						var tmpDep = new Dep { Name = value, ID = Recordid };
						await _DepRepository.Update(Recordid, tmpDep);
					}
					break;
				case "Unit":
					if(Recordid == 0) // new : to insert
					{
						var tmpUnit = new Unit { Name = value };
						newID = await _UnitRepository.Create(tmpUnit);
					}
					else // update
					{
						var tmpUnit = new Unit { Name = value, ID = Recordid };
						await _UnitRepository.Update(Recordid, tmpUnit);
					}
					break;
			}
			return newID;
		}

        [HttpPost]
		public async Task<IActionResult> Post(PostUserDataRequestModel requestModel)
		{
			int newID =0;
			try
			{
				if(requestModel.ids?.Count() != requestModel.Values?.Count())	{ throw new Exception("ids array length doesnt match values array length");}
				
				for(short nLoop=0; nLoop<requestModel.ids?.Count(); nLoop++)
				{
					await AddorUpdate(requestModel.Configuration??string.Empty, (requestModel.ids?.ToArray()[nLoop]).Value, requestModel.Values?.ToArray()[nLoop]);
				}
				return Ok(new PostBaseResponseModel{ Successful=true , Record=newID});
			}
			catch (Exception ex) 
			{
				if (ex.InnerException != null)
				{
					_logger.LogError("Inner Exception");
					_logger.LogError(String.Concat(ex.InnerException.StackTrace, ex.InnerException.Message));
				} 
				return BadRequest(new PostBaseResponseModel{ Message=ex.Message, Successful=false} );
			}
		}
	}
}
