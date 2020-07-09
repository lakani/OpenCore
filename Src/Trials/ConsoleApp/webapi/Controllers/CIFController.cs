using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL.Objects;

namespace SIS.OpenCore.webapi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CIFController : ControllerBase
    {
        private readonly ILogger<CIFController> _logger;

        public CIFController(ILogger<CIFController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public IEnumerable<DEF_CIF> Get()
        {
            return Cif.List(10);
        }

        [HttpPost]
        public IHttpActionResult PostNewCIF(DEF_CIF def_CIF)
        {

        }
    }
}
