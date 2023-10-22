using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using SIS.OpenCore.Shared.Model.Common;
using Microsoft.Extensions.Logging;




namespace SIS.OpenCore.Server.Data.Repository.Implementation.CIF
{
    public class DEF_CIFRepositoryImp : GenericRepository<DEF_CIF>, IDEF_CIFRepository<DEF_CIF>
    {
        public DEF_CIFRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_CIF> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("DEF_CIFRepositoryImp");
        }

        override public DEF_CIF GetByCode(string code)
		{
			var Ret =   (from c in _dbContext.DEF_CIF
                        where c.SearchKey == code || c.CIF_NO == code
                        select c).FirstOrDefault();

            return Ret;
		}

        public string GetMaxCIFNO()
        {
            string sMax =   (from r in _dbContext.DEF_CIF
                            select r.CIF_NO).Max();
            if (string.IsNullOrEmpty(sMax))
                sMax = 0.ToString();
            return sMax;
        }

    }
}


