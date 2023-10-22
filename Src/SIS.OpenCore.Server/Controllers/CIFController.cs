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
using SIS.OpenCore.Shared.Model.PostRequest;

namespace SIS.OpenCore.Server.Controllers
{
    [ApiController]
	[Route("v1/api/OpenCore/system/Objects/CIF")]
    public partial class CIFController : ControllerBase
    {
        private readonly ILogger<CIFController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IUserDataRepository<DEF_Zone> _ZoneRepository;
		private readonly IUserDataRepository<DEF_Company> _CompanyRepository;
		private readonly IUserDataRepository<DEF_Branch> _BranchRepository;
		private readonly IUserDataRepository<DEF_Sector> _SectorRepository;
		private readonly IUserDataRepository<DEF_Dep> _DepRepository;
		private readonly IUserDataRepository<DEF_Unit> _UnitRepository;
        private readonly IDEF_CIF_CLASSRepository<DEF_CIF_CLASS> _CifClassRepository;
        private readonly IDEF_CIFRepository<DEF_CIF> _CifRepository;
        private readonly ISettingsRepository<SettingsModel> _SettingsRepository;

        public CIFController(
		ILogger<CIFController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IUserDataRepository<DEF_Zone> ZoneRepository,
		IUserDataRepository<DEF_Company> CompanyRepository,
		IUserDataRepository<DEF_Branch> BranchRepository,
		IUserDataRepository<DEF_Sector> SectorRepository,
		IUserDataRepository<DEF_Dep> DepRepository,
		IUserDataRepository<DEF_Unit> UnitRepository,
        IDEF_CIF_CLASSRepository<DEF_CIF_CLASS> CifClassRepository,
        IDEF_CIFRepository<DEF_CIF> CifRepository,
        ISettingsRepository<SettingsModel> SettingsRepository) : base()
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
            _CifClassRepository = CifClassRepository;
            _CifRepository = CifRepository;
            _SettingsRepository = SettingsRepository;

			_logger.Log(LogLevel.Information, "CIFController() : constructor");
		}

        [HttpGet]
		public async Task<ActionResult> Get(string CIF_NO)
		{
            _logger.Log(LogLevel.Information, "[HttpGet] CIFController - > Get");

            if(string.IsNullOrEmpty(CIF_NO) != false) 
            {
                try{
                    var Ret = _CifRepository.GetByCode(CIF_NO);
                    if(Ret != null)
                        return Ok(Ret);
                    else
                        return NotFound("No Data");
                }
                catch(Exception ex)
                {
                    _logger.LogError("Error [HttpGet] CIFController - > Get");
                    _logger.LogError(ex.Message);
                    return BadRequest(ex.Message);
                }
            }
            else
                return NotFound("No Data");
        }

        //private readonly ILogger<CIFController> _logger;

        /*
        public static List<DEF_CIF> List(short cRecordsPerPage)
        {
            OpenCoreContext db = new OpenCoreContext();

            return ((from c in db.DEF_CIF
                     orderby c.CREATE_DT descending
                     select c).Take(cRecordsPerPage).ToList());

        }
        */

        // BUILD_ERR : the below
        // [HttpGet]
        // [Route("/API/CIF")]
        // public IEnumerable<DEF_CIF> Get(string Name = "", int cRecords = 0, string firstName = "", string lastName = "", 
        //                                 string SearchKey = "", string FamilyName = "", string MobileNumber = "", string NationalID = "")
        // {
        //     // BUILD_ERR : the below
        //     //DEF_CIF_PARAM cIF_PARAM = new DEF_CIF_PARAM();
        //     cIF_PARAM = new DEF_CIF_PARAM();
        //     cIF_PARAM.Name = Name;
        //     cIF_PARAM.cRecords = cRecords;
        //     cIF_PARAM.FirstName = firstName;
        //     cIF_PARAM.LastName = lastName;
        //     cIF_PARAM.SearchKey = SearchKey;
        //     cIF_PARAM.FamilyName = FamilyName;
        //     cIF_PARAM.MobileNumber = MobileNumber;
        //     cIF_PARAM.NationalID = NationalID;

        //     return Cif.List(cIF_PARAM);
        // }

        // [HttpGet]
        // [Route("API/{CIF_NO}/{ACCT_TYPE}")]
        // public IEnumerable<DEF_CK_ACCT> GetCK(string CIF_NO, string ACCT_TYPE)
        // {
        //     //if (ACCT_TYPE == "CK")
        //     {
        //         //var ret = CurrentAccount.List(CIF_NO, string.Empty, 10);
        //         //string[] r = new string[ret.Length];
        //         //for (int x = 0; x < r.Length; x++)
        //         //    r[x] = ret[x].ToString();
        //         return CurrentAccount.List(CIF_NO, string.Empty, 10); 
        //     }
        //     //else
        //         //return new string[] { CIF_NO + " FIXED", CIF_NO + " FIXED" };
        // }

