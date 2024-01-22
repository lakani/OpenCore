using SIS.OpenCore.Client.Adapter;
using SIS.OpenCore.Client.Win.Shared;
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
using SIS.OpenCore.Shared.Model.GetRequest;
using SIS.OpenCore.Shared.Model.PostRequest;
using SIS.OpenCore.Shared.Model.Objects.UserData;

namespace SIS.OpenCore.Client.Win
{
    public partial class AddEditGLAcctForm : Form
    {
        public readonly HttpClient _httpClient;
        public readonly GLAcctAdapter _glDataAdapter;
        public readonly UserDataAdapter _userDataDataAdapter;
        public readonly FormAddEditMode _FormMode;

        public AddEditGLAcctForm()
        {
            InitializeComponent();
        }

        public AddEditGLAcctForm(FormAddEditMode formMode, HttpClient httpClient, GLAcctAdapter glDataAdapter, UserDataAdapter userDataDataAdapter) : this()
        {
            _FormMode = formMode;
            _glDataAdapter = glDataAdapter;
            _httpClient = httpClient;
            _userDataDataAdapter = userDataDataAdapter;
        }


        protected async Task<short> LoadUserData()
        {
            //Nature 
            cbNature.Items.Add(new ComboBoxItemShort { Value = 0, Text = "None" });
            cbNature.Items.Add(new ComboBoxItemShort { Value = 1, Text = "Asset" });
            cbNature.Items.Add(new ComboBoxItemShort { Value = 2, Text = "Liability" });
            cbNature.Items.Add(new ComboBoxItemShort { Value = 3, Text = "Income" });
            cbNature.Items.Add(new ComboBoxItemShort { Value = 4, Text = "Expense" });
            cbNature.Items.Add(new ComboBoxItemShort { Value = 5, Text = "Capital" });

            //Company
            cbCompany.Items.Add(new ComboBoxItemShort { Value = 0, Text = "None" });
            var CompanyList = await _userDataDataAdapter.GetCompanyListAsync();
            if (CompanyList != null && CompanyList.Records != null && CompanyList.Records.Count() > 0)
            {
                foreach (BaseUserData record in CompanyList.Records)
                {
                    cbCompany.Items.Add(new ComboBoxItemShort { Value = record.ID, Text = record.Name });
                }
            }

            //Zone
            cbZone.Items.Add(new ComboBoxItemShort { Value = 0, Text = "None" });
            var ZoneList = await _userDataDataAdapter.GetZoneListAsync();
            if (ZoneList != null && ZoneList.Records != null && ZoneList.Records.Any())
            {
                foreach (BaseUserData record in ZoneList.Records)
                {
                    cbZone.Items.Add(new ComboBoxItemShort { Value = record.ID, Text = record.Name });
                }
            }

            //Branch
            cbBranch.Items.Add(new ComboBoxItemShort { Value = 0, Text = "None" });
            var BranchList = await _userDataDataAdapter.GetBranchListAsync();
            if (BranchList != null && BranchList.Records != null && BranchList.Records.Any())
            {
                foreach (BaseUserData record in BranchList.Records)
                {
                    cbBranch.Items.Add(new ComboBoxItemShort { Value = record.ID, Text = record.Name });
                }
            }

            //Sector
            cbSector.Items.Add(new ComboBoxItemShort { Value = 0, Text = "None" });
            var SectorList = await _userDataDataAdapter.GetSectorListAsync();
            if (SectorList != null && SectorList.Records != null && SectorList.Records.Any())
            {
                foreach (BaseUserData record in SectorList.Records)
                {
                    cbSector.Items.Add(new ComboBoxItemShort { Value = record.ID, Text = record.Name });
                }
            }

            //Department
            cbDepartment.Items.Add(new ComboBoxItemShort { Value = 0, Text = "None" });
            var DepartmentList = await _userDataDataAdapter.GetDepListAsync();
            if (DepartmentList != null && DepartmentList.Records != null && DepartmentList.Records.Any())
            {
                foreach (BaseUserData record in DepartmentList.Records)
                {
                    cbDepartment.Items.Add(new ComboBoxItemShort { Value = record.ID, Text = record.Name });
                }
            }

            //Unit
            cbUnit.Items.Add(new ComboBoxItemShort { Value = 0, Text = "None" });
            var UnitList = await _userDataDataAdapter.GetUnitListAsync();
            if (UnitList != null && UnitList.Records != null && UnitList.Records.Any())
            {
                foreach (BaseUserData record in UnitList.Records)
                {
                    cbUnit.Items.Add(new ComboBoxItemShort { Value = record.ID, Text = record.Name });
                }
            }

            // TODO: Add Loading of Products // we need first to add a Lookup control

            return 0;
        }



