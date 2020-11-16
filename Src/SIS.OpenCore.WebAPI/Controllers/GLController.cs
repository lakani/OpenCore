using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SIS.OpenCore.Model;
using BAL = SIS.OpenCore.BL.Objects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SIS.OpenCore.WebAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class GLController : Controller
    {
        [HttpGet]
        public IEnumerable<DEF_GL> Get()
        {
            return BAL.GL.List(10);
        }

    }
}
