using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Extensions.DependencyInjection;
using SIS.OpenCore.Client;

namespace SIS.OpenCore.Client.Win
{
    public partial class CIFList : Form
    {
		private readonly HttpClient _httpClient;
		private readonly IServiceProvider _serviceProvider;

		public CIFList()
        {
            InitializeComponent();
        }

		public CIFList(IServiceProvider serviceProvider, HttpClient httpClient) : this()
		{
			_httpClient = httpClient;
			_serviceProvider = serviceProvider;
		}

		private void btnSearch_Click(object sender, EventArgs e)
        {
            
        }
    }
}
