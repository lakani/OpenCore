using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
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
        static async Task Main()
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

			var services = host.Services;
			services.CreateScope();
			var mainForm = services.GetRequiredService<MainForm>();
			Application.Run(mainForm);
			
        }

		private static void ConfigureServices(IConfiguration configuration, Microsoft.Extensions.DependencyInjection.IServiceCollection services)
		{
			var ServerAddress = configuration["BaseAddress"];

			services.AddSingleton<MainForm>();
			services.AddSingleton<LUTConfigurationLists>();
			services.AddSingleton(sp => new HttpClient { BaseAddress = new Uri(ServerAddress) });
			
		}
	}
}
