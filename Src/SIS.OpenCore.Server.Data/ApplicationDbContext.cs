using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Duende.IdentityServer.EntityFramework.Options;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Server.Data.Context;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using SIS.OpenCore.Shared.Model.Objects.GL;
using SIS.OpenCore.Shared.Model.Objects.Account;
using SIS.OpenCore.Shared.Model.Objects.Account.CK;
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

		public virtual DbSet<Zone> Zone { get; set; }
		public virtual DbSet<Dep> Dep { get; set; }
		public virtual DbSet<Sector> Sector { get; set; }
		public virtual DbSet<Unit> Unit { get; set; }
		public virtual DbSet<Company > Company  { get; set; }
		public virtual DbSet<Branch> Branch { get; set; }
		public virtual DbSet<GL_ACCT> GL_ACCT { get; set; }
		public virtual DbSet<LUT_CIF_TYPE> LUT_CIF_TYPE { get; set; }
		public virtual DbSet<CIF_CLASS> CIF_CLASS { get; set; }
		public virtual DbSet<CIF_DESC> CIF_DESC { get; set; }
		public virtual DbSet<CIF_PERSONAL> CIF_PERSONAL { get; set; }
		public virtual DbSet<SettingsModel>  Settings { get; set; }
		public virtual DbSet<Currency>  Currency { get; set; }
		public virtual DbSet<ExchangeRates> ExchangeRates { get; set; }
		public virtual DbSet<LUT_ACCT_TYPE> LUT_ACCT_TYPE { get; set; }
		public virtual DbSet<CIF_ACCT_CLASS> CIF_ACCT_CLASS { get; set; }
		public virtual DbSet<CIF_CK_ACCT> CIF_CK_ACCT { get; set; }
		public virtual DbSet<AccountingPosting> AccountingPosting { get; set; }
		public virtual DbSet<ACCTDataSource> ACCTDataSource { get; set; }

		protected override void OnModelCreating(ModelBuilder builder)
		{
			base.OnModelCreating(builder);

			builder.ApplyConfiguration(new RoleConfiguration());

			new UserDataConfig().Configure(builder.Entity<Zone>());
			new UserDataConfig().Configure(builder.Entity<Dep>());
			new UserDataConfig().Configure(builder.Entity<Sector>());
			new UserDataConfig().Configure(builder.Entity<Unit>());
			new UserDataConfig().Configure(builder.Entity<Company >());
			new UserDataConfig().Configure(builder.Entity<Branch>());
			new GL_ACCTConfig().Configure(builder.Entity<GL_ACCT>());
			new SettingsModelConfig().Configure(builder.Entity<SettingsModel>());
			new LUT_CIF_TYPEConfig().Configure(builder.Entity<LUT_CIF_TYPE>());
			new CIF_CLASSConfig().Configure(builder.Entity<CIF_CLASS>());
			new CIF_DESCConfig().Configure(builder.Entity<CIF_DESC>());
			new CIF_PERSONALConfig().Configure(builder.Entity<CIF_PERSONAL>());
			new CurrencyConfig().Configure(builder.Entity<Currency>());
			new ExchangeRatesConfig().Configure(builder.Entity<ExchangeRates>());
			new LUT_ACCT_TYPEConfig().Configure(builder.Entity<LUT_ACCT_TYPE>());
			new CIF_ACCT_CLASSConfig().Configure(builder.Entity<CIF_ACCT_CLASS>());
			new CIF_CK_ACCTConfig().Configure(builder.Entity<CIF_CK_ACCT>());
			new AccountingPostingConfig().Configure(builder.Entity<AccountingPosting>());
			new ACCTDataSourceConfig().Configure(builder.Entity<ACCTDataSource>());
		}
	}
}