using IdentityModel;
using Microsoft.Extensions.Configuration;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Shared.Model.Objects.GL;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SIS.OpenCore.Shared.Model.Common;

namespace SIS.OpenCore.Server.Data.Repository.Implementation
{
    public partial  class AccountingPostingRepositoryImp : GenericRepository<AccountingPosting>, IAccountingPostingRepository<AccountingPosting>
    {
        public AccountingPostingRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<AccountingPosting> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("AccountingPostingRepositoryImp");
        }

    }
}