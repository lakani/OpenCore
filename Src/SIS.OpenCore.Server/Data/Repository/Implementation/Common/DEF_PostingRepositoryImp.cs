using IdentityModel;
using Microsoft.Extensions.Configuration;
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
    public partial  class DEF_PostingRepositoryImp : GenericRepository<DEF_Posting>, IDEF_PostingRepository<DEF_Posting>
    {
        public DEF_PostingRepositoryImp(ApplicationDbContext dbContext, IConfiguration configuration, ILogger<DEF_Posting> logger)
        : base(dbContext, configuration, logger)
        {
            logger.LogInformation("DEF_PostingRepositoryImp");
        }

    }
}