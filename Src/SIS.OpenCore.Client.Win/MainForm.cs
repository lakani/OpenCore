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
			_serviceProvider.GetService<CIFList>().Show();
			//CIFList list = new CIFList();
			//list.Show(this);
		}

		async private void MainForm_Load(object sender, EventArgs e)
		{
			//var result = await _httpClient.GetAsync("/v1/api/OpenCore/GL/GL_ACCT");
			//var GlArr = JsonSerializer.Deserialize<GL_ACCT[]>(await result.Content.ReadAsStringAsync());
			//	new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

			//textBox1.Text += GlArr[0].GL.ToString() + Environment.NewLine;
			//textBox1.Text += GlArr[1].GL.ToString() + Environment.NewLine;
			//textBox1.Text += GlArr[2].GL.ToString() + Environment.NewLine;
		}

		private void segmentsToolStripMenuItem_Click(object sender, EventArgs e)
		{

		}

		private void listToolStripMenuItem1_Click(object sender, EventArgs e)
		{
			GLListForm form = new GLListForm();
			form.Show(this);
		}

		private void staticDataToolStripMenuItem_Click(object sender, EventArgs e)
		{
			//IServiceProvider serviceProvider = (IServiceProvider)Application.OpenForms[0].GetType().GetProperty("ApplicationServices", BindingFlags.NonPublic | BindingFlags.Instance).GetValue(Application.OpenForms[0], null);
			//IServiceProvider serviceProvider = (IServiceProvider)this.GetService(typeof(IServiceProvider));
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
