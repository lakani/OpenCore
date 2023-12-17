using System;
using Microsoft.AspNetCore.Mvc;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.Account;
using SIS.OpenCore.Server.Data.Repository.Interface;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Identity;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using System.Linq.Dynamic.Core;
using SIS.OpenCore.Shared.Model.PostRequest;
using Microsoft.Data.SqlClient;


namespace SIS.OpenCore.Server.Controllers
{
    [ApiController]
    //[Route("api/[controller]/[action]")]
	[Route("v1/api/OpenCore/system/Objects/ACCTClass/[action]")]
    public partial class ACCTClassController : ControllerBase
    {
        private readonly ILogger<ACCTClassController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IUserDataRepository<Zone> _ZoneRepository;
		private readonly IUserDataRepository<DEF_Company> _CompanyRepository;
		private readonly IUserDataRepository<DEF_Branch> _BranchRepository;
		private readonly IUserDataRepository<DEF_Sector> _SectorRepository;
		private readonly IUserDataRepository<DEF_Dep> _DepRepository;
		private readonly IUserDataRepository<DEF_Unit> _UnitRepository;
        private readonly ILUTRepository<LUT_ACCT_TYPE> _AcctTypeRepository;
        private readonly IDEF_ACCT_CLASSRepository<DEF_ACCT_CLASS> _AcctClassRepository;


        public ACCTClassController(
		ILogger<ACCTClassController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IUserDataRepository<Zone> ZoneRepository,
		IUserDataRepository<DEF_Company> CompanyRepository,
		IUserDataRepository<DEF_Branch> BranchRepository,
		IUserDataRepository<DEF_Sector> SectorRepository,
		IUserDataRepository<DEF_Dep> DepRepository,
		IUserDataRepository<DEF_Unit> UnitRepository,
        ILUTRepository<LUT_ACCT_TYPE> AcctTypeRepository,
        IDEF_ACCT_CLASSRepository<DEF_ACCT_CLASS> AcctClassRepository) : base()
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
            _AcctTypeRepository  = AcctTypeRepository;
            _AcctClassRepository = AcctClassRepository ;

			_logger.Log(LogLevel.Information, "ACCTClassController() : constructor");
		}

        [HttpGet]
        public ActionResult Get(int nClassID)
        {
            _logger.Log(LogLevel.Information, "[HttpGet] ACCTClassController - > Get");

            if (nClassID == 0) // Get All
            {
                try
                {
                    var Ret = _AcctClassRepository.GetAll();
                    if (Ret != null && Ret.Count() > 0)
                        return Ok(Ret);
                    else
                        return NotFound("No Data");
                }
                catch (SqlException sqlex)
                {
                    _logger.LogError("Error Connecting SQL Server");
                    _logger.LogError(sqlex.Message);
                    return BadRequest(sqlex.Message);
                }
                catch (Exception ex)
                {
                    if (ex.InnerException != null)
                    {
                        _logger.LogError("Inner Exception");
                        _logger.LogError(String.Concat(ex.InnerException.StackTrace, ex.InnerException.Message));
                    }
                    
                    _logger.LogError("Error [HttpGet] ACCTClassController - > Get");
                    _logger.LogError(ex.Message);
                    return BadRequest(ex.Message);
                }
            }
            else
            {
                try
                {
                    var Ret = _AcctClassRepository.GetById(nClassID);
                    if (Ret != null)
                        return Ok(Ret);
                    else
                        return NotFound("No Data");
                }
                catch (Exception ex)
                {
                    _logger.LogError("[HttpGet] ACCTClassController - > Get");
                    _logger.LogError(ex.Message);
                    return BadRequest(ex.Message);
                }
            }
        }


        [HttpGet(Name ="Preview")]
        public ActionResult Preview(int x, int y)
        {
            return Ok("Preview");
        }


        [HttpPost]
        public async Task<ActionResult> PostNewAcctClass(PostACCTClassRequestModel ACCTClassReq)
        {
            _logger.Log(LogLevel.Information, "[HttpPost] ACCTClassController - > PostNewACCTClass");

            try{
                _logger.Log(LogLevel.Information, "Checking def_ACCTClass.ACCT_TYPE");
                if(null == _AcctTypeRepository.GetById(ACCTClassReq.ACCT_TYPE))
                    return BadRequest( new BaseResponseModel { Message = "Invalid ACCT_TYPE" , Successful=false});
                
                int newID = await _AcctClassRepository.Create(new DEF_ACCT_CLASS {
                    ACCT_TYPE = ACCTClassReq.ACCT_TYPE,
                    Name = ACCTClassReq.Name,
                    REFERENCE = ACCTClassReq.REFERENCE,
                    ExternallyManged = ACCTClassReq.ExternallyManged });

                return Ok(new BaseResponseModel{ Message = newID.ToString(), Record=newID, Successful = true });
            }
            catch(Exception ex)
            {
                return BadRequest( new BaseResponseModel { Message = ex.Message , Successful=false});
            }
        }
    }
}
