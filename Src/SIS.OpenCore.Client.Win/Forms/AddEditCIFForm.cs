using SIS.OpenCore.Client.Adapter;
using SIS.OpenCore.Client.Win.Shared;
using SIS.OpenCore.Shared.Model.Objects.CIF;
using  SIS.OpenCore.Shared.Model.PostRequest;
using SIS.OpenCore.Shared.Model.Objects.UserData;
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

namespace SIS.OpenCore.Client.Win
{
    public partial class AddEditCIFForm : Form
    {
        private readonly HttpClient _httpClient;
        private readonly CIFAdapter _cifDataAdapter;
        private readonly CIFClassAdapter _cifClassAdapter;
        private readonly UserDataAdapter _userDataAdapter;
        private readonly FormAddEditMode _formAddEditMode;
        private readonly CIFTypeAdapter _cifTypeAdapter;

        public AddEditCIFForm()
        {
            InitializeComponent();
        }

        public AddEditCIFForm(FormAddEditMode formAddEditMode, HttpClient httpClient, CIFAdapter cifAdapter, CIFClassAdapter cifClassAdapter, 
        CIFTypeAdapter cifTypeAdapter, UserDataAdapter userDataDataAdapter) : this()
        {
            _httpClient = httpClient;
            _cifDataAdapter = cifAdapter;
            _userDataAdapter = userDataDataAdapter;
            _cifClassAdapter = cifClassAdapter;
            _formAddEditMode = formAddEditMode;
            _cifTypeAdapter = cifTypeAdapter;
        }

        private async void AddEditCIFForm_Load(object sender, EventArgs e)
        {
            try
            {
                var cifclasses = await _cifClassAdapter.List();
                if (cifclasses != null)
                {
                    foreach (CIF_CLASS cIF_CLASS in cifclasses)
                    {
                        cmbCIFClass.Items.Add(new ComboBoxItemShort { Value = cIF_CLASS.CIF_CLASS_ID, Text = cIF_CLASS.Name });
                    }
                }
                dateOpenDate.Value = DateTime.Now;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                //throw new Exception(ex.Message);
            }

        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            try{
                string stxtCIFNO = txtCIFNO.Text,
                                stxtSearchKEY = txtSearchKEY.Text,
                                stxtFirstName = txtFirstName.Text,
                                stxtMiddleName = txtMiddleName.Text,
                                stxtLastName = txtLastName.Text,
                                stxtFamilyName = txtFamilyName.Text,
                                stxtRSM = txtRSM.Text,
                                stxtReference = txtReference.Text;
                
                short nCIFClass = (cmbCIFClass.SelectedItem as ComboBoxItemShort).Value;

                var Response = await _cifDataAdapter.Create(     
                    new PostCIFRequestModel {   CIF_NO = stxtCIFNO , CLASS_ID = nCIFClass,  
                                                ClientTimeStamp= DateTime.Now, ClientVersion = "1", 
                                                CREATE_DT = DateTime.Now, FamilyName = stxtFamilyName,
                                                FirstName = stxtFirstName, LastName = stxtLastName,
                                                MiddleName = stxtMiddleName, REFERENCE = stxtReference ,
                                                RSM = stxtRSM, SearchKey = stxtSearchKEY, UserID = string.Empty});

                if(Response != null && Response.Successful)
                    MessageBox.Show("the new CIF = " + Response.Message);
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        private async void cmbCIFClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            short nCIFClass ;
            if (cmbCIFClass.SelectedItem != null)
            {
                nCIFClass = (cmbCIFClass.SelectedItem as ComboBoxItemShort).Value;
                var selectedCIFClass = await _cifClassAdapter.Search(nCIFClass);
                if(selectedCIFClass != null)
                {
                    txtCIFType.Text = selectedCIFClass.lUT_CIF_TYPE.Name;
                }
            }
        }
    }
}
