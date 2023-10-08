using System;
using System.Linq;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.OpenApi.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SIS.OpenCore.Server.Data.Repository;
using SIS.OpenCore.Server.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Identity;
using SIS.OpenCore.Shared.Model;
using System.IdentityModel.Tokens.Jwt;

namespace SIS.OpenCore.Server
{
	public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
			var connectionString = Configuration
                .GetConnectionString("OpenCore") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");

            services.AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(connectionString));
			services.AddDatabaseDeveloperPageExceptionFilter();

			services.AddDefaultIdentity<ApplicationUser>(options => options.SignIn.RequireConfirmedAccount = false)
	            .AddRoles<IdentityRole>()
	            .AddEntityFrameworkStores<ApplicationDbContext>();

			services.AddAuthorization(options =>
			{
				// TODO : Commented for now
				//options.AddPolicy(RoleType.Patient.ToString(), policy => policy.RequireRole(RoleType.Patient.ToString()));
			});


			services.AddIdentityServer()
	        .AddApiAuthorization<ApplicationUser, ApplicationDbContext>(opt =>
	        {
		        opt.IdentityResources["openid"].UserClaims.Add("name");
		        opt.ApiResources.Single().UserClaims.Add("name");
		        opt.IdentityResources["openid"].UserClaims.Add("role");
		        opt.ApiResources.Single().UserClaims.Add("role");
	        });
			JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Remove("role");

			services.AddAuthentication().AddIdentityServerJwt();

			services.AddControllersWithViews();
			services.AddRazorPages();
			// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
			services.AddEndpointsApiExplorer();
			
            services.AddLogging();

            services.AddControllers();

			services.AddRepositories();

			// Register the Swagger generator, defining 1 or more Swagger documents
			services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo
                {
                    Version = "v1",
                    Title = "OpenCore API V1",
                    Description = "OpenCore API V1",
                    //TermsOfService = new Uri("https://example.com/terms"),
                    Contact = new OpenApiContact
                    {
                        Name = "SIS",
                        Email = string.Empty,
                        Url = new Uri("https://twitter.com/spboyer"),
                    }
                });
            });

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            

			// Enable middleware to serve generated Swagger as a JSON endpoint.
			app.UseSwagger();

            app.UseHttpsRedirection();

            // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.),
            // specifying the Swagger JSON endpoint.
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "SIS OpenCore API V1");
                c.RoutePrefix = string.Empty;
            });


            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
