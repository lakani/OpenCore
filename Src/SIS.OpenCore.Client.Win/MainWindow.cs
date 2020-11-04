using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SIS.OpenCore.Client.Win
{
    public partial class MainWindow : Form
    {
        public MainWindow()
        {
            InitializeComponent();
        }
        private void LeftSideMenu_Click(object sender, EventArgs e)
        {
            MessageBox.Show("CIF");
            this.splitContainer.Panel2.
        }

        private void LeftSideMenu_AfterSelect(object sender, TreeViewEventArgs e)
        {
         
        }
    }
}
