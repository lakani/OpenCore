using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Duende.IdentityServer.EntityFramework.Options;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using SIS.OpenCore.Shared.Model.Objects.GL;
using SIS.OpenCore.Shared.Model.Objects.Account;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using Microsoft.AspNetCore.ApiAuthorization.IdentityServer;
using SIS.OpenCore.Server.Data.Config;
using SIS.OpenCore.Server.Data.Config.CIF;
using SIS.OpenCore.Server.Data.Config.Common;
using SIS.OpenCore.Server.Data.Config.Account;
using System.Reflection.Emit;

namespace SIS.OpenCore.Server.Data
{
	public class ApplicationDbContext : ApiAuthorizationDbContext<ApplicationUser>
	{
		//public IConfiguration

		public ApplicationDbContext(
			DbContextOptions options,
			IOptions<OperationalStoreOptions> operationalStoreOptions) : base(options, operationalStoreOptions)
		{
			
		}

		// the below for initial
		// dotnet ef migrations add Initial --context HealthvaultContext

		// to Generate Migration
		// dotnet ef migrations add MyFirstMigration --context BloggingContext
		// dotnet ef migrations add SIS.OpenCore_MIGRATIONS_0001 --context ApplicationDbContext

		// to list all migrations 
		// dotnet ef migrations list

		// the below for subsecuent migrations
		// dotnet ef database update --context ApplicationDbContext
		// https://learn.microsoft.com/en-us/ef/core/modeling/

		public virtual DbSet<DEF_Zone> DEF_Zone { get; set; }
		public virtual DbSet<DEF_Dep> DEF_Dep { get; set; }
		public virtual DbSet<DEF_Sector> DEF_Sector { get; set; }
		public virtual DbSet<DEF_Unit> DEF_Unit { get; set; }
		public virtual DbSet<DEF_Company> DEF_Company { get; set; }
		public virtual DbSet<DEF_Branch> DEF_Branch { get; set; }
		public virtual DbSet<DEF_GL> DEF_GL { get; set; }
		public virtual DbSet<LUT_CIF_TYPE> LUT_CIF_TYPE { get; set; }
		public virtual DbSet<DEF_CIF_CLASS> DEF_CIF_CLASS { get; set; }
		public virtual DbSet<DEF_CIF> DEF_CIF { get; set; }
		public virtual DbSet<DEF_CIF_PERSONAL> DEF_CIF_PERSONAL { get; set; }
		public virtual DbSet<SettingsModel>  Settings { get; set; }
		public virtual DbSet<DEF_Currency>  DEF_Currency { get; set; }
		public virtual DbSet<ExchangeRates> ExchangeRates { get; set; }
		public virtual DbSet<LUT_ACCT_TYPE> LUT_ACCT_TYPE { get; set; }
		public virtual DbSet<DEF_ACCT_CLASS> DEF_ACCT_CLASS { get; set; }

		protected override void OnModelCreating(ModelBuilder builder)
		{
			base.OnModelCreating(builder);

			builder.ApplyConfiguration(new RoleConfiguration());

			new UserDataConfig().Configure(builder.Entity<DEF_Zone>());
			new UserDataConfig().Configure(builder.Entity<DEF_Dep>());
			new UserDataConfig().Configure(builder.Entity<DEF_Sector>());
			new UserDataConfig().Configure(builder.Entity<DEF_Unit>());
			new UserDataConfig().Configure(builder.Entity<DEF_Company>());
			new UserDataConfig().Configure(builder.Entity<DEF_Branch>());
			new DEF_GLConfig().Configure(builder.Entity<DEF_GL>());
			new SettingsModelConfig().Configure(builder.Entity<SettingsModel>());
			new LUT_CIF_TYPEConfig().Configure(builder.Entity<LUT_CIF_TYPE>());
			new DEF_CIF_CLASSConfig().Configure(builder.Entity<DEF_CIF_CLASS>());
			new DEF_CIFConfig().Configure(builder.Entity<DEF_CIF>());
			new DEF_CIF_PERSONALConfig().Configure(builder.Entity<DEF_CIF_PERSONAL>());
			new DEF_CurrencyConfig().Configure(builder.Entity<DEF_Currency>());
			new ExchangeRatesConfig().Configure(builder.Entity<ExchangeRates>());
			new LUT_ACCT_TYPEConfig().Configure(builder.Entity<LUT_ACCT_TYPE>());
			new DEF_ACCT_CLASSConfig().Configure(builder.Entity<DEF_ACCT_CLASS>());
		}
	}
}