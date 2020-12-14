using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using SIS.OpenCore.Model;
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
        [Route("{CIF_NO}/{ACCT_TYPE}")]
        public IEnumerable<DEF_CK_ACCT> GetCK(string CIF_NO, string ACCT_TYPE)
        {
            //if (ACCT_TYPE == "CK")
            {
                //var ret = CurrentAccount.List(CIF_NO, string.Empty, 10);
                //string[] r = new string[ret.Length];
                //for (int x = 0; x < r.Length; x++)
                //    r[x] = ret[x].ToString();
                return CurrentAccount.List(CIF_NO, string.Empty, 10); 
            }
            //else
                //return new string[] { CIF_NO + " FIXED", CIF_NO + " FIXED" };
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
