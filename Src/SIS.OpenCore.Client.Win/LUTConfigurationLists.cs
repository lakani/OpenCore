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
using SIS.OpenCore.Client.Adapter;

namespace SIS.OpenCore.Client.Win
{
	public partial class LUTConfigurationLists : Form
	{
		private readonly HttpClient _httpClient;
		private readonly UserDataAdapter _userDataAdapter;

		//listBoxData
		public LUTConfigurationLists()
		{
			InitializeComponent();
		}

		public LUTConfigurationLists(HttpClient httpClient, UserDataAdapter userDataAdapter) : this()
		{
			_userDataAdapter = userDataAdapter;
			_httpClient = httpClient;
		}

		async private void OnSelectedAsync(object sender, EventArgs e)
		{
			try
			{
				listBoxData.Rows.Clear();

				string selectedConfig = (string)cmbConfiguration.SelectedValue;
				if (selectedConfig is null)
					selectedConfig = cmbConfiguration.SelectedItem.ToString();

				var data = await _userDataAdapter.GetUserDataAsync(selectedConfig);

				if (data != null && data.Records.Count() > 0)
				{
					if (listBoxData.Columns.Count <= 0) { int x = 10; }

					foreach (var item in data.Records)
					{
						int nNewIndex = listBoxData.Rows.Add();
						listBoxData.Rows[nNewIndex].Cells[0].Value = item.ID;
						listBoxData.Rows[nNewIndex].Cells[1].Value = item.Name;
					}
				}
			}
			catch (Exception ex)
			{
				string message = ex.Message;
				Console.WriteLine(message);
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
			//if (listBoxData.SelectedIndex < 0 || !listBoxData.GetItemRectangle(listBoxData.SelectedIndex).Contains(e.Location))
			//{
			//	//MessageBox.Show("no click");
			//	btnAdd.Text = "Add";
			//	listBoxData.SelectedIndex = -1;
			//}
			//else
			//{
			//	btnAdd.Text = "Save";
			//}
		}

		private void OnClose(object sender, EventArgs e)
		{
			this.Hide();
		}

		private async void OnSave(object sender, EventArgs e)
		{
			try
			{
				if (listBoxData.Rows.Count > 0)
				{
					string selectedConfig = (string)cmbConfiguration.SelectedValue;
					if (selectedConfig is null)
						selectedConfig = cmbConfiguration.SelectedItem.ToString();

					var cRwos = listBoxData.Rows.Count - 1;
					short[] ids = new short[cRwos];
					string[] values = new string[cRwos];

					for (int i = 0; i < cRwos; i++)
					{

						ids[i] = short.Parse(listBoxData.Rows[i].Cells[0].Value.ToString());
						values[i] = (string)listBoxData.Rows[i].Cells[1].Value;
					}

					await _userDataAdapter.PostUserDataAsync(selectedConfig, ids, values);
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}

		private void RowsAdded(object sender, DataGridViewRowsAddedEventArgs e)
		{
			for (short cloop = 0; cloop < e.RowCount; cloop++)
			{
				listBoxData.Rows[e.RowIndex + cloop].Cells[0].Value = 0;
			}
		}

		private void LUTConfigurationLists_FormClosing(object sender, FormClosingEventArgs e)
		{
			this.Hide();
			e.Cancel = true;
		}
	}
}
