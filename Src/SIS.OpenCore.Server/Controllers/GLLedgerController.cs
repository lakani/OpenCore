using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.GL;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using SIS.OpenCore.Server.Data.Repository.Interface;
using System;
using System.Collections.Generic;
using SIS.OpenCore.Server.BL.Objects;
using System.Linq;
using System.Threading.Tasks;
using SIS.OpenCore.Shared.Model.PostRequest;
using SIS.OpenCore.Shared.Model.GetRequest;

 
#nullable disable
//namespace SIS.OpenCore.Server.Controllers
namespace SIS.OpenCore.Server.Controllers
{
    
    [ApiController]
	[Route("v1/api/OpenCore/system/Objects/GLLedger")]
	public partial class GLLedgerController : ControllerBase
	{
		private readonly ILogger<GLLedgerController> _logger;
		private readonly IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IUserDataRepository<DEF_Zone> _ZoneRepository;
		private readonly IUserDataRepository<DEF_Company> _CompanyRepository;
		private readonly IUserDataRepository<DEF_Branch> _BranchRepository;
		private readonly IUserDataRepository<DEF_Sector> _SectorRepository;
		private readonly IUserDataRepository<DEF_Dep> _DepRepository;
		private readonly IUserDataRepository<DEF_Unit> _UnitRepository;
		private readonly ISettingsRepository<SettingsModel> _SettingsRep;
		private readonly IDEF_GLRepository<DEF_GL> _DEF_GLRepository;
		private readonly ILUTRepository<LUT_GLLedgerNature> _lut_GLLedgerNatureRepository;


        // static GLSegment [] _segments = new GLSegment[] {   
        //     new GLSegment { Type = 1,   Name = "Nature",          DigitsValue = "#",      DigitsLength = 1},
        //     new GLSegment { Type = 2,   Name = "Zone",            DigitsValue = "##",     DigitsLength = 2},
        //     new GLSegment { Type = 3,   Name = "CompanyNo",       DigitsValue = "##",     DigitsLength = 2},
        //     new GLSegment { Type = 4,   Name = "BranchNo",        DigitsValue = "####",   DigitsLength = 4},
        //     new GLSegment { Type = 5,   Name = "SectorNo",        DigitsValue = "##",     DigitsLength = 2},
        //     new GLSegment { Type = 6,   Name = "DepNo",           DigitsValue = "##",     DigitsLength = 2},
        //     new GLSegment { Type = 7,   Name = "UnitNo",          DigitsValue = "##",     DigitsLength = 2},
        //     new GLSegment { Type = 8,   Name = "ProductNo",       DigitsValue = "####",   DigitsLength = 4},
        //     new GLSegment { Type = 9,   Name = "LedgerNo",        DigitsValue = "######", DigitsLength = 6}};

		public GLLedgerController(
		ILogger<GLLedgerController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IUserDataRepository<DEF_Zone> ZoneRepository,
		IUserDataRepository<DEF_Company> CompanyRepository,
		IUserDataRepository<DEF_Branch> BranchRepository,
		IUserDataRepository<DEF_Sector> SectorRepository,
		IUserDataRepository<DEF_Dep> DepRepository,
		IUserDataRepository<DEF_Unit> UnitRepository,
		ISettingsRepository<SettingsModel> SettingsRep,
		IDEF_GLRepository<DEF_GL> DEF_GLRepository, 
		ILUTRepository<LUT_GLLedgerNature> LUT_GLLedgerNatureRepository) : base()
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
			_SettingsRep = SettingsRep;
			_DEF_GLRepository = DEF_GLRepository;
			_lut_GLLedgerNatureRepository = LUT_GLLedgerNatureRepository;

			_logger.Log(LogLevel.Information, "GLLedgerController() : constructor");
		}

        // TODO : test different GL formats
        // TODO : test Test Many Creation Variables
        // WHEN_NEEDED : IF Get All then retrive only the max Server response number of records
        //               , it should be defaulted from Configurations
        [HttpGet]
        public ActionResult Get(int nGLNo)
        {
            _logger.Log(LogLevel.Information, "[HttpGet] GLLedgerController - > Get");

            GetGLLedgerResponseModel ret = new GetGLLedgerResponseModel { Message = "", Successful = true };

            try
            {
                if (nGLNo == 0)
                { // return all
                    ret.Gls = _DEF_GLRepository.GetAll();
                }
                else
                {
                    var record = _DEF_GLRepository.GetById(nGLNo);
                    if (record != null)
                        ret.Gls = new[] { record }.AsQueryable();
                }
            }
            catch (Exception ex)
            {
				if (ex.InnerException != null)
				{
					_logger.LogError("Inner Exception");
					_logger.LogError(String.Concat(ex.InnerException.StackTrace, ex.InnerException.Message));
				}
                return BadRequest(new PostGLLedgerResponseModel { Successful = false, Message = ex.Message });
            }

            if (ret.Gls != null)
                return Ok(ret);
            else
                return NotFound();
        }

        [HttpPost]
		public async Task<ActionResult> Create(PostGLLedgerRequestModel model)
		{
			DEF_GL	newGL = new DEF_GL { 	BranchNo = model.BranchNo, 
											COMMENTS = model.COMMENTS, 
											CompanyNo = model.CompanyNo,
											DepNo = model.DepNo, 
											EFFECTIVE_DT = model.EFFECTIVE_DT, 
											GL = string.Empty, 
											LedgerNO = model.LedgerNO,
											Nature = model.Nature,
											ProductNo = model.ProductNo,
											REFERENCE = model.REFERENCE,
											SectorNo = model.SectorNo, 
											STATUS = 0, 
											UnitNO = model.UnitNO,
											Zone = model.Zone};
			
			try{
				GL.InitServices(_logger, _configuration, _signInManager, _ZoneRepository, _CompanyRepository, _BranchRepository,
				_SectorRepository, _DepRepository, _UnitRepository , _SettingsRep, _DEF_GLRepository, _lut_GLLedgerNatureRepository );

				newGL.GL = await GL.Create(newGL);
			}
			catch(Exception ex)
			{
				return BadRequest(new PostGLLedgerResponseModel { Successful = false, Message = ex.Message });		
			}
			return Ok(new PostGLLedgerResponseModel { Successful = true , GL= newGL.GL ,ServerTimeStamp = DateTime.Now });
		}
    }
}

