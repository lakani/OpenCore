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
using System.Linq.Dynamic.Core;


#nullable disable
//namespace SIS.OpenCore.Server.Controllers
namespace SIS.OpenCore.Server.Controllers
{
    
    [ApiController]
	[Route("v1/api/OpenCore/system/Objects/GLLedger/[action]")]
	public partial class GLLedgerController : ControllerBase
	{
		private readonly ILogger<GLLedgerController> _logger;
		private readonly IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IUserDataRepository<Zone> _ZoneRepository;
		private readonly IUserDataRepository<Company > _CompanyRepository;
		private readonly IUserDataRepository<Branch> _BranchRepository;
		private readonly IUserDataRepository<Sector> _SectorRepository;
		private readonly IUserDataRepository<Dep> _DepRepository;
		private readonly IUserDataRepository<Unit> _UnitRepository;
		private readonly ISettingsRepository<SettingsModel> _SettingsRep;
		private readonly IGL_ACCTRepository<GL_ACCT> _GL_ACCTRepository;
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
		IUserDataRepository<Zone> ZoneRepository,
		IUserDataRepository<Company > CompanyRepository,
		IUserDataRepository<Branch> BranchRepository,
		IUserDataRepository<Sector> SectorRepository,
		IUserDataRepository<Dep> DepRepository,
		IUserDataRepository<Unit> UnitRepository,
		ISettingsRepository<SettingsModel> SettingsRep,
		IGL_ACCTRepository<GL_ACCT> GL_ACCTRepository, 
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
			_GL_ACCTRepository = GL_ACCTRepository;
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
                    ret.Gls = _GL_ACCTRepository.GetAll();
                }
                else
                {
                    var record = _GL_ACCTRepository.GetById(nGLNo);
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
        public ActionResult Search(GetGLLedgerRequestModel request)
		{
			try
			{
				var responseModel = new GetGLLedgerResponseModel{ Successful = true, ServerTimeStamp = DateTime.Now};
				var SearchResult = _GL_ACCTRepository.Search(request);
				if(SearchResult == null) {
					return NotFound(new BaseResponseModel { Message = "No Data", ServerTimeStamp = DateTime.Now, Successful = false});	
				}
				else if (SearchResult.Count() == 0){
					return NotFound(new BaseResponseModel { Message = "No Data", ServerTimeStamp = DateTime.Now, Successful = false});	
				}
				responseModel.Gls = SearchResult;
				
				return Ok(responseModel);
			}
			catch(Exception ex)
			{
				return BadRequest(new BaseResponseModel { Message = ex.Message, ServerTimeStamp = DateTime.Now, Successful = false});
			}
		}

		[HttpGet]
        public ActionResult GetByCode(string GLCode)
        {
            _logger.Log(LogLevel.Information, "[HttpGet] GLLedgerController - > Get by Code");

            GetGLLedgerResponseModel ret = new GetGLLedgerResponseModel { Message = "", Successful = true };

            try
            {
                if (string.IsNullOrEmpty(GLCode))
                { // return all
                    ret.Gls = _GL_ACCTRepository.GetAll();
                }
                else
                {
                    var record = _GL_ACCTRepository.GetByCode(GLCode);
                    if (record != null)
                        ret.Gls = new[] { record }.AsQueryable();
                }
            }
            catch (Exception ex)
            {
				if (ex.InnerException != null)
				{
					_logger.LogError("Inner Exception");
					_logger.LogError(string.Concat(ex.InnerException.StackTrace, ex.InnerException.Message));
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
			GL_ACCT	newGL = new GL_ACCT { 	BranchNo = model.BranchNo, 
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
				_SectorRepository, _DepRepository, _UnitRepository , _SettingsRep, _GL_ACCTRepository, _lut_GLLedgerNatureRepository );

				newGL.GL = await GL.Create(newGL);
			}
			catch(Exception ex)
			{
				return BadRequest(new PostGLLedgerResponseModel { Successful = false, Message = ex.Message });		
			}
			return Ok(new PostGLLedgerResponseModel { Successful = true , Record=newGL.GL_DEFID,  GL= newGL.GL ,ServerTimeStamp = DateTime.Now });
		}
    }
}

