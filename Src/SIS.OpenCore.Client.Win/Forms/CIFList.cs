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
using SIS.OpenCore.Client.Adapter;
using SIS.OpenCore.Client.Win.Shared;
using SIS.OpenCore.Shared.Model.GetRequest;

namespace SIS.OpenCore.Client.Win
{
    public partial class CIFList : Form
    {
        private readonly HttpClient _httpClient;
        private readonly CIFAdapter _cifDataAdapter;
        private readonly UserDataAdapter _userDataDataAdapter;
        private readonly CIFClassAdapter _cifClassAdapter;
        private readonly CIFTypeAdapter _cifTypeAdapter;

        public CIFList()
        {
            InitializeComponent();
        }

        public CIFList(HttpClient httpClient, CIFAdapter cifAdapter, CIFClassAdapter cifClassAdapter, CIFTypeAdapter cifTypeAdapter, UserDataAdapter userDataDataAdapter) : this()
        {
            _httpClient = httpClient;
            _cifDataAdapter = cifAdapter;
            _userDataDataAdapter = userDataDataAdapter;
            _cifClassAdapter = cifClassAdapter;
            _cifTypeAdapter = cifTypeAdapter;
        }

        private async void btnSearch_Click(object sender, EventArgs e)
        {
            var SearchReq = new GetCIFRequestModel
            {
                CIF_NO = txtCIF.Text,
                ClientTimeStamp = DateTime.Now,
                ResponseMaxRecords = 20,
                ClientVersion = "1",
                FirstName = txtFirstName.Text,
                LastName = txtLastName.Text,
                SearchKey = txtSearchKEY.Text
            };

            cifGRID.Rows.Clear();
            var Res = await _cifDataAdapter.Search(SearchReq);
            if (Res != null)
            {
                if (Res.Successful)
                {
                    foreach (var item in Res.CIFArr)
                    {
                        int nNewIndex = cifGRID.Rows.Add();

                        cifGRID.Rows[nNewIndex].Cells[0].Value = item.CIF_NO;
                        cifGRID.Rows[nNewIndex].Cells[1].Value = item.SearchKey;
                        cifGRID.Rows[nNewIndex].Cells[2].Value = item.FirstName;
                        cifGRID.Rows[nNewIndex].Cells[3].Value = item.MiddleName;
                        cifGRID.Rows[nNewIndex].Cells[4].Value = item.LastName;
                        cifGRID.Rows[nNewIndex].Cells[5].Value = item.CIF_CLASS.lUT_CIF_TYPE.Name;
                        cifGRID.Rows[nNewIndex].Cells[6].Value = item.CIF_CLASS.Name;
                    }
                }
            }
        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void btnNewCIF_Click(object sender, EventArgs e)
        {
            AddEditCIFForm form = new AddEditCIFForm(FormAddEditMode.AddForm, _httpClient, _cifDataAdapter, _cifClassAdapter, _cifTypeAdapter, _userDataDataAdapter);
            form.ShowDialog(this);
        }
    }
}
