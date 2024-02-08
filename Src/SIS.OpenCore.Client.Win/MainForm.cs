using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Http;
using System.Reflection;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SIS.OpenCore.Client.Adapter;
//using SIS.OpenCore .Model;

namespace SIS.OpenCore.Client.Win
{
	public partial class MainForm : Form
	{
		private readonly HttpClient _httpClient;
		private readonly IServiceProvider _serviceProvider;

		public MainForm()
		{
			InitializeComponent();
		}

		public MainForm(IServiceProvider serviceProvider, HttpClient httpClient) : this()
		{
			_httpClient = httpClient;
			_serviceProvider = serviceProvider;
		}

		private void listToolStripMenuItem_Click(object sender, EventArgs e)
		{
			try
			{
				var cifAdapter = _serviceProvider.GetService<CIFAdapter>();
				var cifClassAdapter = _serviceProvider.GetService<CIFClassAdapter>();
				var cifTypeAdapter = _serviceProvider.GetService<CIFTypeAdapter>();
				var userDataAdapter = _serviceProvider.GetService<UserDataAdapter>();
				
				CIFList cifListForm = new CIFList( _httpClient, cifAdapter, cifClassAdapter, cifTypeAdapter, userDataAdapter);
				cifListForm.Show(this);

			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}

		private void segmentsToolStripMenuItem_Click(object sender, EventArgs e)
		{

		}

		private void listToolStripMenuItem1_Click(object sender, EventArgs e)
		{
			try
			{
				var GLAcctAdapter = _serviceProvider.GetService<GLAcctAdapter>();
				var userDataAdapter = _serviceProvider.GetService<UserDataAdapter>();
				GLListForm gLListForm = new GLListForm( _httpClient, GLAcctAdapter, userDataAdapter);
				gLListForm.Show(this);

			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}

		private void staticDataToolStripMenuItem_Click(object sender, EventArgs e)
		{
			try
			{

				var configform = _serviceProvider.GetRequiredService<LUTConfigurationLists>();
				configform.Show(this);
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}
	}
}
