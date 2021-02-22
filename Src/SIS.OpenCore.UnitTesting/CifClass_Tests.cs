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
    class CifClass_Tests
    {
        [Test]
        public void CIF_Create()
        {
            CifClass.Add_CIF_CLASS(new DateTime(2020, 1, 1), 1, 1, "Test Class");
        }
    }
}
