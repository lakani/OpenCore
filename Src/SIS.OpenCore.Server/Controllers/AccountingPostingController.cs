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
using SIS.OpenCore.Shared.Model.Transactions.Posting;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Objects.GL;

#nullable enable

namespace SIS.OpenCore.Server.Controllers
{
    [ApiController]
    //[Route("api/[controller]/[action]")]
	[Route("v1/api/OpenCore/system/transactions/accounting/posting/[action]")]
    public partial class AccountingPostingController : ControllerBase
    {
        private readonly ILogger<AccountingPostingController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IUserDataRepository<Zone> _ZoneRepository;
		private readonly IUserDataRepository<Company > _CompanyRepository;
		private readonly IUserDataRepository<Branch> _BranchRepository;
		private readonly IUserDataRepository<Sector> _SectorRepository;
		private readonly IUserDataRepository<Dep> _DepRepository;
		private readonly IUserDataRepository<Unit> _UnitRepository;
        private readonly ILUTRepository<LUT_ACCT_TYPE> _AcctTypeRepository;
        private readonly ISettingsRepository<SettingsModel> _SettingsRepository;
        private readonly IGL_ACCTRepository<GL_ACCT> _gl_ACCTRepository;
        private readonly ICIF_ACCT_CLASSRepository<CIF_ACCT_CLASS> _AcctClassRepository;


        public AccountingPostingController(
		ILogger<AccountingPostingController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IUserDataRepository<Zone> ZoneRepository,
		IUserDataRepository<Company > CompanyRepository,
		IUserDataRepository<Branch> BranchRepository,
		IUserDataRepository<Sector> SectorRepository,
		IUserDataRepository<Dep> DepRepository,
		IUserDataRepository<Unit> UnitRepository,
        ISettingsRepository<SettingsModel> SettingsRepository,
        ILUTRepository<LUT_ACCT_TYPE> AcctTypeRepository,
        IGL_ACCTRepository<GL_ACCT> gl_ACCTRepository,
        ICIF_ACCT_CLASSRepository<CIF_ACCT_CLASS> AcctClassRepository) : base()
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
            _SettingsRepository = SettingsRepository;
            _gl_ACCTRepository = gl_ACCTRepository;

			_logger.Log(LogLevel.Information, "AccountingPostingController() : constructor");
		}

        
        //


        [HttpPost]
        public async Task<ActionResult> Post(AccountingPosting newPost)
        {

            // check this
            //D:\Projects\OpenCore\Src\SIS.OpenCore.Server\BL\Transactions\TRAN_POST_AE.cs
            _logger.Log(LogLevel.Information, "[HttpPost] AccountingPostingController - > Post");

            try
            {
                SettingsModel SettingData;

                // Get Base Curren\cy
                var SearchResult = _SettingsRepository.Search(new BaseRequesModel());
                if (SearchResult != null)
                {
                    SettingData = SearchResult.First();
                    var stBaseCurrency = SettingData.BaseCurrency;
                    if (string.IsNullOrEmpty(stBaseCurrency))
                        throw new Exception("fn_OPT_GetBaseCurrency can’t retrieve base currency");
                }

                // get Current Bussiness date
                // MaxEffDt = Settings.GetCurrentBusinessDate();
                // // get Today
                // CRT_DT = DateTime.Now;
                // if (CRT_DT.Date > MaxEffDt.Date )
                //     throw new ArgumentOutOfRangeException("CRT_DT.Date", "CRT_DT.Date bigger than MaxEffDt");

                // Validate GLs
                // Validate Credit
                GL_ACCT? CreditGL = null;
                CreditGL = ValidateAccount(newPost.CreditAccountID, newPost.CreditAccount);
                if(CreditGL == null)
                    return BadRequest(new BaseResponseModel { Message = "Invalid Credit Account", Successful = false });

                // Validate Debit
                GL_ACCT? DebitGL = null;
                DebitGL = ValidateAccount(newPost.DebitAccountID, newPost.DebitAccount);
                if(DebitGL == null)
                    return BadRequest(new BaseResponseModel { Message = "Invalid Debit Account", Successful = false });

                int newID = 0;

                return Ok(new BaseResponseModel { Message = newID.ToString(), Record = newID, Successful = true });
            }
            catch (Exception ex)
            {
                return BadRequest( new BaseResponseModel { Message = ex.Message , Successful=false});
            }
        }

        private GL_ACCT? ValidateAccount(int AccountID , string? Account)
        {
            GL_ACCT? AccountGL = null;
            if (string.IsNullOrEmpty(Account) && AccountID <= 0)
                return null;
            if (string.IsNullOrEmpty(Account) == true)
            {
                AccountGL = _gl_ACCTRepository.GetById(AccountID);
                if (AccountGL == null)
                    return null;
            }
            else
            {
                AccountGL = _gl_ACCTRepository.GetByCode(Account);
                if (AccountGL == null)
                    return null;
            }
            return AccountGL;
        }
    }
}
