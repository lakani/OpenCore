using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using SIS.OpenCore.Shared.Model.Common;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;




namespace SIS.OpenCore.Server.Data.Repository.Implementation.CIF
{
    public class CIF_DESCRepositoryImp : GenericRepository<CIF_DESC>, ICIF_DESCRepository<CIF_DESC>
    {
        public CIF_DESCRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<CIF_DESC> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("CIF_DESCRepositoryImp");
        }

        override public CIF_DESC GetByCode(string code)
		{
			var Ret =   (from c in _dbContext.CIF_DESC
                        where c.SearchKey == code || c.CIF_NO == code
                        select c)
                        .Include(a => a.CIF_CLASS)
                        .Include(a => a.CIF_CLASS.lUT_CIF_TYPE)
                        .FirstOrDefault();

            return Ret;
		}

        override public CIF_DESC GetById(int id)
		{
			if(id == -1)
            {
                string sMax =   (from r in _dbContext.CIF_DESC
                                select r.CIF_NO).Max();

                if (string.IsNullOrEmpty(sMax))
                    sMax = 0.ToString();
                return new CIF_DESC{ CIF_NO = sMax};
            }
            else
            {
                var Ret =   (from c in _dbContext.CIF_DESC
                            where c.CIF_ID == id
                            select c)
                            .Include(a => a.CIF_CLASS)
                            .Include(a => a.CIF_CLASS.lUT_CIF_TYPE)
                            .FirstOrDefault();

                return Ret;
            }
		}
    }
}


