using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using SIS.OpenCore.Model;
using SIS.OpenCore.BL.Objects;
using SIS.OpenCore.Shared.Objects;

namespace SIS.OpenCore.webapi.Controllers
{
    [ApiController]
    [Route("API/[controller]")]
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
        [Route("/API/CIF")]
        public IEnumerable<DEF_CIF> Get(string Name = "", int cRecords = 0, string firstName = "", string lastName = "", 
                                        string SearchKey = "", string FamilyName = "", string MobileNumber = "", string NationalID = "")
        {
            DEF_CIF_PARAM cIF_PARAM = new DEF_CIF_PARAM();

            cIF_PARAM.Name = Name;
            cIF_PARAM.cRecords = cRecords;
            cIF_PARAM.FirstName = firstName;
            cIF_PARAM.LastName = lastName;
            cIF_PARAM.SearchKey = SearchKey;
            cIF_PARAM.FamilyName = FamilyName;
            cIF_PARAM.MobileNumber = MobileNumber;
            cIF_PARAM.NationalID = NationalID;

            return Cif.List(cIF_PARAM);
        }

        [HttpGet]
        [Route("API/{CIF_NO}/{ACCT_TYPE}")]
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
        // GET: api/CIF/5/
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
