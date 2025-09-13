using SIS.OpenCore.Client.Adapter;
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
using SIS.OpenCore.Shared.Model.Objects.UserData;
using SIS.OpenCore.Client.Win.Shared;
using SIS.OpenCore.Shared.Extensions;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace SIS.OpenCore.Client.Win
{
    public partial class GLListForm : Form
    {
        public readonly HttpClient _httpClient;
        public readonly GLAcctAdapter _glDataAdapter;
        public readonly UserDataAdapter _userDataDataAdapter;

        public GLListForm()
        {
            InitializeComponent();
        }

        public GLListForm(HttpClient httpClient, GLAcctAdapter glDataAdapter, UserDataAdapter userDataDataAdapter) : this()
        {
            _glDataAdapter = glDataAdapter;
            _httpClient = httpClient;
            _userDataDataAdapter = userDataDataAdapter;
        }

        private void treeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void OnClose(object sender, EventArgs e)
        {
            this.Hide();
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

        private async void GLListForm_Load(object sender, EventArgs e)
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

        private void GLListForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            this.Hide();
            e.Cancel = true;
        }

        private void UpDateValuesFromUI(ref short nCompanyNo, ref short nZone, ref short? nBranchNo , ref short? nSectorNo, 
        ref short? nDepNo , ref short? nUnitNO, ref short? nProductNo ,  ref short? nNature,  ref int? nLedgerNO )
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
            if (cbProduct.SelectedItem != null)
                nProductNo = (cbProduct.SelectedItem as ComboBoxItemShort).Value;
            if (cbNature.SelectedItem != null)
                nNature = (cbNature.SelectedItem as ComboBoxItemShort).Value;
            if (string.IsNullOrEmpty(txtLedger.Text) == false)
                nLedgerNO = MATH.ExtTryParse(txtLedger.Text);
        }
            
        private async void btnFind_Click(object sender, EventArgs e)
        {
            try
            {
                short nCompanyNo = 0 ,  nZone = 0;
                short? nBranchNo = null , nSectorNo = null, nDepNo = null , nUnitNO = null , nProductNo = null , nNature = null;
                int? nLedgerNO = null;

                // clear Rows First
                GRID_GLs.Rows.Clear();

                UpDateValuesFromUI(ref nCompanyNo, ref nZone, ref nBranchNo , ref nSectorNo , ref nDepNo,ref nUnitNO  ,ref nProductNo, ref nNature, ref nLedgerNO);

                var filtter = new GetGLLedgerRequestModel
                {
                    CompanyNo = nCompanyNo,
                    BranchNo = nBranchNo,
                    Zone = nZone,
                    SectorNo = nSectorNo,
                    DepNo = nDepNo,
                    UnitNO = nUnitNO,
                    Nature = nNature,
                    LedgerNO = nLedgerNO
                };

                var Res = await _glDataAdapter.Search(filtter);

                if (Res != null)
                {
                    if (Res.Successful)
                    {
                        foreach (var item in Res.Gls)
                        {
                            int nNewIndex = GRID_GLs.Rows.Add();
                            GRID_GLs.Rows[nNewIndex].Cells[0].Value = item.NatureObj.Name;
                            GRID_GLs.Rows[nNewIndex].Cells[1].Value = item.CompanyObj.Name;
                            if (item.ZoneObj != null)
                                GRID_GLs.Rows[nNewIndex].Cells[2].Value = item.ZoneObj.Name;
                            else
                                GRID_GLs.Rows[nNewIndex].Cells[2].Value = "0";

                            if (item.BranchObj != null)
                                GRID_GLs.Rows[nNewIndex].Cells[3].Value = item.BranchObj.Name;
                            else
                                GRID_GLs.Rows[nNewIndex].Cells[3].Value = "0";


                            if (item.SectorObj != null)
                                GRID_GLs.Rows[nNewIndex].Cells[4].Value = item.SectorObj.Name;
                            else
                                GRID_GLs.Rows[nNewIndex].Cells[4].Value = "0";

                            if (item.DepObj != null)
                                GRID_GLs.Rows[nNewIndex].Cells[5].Value = item.DepObj.Name;
                            else
                                GRID_GLs.Rows[nNewIndex].Cells[5].Value = "0";

                            if (item.UnitObj != null)
                                GRID_GLs.Rows[nNewIndex].Cells[6].Value = item.UnitObj.Name;
                            else
                                GRID_GLs.Rows[nNewIndex].Cells[6].Value = "0";

                            GRID_GLs.Rows[nNewIndex].Cells[8].Value = item.GL;

                        }
                    }
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

        }

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            AddEditGLAcctForm form = new AddEditGLAcctForm(FormAddEditMode.AddForm, _httpClient, _glDataAdapter, _userDataDataAdapter);
            form.ShowDialog(this);
        }
    }
}