        // [HttpGet("{Cif_NO}")]
        // // GET: api/CIF/5/
        // public DEF_CIF Get(string Cif_NO)
        // {
        //     return Cif.Get(Cif_NO);
        // }

        // [HttpPost]
        // public ActionResult<DEF_CIF> PostNewCIF(DEF_CIF def_CIF)
        // {
        //     string stCIFNo = Cif.Add_CIF(DateTime.Now, 1, def_CIF);
        //     def_CIF.CIF_NO = stCIFNo;
        //     return def_CIF;
        // }

        protected string GenerateNewCode(string sCIF_NO)
        {
            //OpenCoreContext db = new OpenCoreContext();
            object CIFLock = new object();

            // if @CIF_NO is provided
            if(!string.IsNullOrEmpty(sCIF_NO))
            {
                //fn_OPT_GetCIFFormatDigitsNum
                //if(sCIF_NO.Length > Settings.fn_OPT_GetCIFFormatDigitsNum())
                if(sCIF_NO.Length > _SettingsRepository.GetCIFFormatDigitsNum())
                {
                    throw new ArgumentOutOfRangeException("sCIF_NO", "Provided CIF_NO Length is greater than Digits Length");
                }
            }
            else // its not provided
            {
                // 000000000
                lock(CIFLock)
                {
                    // Get Max CIF Number
                    string sMax = _CifRepository.GetMaxCIFNO();
                    int nMax ;

                    bool bParseSucess = int.TryParse(sMax, out nMax);
                    if (bParseSucess == false)
                        throw new ArithmeticException("unable to parse Last CIF number");
                    nMax = nMax + 1;
                    sMax = _SettingsRepository.GetCIFFormatDigits() + nMax.ToString();
                    int cToRemove = sMax.Length - _SettingsRepository.GetCIFFormatDigitsNum();
                    sCIF_NO = sMax.Remove(0, cToRemove);
                }
            }

            return sCIF_NO;
        }

        [HttpPost]
        public async Task<ActionResult> PostNewCIF(PostCIFRequestModel CIFReq)
        {
            _logger.Log(LogLevel.Information, "[HttpGet] CIFClassController - > PostNewCIF");

            try{
                
                // checking the Class
                _logger.Log(LogLevel.Information, "Checking def_CIFClass.CIF_TYPE");
                if(null == _CifClassRepository.GetById(CIFReq.CLASS_ID))
                    return BadRequest( new BaseResponseModel { Message = "Invalid CIF_TYPE" , Successful=false});

                // checking that the CIF no doesn't exists before
                if (string.IsNullOrEmpty(CIFReq.CIF_NO) == false)
                    if (_CifRepository.GetByCode(CIFReq.CIF_NO) != null)
                        return BadRequest( new BaseResponseModel { Message = "CIF NO Already Exists " , Successful=false});

                // checking that the CIF no doesn't exists before
                if (string.IsNullOrEmpty(CIFReq.SearchKey) == false)
                    if(_CifRepository.GetByCode(CIFReq.SearchKey) != null)
                        return BadRequest( new BaseResponseModel { Message = "Search Key Already Exists " , Successful=false});

                // Generate CIF Code
                CIFReq.CIF_NO = GenerateNewCode(CIFReq.CIF_NO);
                if(string.IsNullOrEmpty(CIFReq.SearchKey))
                    CIFReq.SearchKey = CIFReq.CIF_NO;
                
                await _CifRepository.Create(new DEF_CIF {
                    CIF_NO = CIFReq.CIF_NO,
                    SearchKey = CIFReq.SearchKey,
                    FirstName = CIFReq.FirstName,
                    MiddleName = CIFReq.MiddleName,
                    LastName = CIFReq.LastName,
                    FamilyName = CIFReq.FamilyName,
                    CREATE_DT = DateTime.Now,
                    CLASS_ID = CIFReq.CLASS_ID,
                    RSM = CIFReq.RSM,
                    REFERENCE = CIFReq.REFERENCE,
                    LAST_SAVE_DT = DateTime.Now });

                return Ok(new BaseResponseModel{ Message = CIFReq.CIF_NO, Successful = true });
            }
            catch(Exception ex)
            {
                return BadRequest( new PostCIFClassResponseModel { Message = ex.Message , Successful=false});
            }
        }


    }
}
