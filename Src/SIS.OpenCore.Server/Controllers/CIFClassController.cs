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
	[Route("v1/api/OpenCore/system/Objects/CIFClass")]
    public partial class CIFClassController : ControllerBase
    {
        private readonly ILogger<CIFClassController> _logger;
		private IConfiguration _configuration;
		private readonly SignInManager<ApplicationUser> _signInManager;
		private readonly IUserDataRepository<Zone> _ZoneRepository;
		private readonly IUserDataRepository<Company > _CompanyRepository;
		private readonly IUserDataRepository<Branch> _BranchRepository;
		private readonly IUserDataRepository<Sector> _SectorRepository;
		private readonly IUserDataRepository<Dep> _DepRepository;
		private readonly IUserDataRepository<Unit> _UnitRepository;
        private readonly ILUTRepository<LUT_CIF_TYPE> _CifTypeRepository;
        private readonly ICIF_CLASSRepository<CIF_CLASS> _CifClassRepository;


        public CIFClassController(
		ILogger<CIFClassController> logger, IConfiguration Configuration,
		SignInManager<ApplicationUser> signInManager, 
		IUserDataRepository<Zone> ZoneRepository,
		IUserDataRepository<Company > CompanyRepository,
		IUserDataRepository<Branch> BranchRepository,
		IUserDataRepository<Sector> SectorRepository,
		IUserDataRepository<Dep> DepRepository,
		IUserDataRepository<Unit> UnitRepository,
        ILUTRepository<LUT_CIF_TYPE> CifTypeRepository,
        ICIF_CLASSRepository<CIF_CLASS> CifClassRepository) : base()
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
            _CifClassRepository = CifClassRepository ;

			_logger.Log(LogLevel.Information, "CIFClassController() : constructor");
		}

        [HttpGet]
        public ActionResult Get(int nClassID)
        {
            _logger.Log(LogLevel.Information, "[HttpGet] CIFClassController - > Get");

            if (nClassID == 0) // Get All
            {
                try
                {
                    var Ret = _CifClassRepository.GetAll();
                    if (Ret != null && Ret.Count() > 0)
                        return Ok(Ret);
                    else
                        return NotFound("No Data");
                }
                catch (Exception ex)
                {
                    _logger.LogError("Error [HttpGet] CIFClassController - > Get");
                    _logger.LogError(ex.Message);
                    if (ex.InnerException != null)
                    {
                        _logger.LogError("Inner Exception");
                        _logger.LogError(String.Concat(ex.InnerException.StackTrace, ex.InnerException.Message));
                    }
                    return BadRequest(ex.Message);
                }
            }
            else
            {
                try
                {
                    var Ret = _CifClassRepository.GetById(nClassID);
                    if (Ret != null)
                        return Ok(Ret);
                    else
                        return NotFound("No Data");
                }
                catch (Exception ex)
                {
                    _logger.LogError("[HttpGet] CIFClassController - > Get");
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






        [HttpPost]
        public async Task<ActionResult> PostNewCIFClass(PostCIFClassRequestModel CIFClassReq)
        {
            _logger.Log(LogLevel.Information, "[HttpGet] CIFClassController - > PostNewCIFClass");

            try{
                _logger.Log(LogLevel.Information, "Checking CIF_DESCClass.CIF_TYPE");
                if(null == _CifTypeRepository.GetById(CIFClassReq.CIF_TYPE))
                    return BadRequest( new PostCIFClassResponseModel { Message = "Invalid CIF_TYPE" , Successful=false});
                
                int newID = await _CifClassRepository.Create(new CIF_CLASS {
                    CIF_TYPE = CIFClassReq.CIF_TYPE,
                    Name = CIFClassReq.Name,
                    REFERENCE = CIFClassReq.REFERENCE});

                return Ok(new PostCIFClassResponseModel{ Message = String.Empty, Record=newID, Successful = true });
            }
            catch(Exception ex)
            {
                return BadRequest( new PostCIFClassResponseModel { Message = ex.Message , Successful=false});
            }
        }
    }
}