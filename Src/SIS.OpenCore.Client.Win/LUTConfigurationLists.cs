using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SIS.OpenCore.Client.Win
{
	public partial class LUTConfigurationLists : Form
	{
		private readonly HttpClient _httpClient;

		public LUTConfigurationLists()
		{
			InitializeComponent();
		}

		public LUTConfigurationLists(HttpClient httpClient) : this()
		{
			_httpClient = httpClient;
		}

		async private void OnSelectedAsync(object sender, EventArgs e)
		{
			listBoxData.Items.Clear();

			string selectedConfig = (string)cmbConfiguration.SelectedValue;
			if (selectedConfig is null)
				selectedConfig = cmbConfiguration.SelectedItem.ToString();

			if (selectedConfig == "Zone" || selectedConfig == "Company")
			{
				var result = await _httpClient.GetAsync("v1/api/OpenCore/system/Settings/StaticData/?Configuration=" + selectedConfig);
				var data = JsonSerializer.Deserialize<string[]>(await result.Content.ReadAsStringAsync());

				if (data != null && data.Length > 0)
					foreach (var item in data)
					{
						listBoxData.Items.Add(item);
					}
			}
		}

		private void OnAddNewRecord(object sender, EventArgs e)
		{
			//txtNewRecord
			if (btnAdd.Text == "Save")
			{
				if (listBoxData.SelectedIndex >= 0)
				{
					listBoxData.Items[listBoxData.SelectedIndex] = txtNewRecord.Text;
				}
			}
			else if (btnAdd.Text == "Add")
			{
				listBoxData.Items.Add(txtNewRecord.Text);
			}
		}

		private void OnDataListClick(object sender, EventArgs e)
		{
			//txtNewRecord
			//listBoxData
			//btnAdd
			return;
		}

		private void OnDataListMouseDblClick(object sender, MouseEventArgs e)
		{
			if (listBoxData.SelectedIndex < 0 || !listBoxData.GetItemRectangle(listBoxData.SelectedIndex).Contains(e.Location))
			{
				//MessageBox.Show("no click");
				btnAdd.Text = "Add";
				listBoxData.SelectedIndex = -1;
			}
			else
			{
				btnAdd.Text = "Save";
			}
		}

		private void OnClose(object sender, EventArgs e)
		{
			this.Close();
		}

		private void OnSave(object sender, EventArgs e)
		{
			//listBoxData.Items. 
		}
	}
}
