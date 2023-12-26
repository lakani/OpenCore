//using SIS.OpenCore.Server.Data.Repository.Implementation;
//using SIS.OpenCore.Server..Data.Repository.Implementation;


//using SIS.OpenCore.Server.Data.Repository.Implementation;
//using SIS.OpenCore.Server.Data.Repository.Interface;
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
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Server.Data.Repository.Implementation.Product;
using SIS.OpenCore.Shared.Model.Objects.Product;

namespace SIS.OpenCore.Server.Data.Repository
{
    public static class RepositoryServiceCollectionExtensions
	{
		public static IServiceCollection AddRepositories(this IServiceCollection services)
		{
			services.AddScoped<IUserDataRepository<Zone>, ZoneRepositoryImp>();
			services.AddScoped<IUserDataRepository<Company >, CompanyRepositoryImpl>();
			services.AddScoped<IUserDataRepository<Unit>, UnitRepositoryImp>();
			services.AddScoped<IUserDataRepository<Sector>, SectorRepositoryImp>();
			services.AddScoped<IUserDataRepository<Branch>, BranchRepositoryImp>();
			services.AddScoped<IUserDataRepository<Dep>, DepRepositoryImp>();
			services.AddScoped<ISettingsRepository<SettingsModel>, SettingsRepositoryImp>();
			
			// GL
			services.AddScoped<IGL_ACCTRepository<GL_ACCT>, GL_ACCTRepositoryImp>();
			services.AddScoped<ILUTRepository<LUT_GLLedgerNature>, GLLedgerNatureRepositoryImp>();
			// CIF
			services.AddScoped<ILUTRepository<LUT_CIF_TYPE>, LUT_CIF_TYPERepositoryImp>();
			services.AddScoped<ICIF_CLASSRepository<CIF_CLASS>, CIF_CLASSRepositoryImp>();
			services.AddScoped<ICIF_DESCRepository<CIF_DESC>, CIF_DESCRepositoryImp>();
			// ACCT Class
			services.AddScoped<ILUTRepository<LUT_ACCT_TYPE>, LUT_ACCT_TYPERepositoryImp>();
			services.AddScoped<ICIF_ACCT_CLASSRepository<CIF_ACCT_CLASS>, CIF_ACCT_CLASSRepositoryImp>();
			// CK ACCT 
			services.AddScoped<ICIF_CK_ACCTRepository<CIF_CK_ACCT>, CIF_CK_ACCTRepositoryImp>();
			services.AddScoped<ICurrencyRepository<Currency>, CurrencyRepositoryImp>();
			// Account Data Sources
			services.AddScoped<IACCTDataSourceRepository<ACCTDataSource>, ACCTDataSourceRepositoryImp>();
			// Product 
			services.AddScoped<ILUTRepository<LUT_PRODUCT_CHANNEL>, LUT_PRODUCT_CHANNELRepositoryImp>();
			services.AddScoped<ILUTRepository<LUT_PRODUCT_LOB>, LUT_PRODUCT_LOBRepositoryImp>();
			services.AddScoped<ILUTRepository<LUT_PRODUCT_FAMILY>, LUT_PRODUCT_FAMILYRepositoryImp>(); 
			services.AddScoped<IPRODUCT_CLASSRepository<PRODUCT_CLASS>, PRODUCT_CLASSRepositoryImp>();
			services.AddScoped<IPRODUCT_TYPERepository<PRODUCT_TYPE>, PRODUCT_TYPERepositoryImp>();
			services.AddScoped<IPRODUCT_SUB_TYPERepository<PRODUCT_SUB_TYPE>, PRODUCT_SUB_TYPERepositoryImp>();
			services.AddScoped<IPRODUCT_DESCRepository<PRODUCT_DESC>, PRODUCT_DESCRepositoryImp>();
			
			return services;
		}
	}
}
