using NUnit.Framework;
using System;
using System.Linq;
using System.Collections.Generic;
using SIS.OpenCore.Model;
//using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.BL.Objects;
using SIS.OpenCore.BL.Transactions;
using SIS.OpenCore.DAL.Context;

namespace SIS.OpenCore.UnitTesting
{
    public class CIF_Tests
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void CIF_Create()
        {
            for (int x = 0; x < 100; x++)
            {
                //Cif.Add_CIF(new DateTime(2019,1,1), 1, 1, "0001", "123456789", "Ahmed");
                Cif.Add_CIF(new DateTime(2020, 1, 1), 1, 1, "0001", "123456789", "Dalia", "", "", "", "");
            }
        }
    }
}
