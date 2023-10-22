using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace HealthVault.Service.Controllers
{
    //[Route("api/[controller]")]
    //[ApiController]
    public class CodesController : ControllerBase
    {

        //[HttpGet]
        //public IEnumerable<WeatherForecast> Get()

        //[HttpGet]
        //[Route("v1/api/codes/city")]
        //public IEnumerable<lut_city> GetCity(string Identifier)
        //{
        //    try
        //    {
        //        CodesDAL codesDAL = new CodesDAL();

        //        if (string.IsNullOrEmpty(Identifier))
        //        {
        //            return codesDAL.lut_city_GetAll();
        //        }
        //        else
        //        {
        //            lut_city FilterObj = lut_cityConverter.ConvertParams(Identifier);
        //            return codesDAL.lut_city_Filter(FilterObj);
        //        }
        //    }
        //    catch
        //    {
        //        throw;
        //    }
        //}


        //lut_organizationtype
        //[HttpGet]
        //[Route("v1/api/codes/organizationtype")]
        //public IEnumerable<lut_organizationtype> GetOrganizationType(string identifier)
        //{
        //    try
        //    {
        //        CodesDAL codes = new CodesDAL();

        //        if (string.IsNullOrEmpty(identifier))
        //            return codes.lut_organizationtype_GetAll();
        //        else
        //        {
        //            lut_organizationtype FilterObj = lut_organizationtypeConverter.ConvertParams(identifier);
        //            return codes.lut_organizationtype_Filter(FilterObj);
        //        }
        //    }
        //    catch
        //    {
        //        throw;
        //    }
        //}

    }
}