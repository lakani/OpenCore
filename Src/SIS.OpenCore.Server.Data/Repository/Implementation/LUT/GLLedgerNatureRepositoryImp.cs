using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;


    /*
        this main the 5 Ledger Accounting Nature 
        
        check the below link
        https://en.wikipedia.org/wiki/Debits_and_credits

        Kind of account	        Debit	    Credit
        Asset	                Increase	Decrease
        Liability	            Decrease	Increase
        Income/Revenue	        Decrease	Increase
        Expense/Cost/Dividend	Increase	Decrease
        Equity/Capital	        Decrease	Increase

    */

namespace SIS.OpenCore.Server.Data.Repository.Implementation.LUT
{
    public class GLLedgerNatureRepositoryImp : GenericRepository<LUT_GLLedgerNature>, ILUTRepository<LUT_GLLedgerNature> 
    {
        static LUT_GLLedgerNature [] _Nature = new LUT_GLLedgerNature[] {   
            new LUT_GLLedgerNature { ID = 1,   Name = "Asset",      CR_DR = "DR" },
            new LUT_GLLedgerNature { ID = 2,   Name = "Liability",  CR_DR = "CR" },
            new LUT_GLLedgerNature { ID = 2,   Name = "Income",     CR_DR = "CR" },
            new LUT_GLLedgerNature { ID = 2,   Name = "Expense",    CR_DR = "DR" },
            new LUT_GLLedgerNature { ID = 2,   Name = "Capital",    CR_DR = "CR" }};

        public GLLedgerNatureRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<LUT_GLLedgerNature> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("GLLedgerNatureRepositoryImp");
        }

        override public LUT_GLLedgerNature GetById(int id)
		{
            //return new LUT_GLLedgerNature{ CR_DR= 1};
			var Ret =   (from c in _Nature
                        where c.ID == id
                        select c).FirstOrDefault();
            return Ret;
		}

        override public LUT_GLLedgerNature GetByCode(string code)
		{
            //return new LUT_GLLedgerNature{ CR_DR= 1};
			var Ret =   (from c in _Nature
                        where c.Name == code
                        select c).FirstOrDefault();
            return Ret;
		}
    }
}


