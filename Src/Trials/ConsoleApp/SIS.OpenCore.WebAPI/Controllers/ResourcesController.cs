using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;



namespace HealthVault.Service.Controllers
{
    //[Route("api/[controller]")]
    //[ApiController]
    public class ResourcesController : ControllerBase
    {
        /*
        active                  bool            Organization.active
        address                 string          Organization.address
        address-city            string          Organization.address.city
        address-country         string          Organization.address.country
        address-postalcode      string          Organization.address.postalCode
        address-state           string          Organization.address.state
        address-use             token           Organization.address.use
        endpoint                reference       Organization.endpoint
        identifier              token           Organization.identifier
        name                    string          Organization.name | Organization.alias
        partof                  reference       Organization.partOf
        phonetic                string          Organization.name
        type                    token           Organization.type
        */

        //[HttpGet]
        ////[Route("v1/api/resources/organization/")]
        //[Route("v1/api/resources/organization/")]
        //public IEnumerable<organization> GetOrganization(string Identifier,
        //                                                    string addressCity,
        //                                                    string partof,
        //                                                    string type,
        //                                                    string active,
        //                                                    string addressState)
        //{
        //    try
        //    {
        //        if (string.IsNullOrEmpty(Identifier) &&
        //            string.IsNullOrEmpty(addressCity) &&
        //            string.IsNullOrEmpty(partof) &&
        //            string.IsNullOrEmpty(type))
        //        {
        //            OrganizationDAL OrgDAL = new OrganizationDAL();
        //            return OrgDAL.GetAll();
        //        }

        //        else
        //        {
        //            organization FilterObj = organizationConverter.ConvertParams(Identifier, active, type, addressCity, addressState, partof);
        //            OrganizationDAL OrgDAL = new OrganizationDAL();
        //            return OrgDAL.Filter(FilterObj);
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        //[HttpGet]
        ////[Route("v1/api/resources/organization/")]
        //[Route("v1/api/resources/{or}/download")]
        //public IEnumerable<organization> GetDownload(string or/*string res/*, string Identifier*/)
        //{
        //    try
        //    {
        //        var rng = new Random();
        //        return Enumerable.Range(1, 5).Select(index => new organization
        //        {
        //            active = true,
        //            name = "Test"
        //        })
        //        .ToArray();
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }

        //}
    }
}