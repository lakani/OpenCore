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
using SIS.OpenCore.Shared.Model.Objects.Account.CK;
using SIS.OpenCore.Shared.Model.Objects.CIF;


namespace SIS.OpenCore.Server.Controllers
{
    [ApiController]
	[Route("v1/api/OpenCore/system/Objects/CKACCT")]
    public partial class CKACCTController : ControllerBase
    {
        static protected short   _CURRENT_ACCOUNT_NUM_FORMAT_LENGTH = 15;
        static protected string _CURRENT_ACCOUNT_NUM_FORMAT = "000000000000000";


        private readonly ILogger<CKACCTController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IDEF_CK_ACCTRepository<DEF_CK_ACCT> _CKACCTRepository;
		private readonly IUserDataRepository<DEF_Company> _CompanyRepository;
		private readonly ILUTRepository<LUT_ACCT_TYPE> _AcctTypeRepository;
        private readonly IDEF_ACCT_CLASSRepository<DEF_ACCT_CLASS> _AcctClassRepository;
        private readonly IDEF_CIFRepository<DEF_CIF> _CifRepository;
        private readonly IDEF_CurrencyRepository<DEF_Currency> _CurrencyRepository;
        

        public CKACCTController(
		ILogger<CKACCTController> logger, IConfiguration Configuration,
        SignInManager<ApplicationUser> signInManager, 
        IUserDataRepository<DEF_Company> CompanyRepository,
		IDEF_CK_ACCTRepository<DEF_CK_ACCT> CKACCTRepository,
        ILUTRepository<LUT_ACCT_TYPE> AcctTypeRepository,
        IDEF_CIFRepository<DEF_CIF> CifRepository,
        IDEF_CurrencyRepository<DEF_Currency> CurrencyRepository,
        IDEF_ACCT_CLASSRepository<DEF_ACCT_CLASS> AcctClassRepository) : base()
		{
			_logger = logger;
			_configuration = Configuration;
			_signInManager = signInManager;
			_CompanyRepository = CompanyRepository;
			_AcctTypeRepository  = AcctTypeRepository;
            _AcctClassRepository = AcctClassRepository ;
            _CKACCTRepository = CKACCTRepository ;
            _CifRepository = CifRepository;
            _CurrencyRepository = CurrencyRepository;

			_logger.Log(LogLevel.Information, "CKACCTController() : constructor");
		}

        [HttpGet]
        public ActionResult Get(int ACCTID)
        {
            _logger.Log(LogLevel.Information, "[HttpGet] CKACCTController - > Get");

            if (ACCTID == 0) // Get All
            {
                try
                {
                    var Ret = _CKACCTRepository.GetAll();
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
                    
                    _logger.LogError("Error [HttpGet] CKACCTController - > Get");
                    _logger.LogError(ex.Message);
                    return BadRequest(ex.Message);
                }
            }
            else
            {
                try
                {
                    var Ret = _CKACCTRepository.GetById(ACCTID);
                    if (Ret != null)
                        return Ok(Ret);
                    else
                        return NotFound("No Data");
                }
                catch (Exception ex)
                {
                    _logger.LogError("[HttpGet] CKACCTController - > Get");
                    _logger.LogError(ex.Message);
                    return BadRequest(ex.Message);
                }
            }
        }

        protected string GenerateNewACCT_NO(string stACCT_NO)
        {
            int nAcctNo = 0;
            string sReturn = string.Empty;

            if(string.IsNullOrEmpty(stACCT_NO)) 
            {
                var maxCKACCT = _CKACCTRepository.GetById(-1);
                if(maxCKACCT == null)
                    stACCT_NO = _CURRENT_ACCOUNT_NUM_FORMAT;
                else
                    stACCT_NO = maxCKACCT.ACCT_NO;
                nAcctNo = (int)int.Parse(stACCT_NO);
                nAcctNo ++;
                sReturn = _CURRENT_ACCOUNT_NUM_FORMAT + nAcctNo.ToString();
                int cToRemove = sReturn.Length - _CURRENT_ACCOUNT_NUM_FORMAT_LENGTH;
                sReturn = sReturn.Remove(0,cToRemove);
            }
            else
            {
                if(stACCT_NO.Length > _CURRENT_ACCOUNT_NUM_FORMAT_LENGTH)
                    sReturn = string.Empty; // ERROR
                else
                {
                    sReturn = _CURRENT_ACCOUNT_NUM_FORMAT + stACCT_NO.ToString();
                    int cToRemove = sReturn.Length - _CURRENT_ACCOUNT_NUM_FORMAT_LENGTH;
                    sReturn = sReturn.Remove(0,cToRemove);
                }
            }

            return sReturn;
        }


        [HttpPost]
        public async Task<ActionResult> PostNewCKAcct(PostCKACCTRequestModel CKACCTReq)
        {
            _logger.Log(LogLevel.Information, "[HttpGet] CKACCTController - > PostNewACCTClass");

            try{
                
                _logger.Log(LogLevel.Information, "Checking CKACCTReq.CIF_NO");
                if(null == _CifRepository.GetByCode(CKACCTReq.CIF_NO))
                    return BadRequest( new BaseResponseModel { Message = "Invalid CIF_NO" , Successful=false});

                _logger.Log(LogLevel.Information, "Checking CKACCTReq.ACCT_CLASS_ID");
                if(null == _AcctClassRepository.GetById(CKACCTReq.ACCT_CLASS_ID))
                    return BadRequest( new BaseResponseModel { Message = "Invalid ACCT_CLASS_ID" , Successful=false});

                _logger.Log(LogLevel.Information, "Checking CKACCTReq.CompanyNo");
                if(null == _CompanyRepository.GetById(CKACCTReq.CompanyID))
                    return BadRequest( new BaseResponseModel { Message = "Invalid CompanyNo" , Successful=false});

                _logger.Log(LogLevel.Information, "Checking CKACCTReq.Currency");
                if(null == _CurrencyRepository.GetByCode(CKACCTReq.Currency))
                    return BadRequest( new BaseResponseModel { Message = "Invalid Currency" , Successful=false});

                CKACCTReq.ACCT_NO = GenerateNewACCT_NO(CKACCTReq.ACCT_NO);

                int newID = await _CKACCTRepository.Create(new DEF_CK_ACCT {
                    
                    CIF_NO = CKACCTReq.CIF_NO,
                    ACCT_CLASS_ID = CKACCTReq.ACCT_CLASS_ID,
                    CompanyID = CKACCTReq.CompanyID,
                    ACCT_NO = CKACCTReq.ACCT_NO,
                    Currency = CKACCTReq.Currency,
                    Name = CKACCTReq.Name,
                    REFERENCE = CKACCTReq.REFERENCE,
                    Title = CKACCTReq.Title,
                    Description = CKACCTReq.Description,
                    ReferenceACCT = CKACCTReq.ReferenceACCT,
                    ReferenceOrg = CKACCTReq.ReferenceOrg,
                    IBAN = CKACCTReq.IBAN,
                    OpenDate = DateTime.Now,
                    STATUS = 1 });

                return Ok(new BaseResponseModel{ Message = newID.ToString(), Record=newID, Successful = true });
            }
            catch(Exception ex)
            {
                return BadRequest( new BaseResponseModel { Message = ex.Message , Successful=false});
            }
        }
    }
}
