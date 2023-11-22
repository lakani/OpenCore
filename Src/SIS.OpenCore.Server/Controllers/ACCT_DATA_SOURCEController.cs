using System;
using Microsoft.AspNetCore.Mvc;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.Account;
using SIS.OpenCore.Server.Data.Repository.Interface;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Duende.IdentityServer.EntityFramework.Options;
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
	[Route("v1/api/OpenCore/system/Objects/[controller]/[action]")]
    public partial class ACCT_DATA_SOURCEController : ControllerBase
    {
        private readonly ILogger<ACCT_DATA_SOURCEController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IACCT_DATA_SOURCERepository<ACCT_DATA_SOURCE> _AcctDataSourceRep;


        public ACCT_DATA_SOURCEController(
		ILogger<ACCT_DATA_SOURCEController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IACCT_DATA_SOURCERepository<ACCT_DATA_SOURCE> AcctDataSourceRep) : base()
		{
			_logger = logger;
			_configuration = Configuration;
			_signInManager = signInManager;
            _AcctDataSourceRep = AcctDataSourceRep;

			_logger.Log(LogLevel.Information, "ACCT_DATA_SOURCEController() : constructor");
		}

        [HttpGet]
        public ActionResult Get(int nDataSource)
        {
            _logger.Log(LogLevel.Information, "[HttpGet] ACCT_DATA_SOURCEController - > Get");

            if (nDataSource == 0) // Get All
            {
                try
                {
                    var Ret = _AcctDataSourceRep.GetAll();
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
                    
                    _logger.LogError("Error [HttpGet] ACCT_DATA_SOURCEController - > Get");
                    _logger.LogError(ex.Message);
                    return BadRequest(ex.Message);
                }
            }
            else
            {
                try
                {
                    var Ret = _AcctDataSourceRep.GetById(nDataSource);
                    if (Ret != null)
                        return Ok(Ret);
                    else
                        return NotFound("No Data");
                }
                catch (Exception ex)
                {
                    _logger.LogError("[HttpGet] ACCT_DATA_SOURCEController - > Get");
                    _logger.LogError(ex.Message);
                    return BadRequest(ex.Message);
                }
            }
        }


        [HttpPost(Name ="Test")]
        public ActionResult TestDataSource(PostACCTDataSourceModel ACCTDataSourceReq)
        {
            _logger.Log(LogLevel.Information, "[HttpPost] ACCT_DATA_SOURCEController - > TestDataSource");

            //Server=myServerAddress;Database=myDataBase;User Id=myUsername;Password=myPassword;
            if(string.IsNullOrEmpty(ACCTDataSourceReq.CONNECTIONSTRING))
            {
                ACCTDataSourceReq.CONNECTIONSTRING  = @"Server=" + ACCTDataSourceReq.SERVER ;
                ACCTDataSourceReq.CONNECTIONSTRING += @";Database=" + ACCTDataSourceReq.DATABASE;
                ACCTDataSourceReq.CONNECTIONSTRING += @";User Id=" + ACCTDataSourceReq.USERNAME;
                ACCTDataSourceReq.CONNECTIONSTRING += @";Password=" + ACCTDataSourceReq.PASSWORD;
                ACCTDataSourceReq.CONNECTIONSTRING += @";TrustServerCertificate=True;";
            }

            // TODO add here checks for the Request 

            try
            {
                using (var connection = new SqlConnection(ACCTDataSourceReq.CONNECTIONSTRING))
                {
                    connection.Open();
                    using (var command = new SqlCommand(ACCTDataSourceReq.PREVIEWQUERY, connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            if(true == reader.Read())
                                return Ok("Sucess"); 
                            else
                                return BadRequest("Error"); 
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                if (ex.InnerException != null)
                {
                    _logger.LogError("Inner Exception");
                    _logger.LogError(String.Concat(ex.InnerException.StackTrace, ex.InnerException.Message));
                }
                _logger.LogError("Error [HttpGet] ACCT_DATA_SOURCEController - > Get");
                _logger.LogError(ex.Message);
                return BadRequest(ex.Message);
            }
            
            
            // should check that the connection to the given database is Valid
        }


        [HttpPost]
        public async Task<ActionResult> PostNewAcctDataSource(PostACCTDataSourceModel ACCTDataSourceReq)
        {
            _logger.Log(LogLevel.Information, "[HttpPost] ACCT_DATA_SOURCEController - > PostNewAcctDataSource");

            try{
                int newID = await _AcctDataSourceRep.Create(new ACCT_DATA_SOURCE {
                    Name = ACCTDataSourceReq.Name,
                    REFERENCE = ACCTDataSourceReq.REFERENCE,
                    CONNECTIONTYPE = ACCTDataSourceReq.CONNECTIONTYPE,
                    CONNECTIONSTRING = ACCTDataSourceReq.CONNECTIONSTRING,
                    SERVER = ACCTDataSourceReq.SERVER,
                    DATABASE = ACCTDataSourceReq.DATABASE,
                    USERNAME = ACCTDataSourceReq.USERNAME,
                    PASSWORD = ACCTDataSourceReq.PASSWORD ,
                    QUERY = ACCTDataSourceReq.QUERY,
                    PREVIEWQUERY = ACCTDataSourceReq.PREVIEWQUERY});

                return Ok(new BaseResponseModel{ Message = newID.ToString(), Record=newID, Successful = true });
            }
            catch(Exception ex)
            {
                return BadRequest( new BaseResponseModel { Message = ex.Message , Successful=false});
            }
        }
    }
}