        private async void AddEditGLAcctForm_Load(object sender, EventArgs e)
        {

            try
            {
                var OldCursor = this.Cursor;
                this.Cursor = Cursors.WaitCursor;

                await LoadUserData();

                this.Cursor = OldCursor;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        private void UpDateValuesFromUI(ref short nCompanyNo, ref short nZone, ref short nBranchNo , ref short nSectorNo, 
        ref short nDepNo , ref short nUnitNO, ref short nProductNo ,  ref short nNature,  ref int nLedgerNO )
        {
            if (cbCompany.SelectedItem != null)
                nCompanyNo = (cbCompany.SelectedItem as ComboBoxItemShort).Value;
            if (cbZone.SelectedItem != null)
                nZone = (cbZone.SelectedItem as ComboBoxItemShort).Value;
            if (cbBranch.SelectedItem != null)
                nBranchNo = (cbBranch.SelectedItem as ComboBoxItemShort).Value;
            if (cbSector.SelectedItem != null)
                nSectorNo = (cbSector.SelectedItem as ComboBoxItemShort).Value;
            if (cbDepartment.SelectedItem != null)
                nDepNo = (cbDepartment.SelectedItem as ComboBoxItemShort).Value;
            if (cbUnit.SelectedItem != null)
                nUnitNO = (cbUnit.SelectedItem as ComboBoxItemShort).Value;
            //if (cbProduct.SelectedItem != null)
            //    nProductNo = (cbProduct.SelectedItem as ComboBoxItemShort).Value;
            if (cbNature.SelectedItem != null)
                nNature = (cbNature.SelectedItem as ComboBoxItemShort).Value;
            if (string.IsNullOrEmpty(txtLedger.Text) == false)
                nLedgerNO = int.Parse(txtLedger.Text);
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                short nCompanyNo = 0 ,  nZone = 0;
                short nBranchNo = 0 , nSectorNo = 0, nDepNo = 0 , nUnitNO = 0 , nProductNo = 0 , nNature = 0;
                int nLedgerNO = 0;

                UpDateValuesFromUI(ref nCompanyNo, ref nZone, ref nBranchNo , ref nSectorNo , ref nDepNo,ref nUnitNO  ,ref nProductNo, ref nNature, ref nLedgerNO);

                var Ret = await _glDataAdapter.AddNewGLAcct(new PostGLLedgerRequestModel {
                    ClientTimeStamp = DateTime.Now, 
                    ClientVersion = "1", 
                    COMMENTS = txtComments.Text,
                    REFERENCE = txtReference.Text,
                    ResponseMaxRecords = 20,
                    CompanyNo = nCompanyNo,
                    BranchNo = nBranchNo,
                    Zone = nZone,
                    SectorNo = nSectorNo,
                    DepNo = nDepNo,
                    UnitNO = nUnitNO,
                    Nature = nNature,
                    LedgerNO = nLedgerNO
                });

                if(Ret != null && Ret.Successful)
                {
                    MessageBox.Show(Ret.GL);
                }
                else
                {
                    MessageBox.Show(Ret.Message);
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
