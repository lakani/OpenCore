//using SIS.OpenCore.Server.Data.Repository.Implementation;
//using SIS.OpenCore.Server..Data.Repository.Implementation;


//using SIS.OpenCore.Server.Data.Repository.Implementation;
//using SIS.OpenCore.Server.Data.Repository.Interface;
using Microsoft.Extensions.ApiDescriptions;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Options;
using SIS.OpenCore.Server.Data.Repository.Interface;
using SIS.OpenCore.Server.Data.Repository.Implementation.UserData;
using SIS.OpenCore.Server.Data.Repository.Implementation.LUT;
using SIS.OpenCore.Server.Data.Repository.Implementation.CIF;

using SIS.OpenCore.Shared.Model.Objects.UserData;
using SIS.OpenCore.Shared.Model.PostRequest;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Objects.GL;
using SIS.OpenCore.Server.Data.Repository.Implementation;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using SIS.OpenCore.Shared.Model.Objects.Account;
using SIS.OpenCore.Server.Data.Repository.Implementation.Account;
using SIS.OpenCore.Shared.Model.Objects.Account.CK;
using SIS.OpenCore.Server.Data.Repository.Implementation.Account.CK;

namespace SIS.OpenCore.Server.Data.Repository
{
    public static class RepositoryServiceCollectionExtensions
	{
		public static IServiceCollection AddRepositories(this IServiceCollection services)
		{
			services.AddScoped<IUserDataRepository<DEF_Zone>, ZoneRepositoryImp>();
			services.AddScoped<IUserDataRepository<DEF_Company>, CompanyRepositoryImpl>();
			services.AddScoped<IUserDataRepository<DEF_Unit>, UnitRepositoryImp>();
			services.AddScoped<IUserDataRepository<DEF_Sector>, SectorRepositoryImp>();
			services.AddScoped<IUserDataRepository<DEF_Branch>, BranchRepositoryImp>();
			services.AddScoped<IUserDataRepository<DEF_Dep>, DepRepositoryImp>();
			services.AddScoped<ISettingsRepository<SettingsModel>, SettingsRepositoryImp>();
			
			// GL
			services.AddScoped<IDEF_GLRepository<DEF_GL>, DEF_GLRepositoryImp>();
			services.AddScoped<ILUTRepository<LUT_GLLedgerNature>, GLLedgerNatureRepositoryImp>();
			// CIF
			services.AddScoped<ILUTRepository<LUT_CIF_TYPE>, LUT_CIF_TYPERepositoryImp>();
			services.AddScoped<IDEF_CIF_CLASSRepository<DEF_CIF_CLASS>, DEF_CIF_CLASSRepositoryImp>();
			services.AddScoped<IDEF_CIFRepository<DEF_CIF>, DEF_CIFRepositoryImp>();
			// ACCT Class
			services.AddScoped<ILUTRepository<LUT_ACCT_TYPE>, LUT_ACCT_TYPERepositoryImp>();
			services.AddScoped<IDEF_ACCT_CLASSRepository<DEF_ACCT_CLASS>, DEF_ACCT_CLASSRepositoryImp>();
			// CK ACCT 
			services.AddScoped<IDEF_CK_ACCTRepository<DEF_CK_ACCT>, DEF_CK_ACCTRepositoryImp>();
			
			return services;
		}
	}
}
