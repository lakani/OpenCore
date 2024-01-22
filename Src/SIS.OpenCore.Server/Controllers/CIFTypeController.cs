using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using SIS.OpenCore.Server.BL.Objects;
using SIS.OpenCore.Server.Data.Repository.Interface;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Identity;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using System.Linq.Dynamic.Core;
using SIS.OpenCore.Shared.Model.PostRequest;
using Microsoft.AspNetCore.Http.HttpResults;

namespace SIS.OpenCore.Server.Controllers
{
    [ApiController]
	[Route("v1/api/OpenCore/system/Objects/CIFType")]
    public partial class CIFTypeController  : ControllerBase
    {
        private readonly ILogger<CIFTypeController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IUserDataRepository<Zone> _ZoneRepository;
		private readonly IUserDataRepository<Company > _CompanyRepository;
		private readonly IUserDataRepository<Branch> _BranchRepository;
		private readonly IUserDataRepository<Sector> _SectorRepository;
		private readonly IUserDataRepository<Dep> _DepRepository;
		private readonly IUserDataRepository<Unit> _UnitRepository;
        private readonly ILUTRepository<LUT_CIF_TYPE> _CifTypeRepository;


        public CIFTypeController(
		ILogger<CIFTypeController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IUserDataRepository<Zone> ZoneRepository,
		IUserDataRepository<Company > CompanyRepository,
		IUserDataRepository<Branch> BranchRepository,
		IUserDataRepository<Sector> SectorRepository,
		IUserDataRepository<Dep> DepRepository,
		IUserDataRepository<Unit> UnitRepository,
        ILUTRepository<LUT_CIF_TYPE> CifTypeRepository) : base()
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
            _CifTypeRepository = CifTypeRepository;

			_logger.Log(LogLevel.Information, "CIFTypeController() : constructor");
		}

        [HttpGet]
        public ActionResult Get()
        {
            _logger.Log(LogLevel.Information, "[HttpGet] CIFTypeController - > Get");

            try{
                var Ret = _CifTypeRepository.GetAll();
                if (Ret != null && Ret.Count() > 0)
                    return Ok(Ret);
                else
                    return NotFound("No Data");
            }
            catch (Exception ex)
            {
                _logger.LogError("Error [HttpGet] CIFTypeController - > Get");
                _logger.LogError(ex.Message);
                if (ex.InnerException != null)
                {
                    _logger.LogError("Inner Exception");
                    _logger.LogError(String.Concat(ex.InnerException.StackTrace, ex.InnerException.Message));
                }
                return BadRequest(ex.Message);
            }
        }
    }
}


