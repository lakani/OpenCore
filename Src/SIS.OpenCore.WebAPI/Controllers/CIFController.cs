using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SIS.OpenCore.DAL;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.BL.Objects;

namespace SIS.OpenCore.webapi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CIFController : ControllerBase
    {
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

        [HttpGet]
        public IEnumerable<DEF_CIF> Get()
        {
            return Cif.List(10);
        }

        [HttpGet]
        [Route("{Cif_NO}/{ACCT_TYPE}")]
        public IEnumerable<string> GetCK(string Cif_NO, string ACCT_TYPE)
        {
            if(ACCT_TYPE == "CK")
                return new string[] { Cif_NO + " CK1", Cif_NO + " ck2" };
            else
                return new string[] { Cif_NO + " FIXED", Cif_NO + " FIXED" };
        }

        [HttpGet("{Cif_NO}")]
        // GET: api/values/5
        public DEF_CIF Get(string Cif_NO)
        {
            return Cif.Get(Cif_NO);
        }

        [HttpPost]
        public ActionResult<DEF_CIF> PostNewCIF(DEF_CIF def_CIF)
        {
            string stCIFNo = Cif.Add_CIF(DateTime.Now, 1, def_CIF);
            def_CIF.CIF_NO = stCIFNo;
            return def_CIF;
        }


    }
}
