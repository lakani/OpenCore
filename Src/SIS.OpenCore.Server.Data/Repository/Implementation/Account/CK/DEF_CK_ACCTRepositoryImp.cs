using System.Linq;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.Account;
using SIS.OpenCore.Shared.Model.Objects.Account.CK;
using SIS.OpenCore.Shared.Model.GetRequest;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using System;

#nullable enable
namespace SIS.OpenCore.Server.Data.Repository.Implementation.Account.CK
{
    public class CIF_CK_ACCTRepositoryImp : GenericRepository<CIF_CK_ACCT>, ICIF_CK_ACCTRepository<CIF_CK_ACCT>
    {
        public CIF_CK_ACCTRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<CIF_CK_ACCT> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("CIF_CK_ACCTRepositoryImp");
        }

        /// <summary>
        /// Method <c>GetById</c> Get Record by the given ID, if the given ID is -1 then it returns Max Record.
        /// </summary>
        override public CIF_CK_ACCT? GetById(int id)
        {
            if(id == -1)
            {
                string? stMaxCode = (from r in _dbContext.CIF_CK_ACCT
                                    select r.ACCT_NO).Max();
                if(string.IsNullOrEmpty(stMaxCode))
                    return null;
                return new CIF_CK_ACCT{ ACCT_NO = stMaxCode} ;
            }
            else
            {
                CIF_CK_ACCT? Ret = (from t in _dbContext.CIF_CK_ACCT
                                    where t.DEF_ACCT_ID == id
                                    select t).FirstOrDefault();

                return Ret;
            }
        }

        virtual public IQueryable<BaseCIFACCT> Search(GetCIFAcctsRequestModel requesModel)
		{
			throw new NotImplementedException();
		}

        //virtual public TEntity? GetByCode(string code)
        override public CIF_CK_ACCT? GetByCode(string code)
        {
            CIF_CK_ACCT? Ret = (from t in _dbContext.CIF_CK_ACCT
                                where t.ACCT_NO == code
                                select t).FirstOrDefault();

            return Ret;
        }

        override public async Task<int> Create(CIF_CK_ACCT entity)
        {
            try
            {
                await _dbContext.Set<CIF_CK_ACCT>().AddAsync(entity);
                await _dbContext.SaveChangesAsync();
                return entity.GetPrimaryKey();
            }
            catch (Exception ex)
            {
                _logger.LogError("Error in CIF_CK_ACCTRepositoryImp:Create");
                _logger.LogError(ex.Message);
                if (ex.InnerException != null)
                    _logger.LogError(ex.InnerException.ToString());
                throw new Exception(ex.Message);
            }
        }


    }
}
