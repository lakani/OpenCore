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

        //[HttpPost]
        ////[ProducesResponseType(StatusCodes.Status201Created)]
        ////[ProducesResponseType(StatusCodes.Status400BadRequest)]
        //public ActionResult<DEF_CIF> Create(DEF_CIF def_CIF)
        //{
        //    //pet.Id = _petsInMemoryStore.Any() ?
        //    //         _petsInMemoryStore.Max(p => p.Id) + 1 : 1;
        //    //_petsInMemoryStore.Add(pet);

        //    return CreatedAtAction(nameof(GetById), new { id = pet.Id }, pet);
        //}

        [HttpPost]
        public ActionResult<DEF_CIF> PostNewCIF(DEF_CIF def_CIF)
        {
            string stCIFNo = Cif.Add_CIF(DateTime.Now, 1, def_CIF);
            def_CIF.CIF_NO = stCIFNo;
            return def_CIF;
        }


    }
}
