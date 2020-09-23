using NUnit.Framework;
using System;
using System.Linq;
using System.Collections.Generic;
using SIS.OpenCore.Model;
//using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.BL.Objects;
using SIS.OpenCore.BL.Transactions;
using SIS.OpenCore.DAL.Context;
using Microsoft.EntityFrameworkCore;

namespace SIS.OpenCore.UnitTesting
{
    public class CIF_Tests
    {
        // TODO : we need to run this setup only for the (CIF_Create) but for other tests , we do not
        [OneTimeSetUp]
        public void Setup()
        {
            //OpenCoreContext db = new OpenCoreContext();
            //db.Database.ExecuteSqlCommand("DELETE DEF_CIF");
            //db.Database.ExecuteSqlCommand("DELETE DEF_CIF_Company");
            //db.Database.ExecuteSqlCommand("TRUNCATE TABLE DEF_CIF");
            //db.Database.ExecuteSqlCommand("TRUNCATE TABLE DEF_CIF_Company");
        }

        [Test]
        public void CIF_Create()
        {
            for (int x = 0; x < 100; x++)
            {
                //Cif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed");
                string stNewCIF = Cif.Add_CIF(new DateTime(2020, 1, 1), 1, 1, "0001", "123456789", "Dalia Ahmed", "", "", "", "");
                string stNewCIFCompany = Cif.Add_CIF(new DateTime(2020, 1, 1), 2, 1, "0001", "123456789", "Dalia Ahmed", "", "", stNewCIF, stNewCIF);
                if (stNewCIFCompany != stNewCIF)
                    Assert.Fail("stNewCIF != stNewCIFCompany");
            }
        }
    }
    public class CIF_MISC_Tests
    {
        [OneTimeSetUp]
        public void Setup()
        {
            string stNewCIF = Cif.Add_CIF(new DateTime(2020, 1, 1), 1, 1, "0001", "123456789", "SOSO", "", "", "", "");
            string stNewCIFCompany = Cif.Add_CIF(new DateTime(2020, 1, 1), 2, 1, "0001", "123456789", "SOSO", "", "", stNewCIF, stNewCIF);
            if (stNewCIFCompany != stNewCIF)
                Assert.Fail("stNewCIF != stNewCIFCompany");
        }

        [Test]
        public void CIF_List()
        {
            DEF_CIF SearchKey = new DEF_CIF();

            SearchKey.FirstName = "SOSO";

            var dEF_CIFs = Cif.Find(SearchKey);
            if(dEF_CIFs.Count() == 0)
                Assert.Fail("Cant Find");
        }



    }
}
