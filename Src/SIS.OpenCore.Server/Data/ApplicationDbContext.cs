using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Duende.IdentityServer.EntityFramework.Options;
using SIS.OpenCore.Shared.Model;
using SIS.OpenCore.Shared.Model.UserData;
using Microsoft.AspNetCore.ApiAuthorization.IdentityServer;
using SIS.OpenCore.Server.Data.Model.Config;
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
		public virtual DbSet<SettingsModel>  Settings { get; set; }

		protected override void OnModelCreating(ModelBuilder builder)
		{
			base.OnModelCreating(builder);

			builder.ApplyConfiguration(new RoleConfiguration());

			//new lut_CountryConfig().Configure(builder.Entity<lut_Country>());
			//new lut_CityConfig().Configure(builder.Entity<lut_City>());
			//new lut_PatientUserRelationshipConfig().Configure(builder.Entity<lut_PatientUserRelationship>());
			//new lut_AreaConfig().Configure(builder.Entity<lut_Area>());
			//new lut_SpecialityConfig().Configure(builder.Entity<lut_Speciality>());
			//new DoctorConfig().Configure(builder.Entity<Doctor>());
			//new PatientConfig().Configure(builder.Entity<Patient>());
			//new DoctorRecipientConfig().Configure(builder.Entity<DoctorRecipient>());
			
			new UserDataConfig().Configure(builder.Entity<DEF_Zone>());
			new UserDataConfig().Configure(builder.Entity<DEF_Dep>());
			new UserDataConfig().Configure(builder.Entity<DEF_Sector>());
			new UserDataConfig().Configure(builder.Entity<DEF_Unit>());
			new UserDataConfig().Configure(builder.Entity<DEF_Company>());
			new UserDataConfig().Configure(builder.Entity<DEF_Branch>());
			new DEF_GLConfig().Configure(builder.Entity<DEF_GL>());
			new SettingsModelConfig().Configure(builder.Entity<SettingsModel>());
		}
	}
}