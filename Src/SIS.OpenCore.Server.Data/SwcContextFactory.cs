using System;
using System.IO;
using Duende.IdentityServer.EntityFramework.Options;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;


namespace SIS.OpenCore.Server.Data
{
    public class OperationalStoreOptionsMigrations : IOptions<OperationalStoreOptions>
    {
        public OperationalStoreOptions Value => new OperationalStoreOptions()
        {
                DeviceFlowCodes = new TableConfiguration("DeviceCodes"),
                EnableTokenCleanup = false,
                PersistedGrants = new TableConfiguration("PersistedGrants"),
                TokenCleanupBatchSize = 100,
                TokenCleanupInterval = 3600,
        };
    }


    internal class SwcContextFactory : IDesignTimeDbContextFactory<ApplicationDbContext>
    {
        public ApplicationDbContext CreateDbContext(string[] args)
        {
            DbContextOptionsBuilder<ApplicationDbContext> dbContextOptionsBuilder = new();
            IConfigurationRoot  configuration = new ConfigurationBuilder() 
                                    .AddJsonFile("appsettings.json", false)
                                    .Build();

            var connectionString = configuration.GetConnectionString("OpenCore") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
            dbContextOptionsBuilder.UseSqlServer(connectionString);
            return new ApplicationDbContext(dbContextOptionsBuilder.Options, new OperationalStoreOptionsMigrations());
        }
    }
}
