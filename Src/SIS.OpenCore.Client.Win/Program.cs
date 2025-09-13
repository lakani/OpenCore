using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SIS.OpenCore.Client.Adapter;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace SIS.OpenCore.Client.Win
{
    static class Program
    {
		/// <summary>
		///  The main entry point for the application.
		/// </summary>
		[STAThread]
        //static async Task Main()
		static void Main()
        {
            Application.SetHighDpiMode(HighDpiMode.SystemAware);
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

			var host = Host.CreateDefaultBuilder()
				.ConfigureAppConfiguration((context, builder) =>
				{
					// Add other configuration files...
					builder.AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
				})
				.ConfigureServices((context, services) =>
				{
					ConfigureServices(context.Configuration, services);
				})
				.ConfigureLogging(logging =>
				{
					// Add other loggers...
				})
				.Build();

			
			using (var servicesScope = host.Services.CreateScope())
			{
				var services = servicesScope.ServiceProvider;
				//var loginForm = services.GetRequiredService<LoginForm>();
				//var loginForm = services.GetRequiredService<LoginForm>();
				var mainForm = services.GetRequiredService<MainForm>();

				mainForm.StartPosition =  FormStartPosition.CenterScreen;
				mainForm.IsMdiContainer = true;
            	//mainForm.Show();

				// Set the form's StartPosition to CenterScreen
				// loginForm.StartPosition = FormStartPosition.CenterScreen;

				// Display the form
				Application.Run(mainForm);
			}
        }

		private static void ConfigureAdapters(IConfiguration configuration, HttpClient httpClient , Microsoft.Extensions.DependencyInjection.IServiceCollection services)
		{
			var UserDataURL = configuration["UserDataURL"];
			var GLAcctURL = configuration["GLAcctURL"];
			var CIFURL = configuration["CIFURL"];
			var CIFClassURL = configuration["CIFClassURL"];
			var CIFTypeURL = configuration["CIFTypeURL"];
			var ADAuthURL = configuration["ADAuth"];
			
			services.AddSingleton(s => new UserDataAdapter(UserDataURL, httpClient)) ;
			services.AddSingleton(s => new GLAcctAdapter(GLAcctURL, httpClient)) ;
			services.AddSingleton(s => new CIFAdapter(CIFURL, httpClient));
			services.AddSingleton(s => new CIFClassAdapter(CIFClassURL, httpClient));
			services.AddSingleton(s => new CIFTypeAdapter(CIFTypeURL, httpClient));
			services.AddSingleton(s => new AuthenticationAdapter(ADAuthURL, httpClient));
		}

		private static void ConfigureServices(IConfiguration configuration, Microsoft.Extensions.DependencyInjection.IServiceCollection services)
		{
			var ServerAddress = configuration["BaseAddress"];
			var httpClient = new HttpClient { BaseAddress = new Uri(ServerAddress) };

			services.AddScoped<MainForm>();
			services.AddScoped<LoginForm>();
			services.AddScoped<CIFList>();
			services.AddScoped<LUTConfigurationLists>();
			//services.AddScoped<GLListForm>();
			services.AddSingleton(sp => httpClient);
			
			ConfigureAdapters(configuration, httpClient, services);

		}
	}
}
