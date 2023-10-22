using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Linq.Dynamic.Core;

namespace SIS.OpenCore.Server.Data.Repository.Implementation
{
    public class SettingsRepositoryImp : GenericRepository<SettingsModel>, ISettingsRepository<SettingsModel>
    {
        public SettingsRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<SettingsModel> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("SettingsRepositoryImp");
        }

        override public SettingsModel GetById(int id)
        {
            var Ret =   (from c in _dbContext.Settings
                        where c.VerID == id
                        select c).FirstOrDefault();
            return Ret;
        }

        /// <summary>
        ///  will always return the latest version
        /// </summary>
        /// <param name="requesModel"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        override public IQueryable<SettingsModel> Search(BaseRequesModel requesModel)
        {
            //
            var Ret =   _dbContext.Settings.OrderByDescending(e => e.VerID).Take(1);
            return Ret;
        }

        public int GetCIFFormatDigitsNum()
        {
            return GetCIFFormatDigits().Length;
        }

        public String GetCIFFormatDigits()
        {
            var SearchLast = this.Search(null);
            SettingsModel Last = SearchLast.First();
            
            return Last.CIFFormatDigits;
        }




    }
}


