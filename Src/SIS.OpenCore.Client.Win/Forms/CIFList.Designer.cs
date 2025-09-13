
namespace SIS.OpenCore.Client.Win
{
    partial class CIFList
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.Label label2;
            System.Windows.Forms.Label label6;
            System.Windows.Forms.Label label7;
            System.Windows.Forms.Label label8;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CIFList));
            groupBox1 = new System.Windows.Forms.GroupBox();
            btnSearch = new System.Windows.Forms.Button();
            txtMobileNo = new System.Windows.Forms.TextBox();
            txtNationalID = new System.Windows.Forms.TextBox();
            txtLastName = new System.Windows.Forms.TextBox();
            txtSearchKEY = new System.Windows.Forms.TextBox();
            label4 = new System.Windows.Forms.Label();
            txtFirstName = new System.Windows.Forms.TextBox();
            txtCIF = new System.Windows.Forms.TextBox();
            label1 = new System.Windows.Forms.Label();
            groupBox2 = new System.Windows.Forms.GroupBox();
            cifGRID = new System.Windows.Forms.DataGridView();
            Column1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Column2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Column3 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Column4 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Column5 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Column6 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Column7 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
            toolStrip1 = new System.Windows.Forms.ToolStrip();
            btnNewCIF = new System.Windows.Forms.ToolStripButton();
            btnEditCIF = new System.Windows.Forms.ToolStripButton();
            btnClose = new System.Windows.Forms.ToolStripButton();
            label2 = new System.Windows.Forms.Label();
            label6 = new System.Windows.Forms.Label();
            label7 = new System.Windows.Forms.Label();
            label8 = new System.Windows.Forms.Label();
            groupBox1.SuspendLayout();
            groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)cifGRID).BeginInit();
            toolStripContainer1.ContentPanel.SuspendLayout();
            toolStripContainer1.TopToolStripPanel.SuspendLayout();
            toolStripContainer1.SuspendLayout();
            toolStrip1.SuspendLayout();
            SuspendLayout();
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new System.Drawing.Point(25, 87);
            label2.Name = "label2";
            label2.Size = new System.Drawing.Size(64, 15);
            label2.TabIndex = 2;
            label2.Text = "First Name";
            // 
            // label6
            // 
            label6.AutoSize = true;
            label6.Location = new System.Drawing.Point(381, 87);
            label6.Name = "label6";
            label6.Size = new System.Drawing.Size(63, 15);
            label6.TabIndex = 8;
            label6.Text = "Last Name";
            // 
            // label7
            // 
            label7.AutoSize = true;
            label7.Location = new System.Drawing.Point(381, 55);
            label7.Name = "label7";
            label7.Size = new System.Drawing.Size(66, 15);
            label7.TabIndex = 12;
            label7.Text = "National ID";
            // 
            // label8
            // 
            label8.AutoSize = true;
            label8.Location = new System.Drawing.Point(25, 55);
            label8.Name = "label8";
            label8.Size = new System.Drawing.Size(44, 15);
            label8.TabIndex = 14;
            label8.Text = "Mobile";
            // 
            // groupBox1
            // 
            groupBox1.Controls.Add(btnSearch);
            groupBox1.Controls.Add(txtMobileNo);
            groupBox1.Controls.Add(label8);
            groupBox1.Controls.Add(txtNationalID);
            groupBox1.Controls.Add(label7);
            groupBox1.Controls.Add(txtLastName);
            groupBox1.Controls.Add(label6);
            groupBox1.Controls.Add(txtSearchKEY);
            groupBox1.Controls.Add(label4);
            groupBox1.Controls.Add(txtFirstName);
            groupBox1.Controls.Add(label2);
            groupBox1.Controls.Add(txtCIF);
            groupBox1.Controls.Add(label1);
            groupBox1.Location = new System.Drawing.Point(12, 23);
            groupBox1.Name = "groupBox1";
            groupBox1.RightToLeft = System.Windows.Forms.RightToLeft.No;
            groupBox1.Size = new System.Drawing.Size(1008, 132);
            groupBox1.TabIndex = 0;
            groupBox1.TabStop = false;
            groupBox1.Text = "Fillter";
            // 
            // btnSearch
            // 
            btnSearch.Location = new System.Drawing.Point(685, 87);
            btnSearch.Name = "btnSearch";
            btnSearch.Size = new System.Drawing.Size(75, 23);
            btnSearch.TabIndex = 16;
            btnSearch.Text = "Search";
            btnSearch.UseVisualStyleBackColor = true;
            btnSearch.Click += btnSearch_Click;
            // 
            // txtMobileNo
            // 
            txtMobileNo.Location = new System.Drawing.Point(96, 55);
            txtMobileNo.Name = "txtMobileNo";
            txtMobileNo.Size = new System.Drawing.Size(216, 23);
            txtMobileNo.TabIndex = 15;
            // 
            // txtNationalID
            // 
            txtNationalID.Location = new System.Drawing.Point(452, 55);
            txtNationalID.Name = "txtNationalID";
            txtNationalID.Size = new System.Drawing.Size(216, 23);
            txtNationalID.TabIndex = 13;
            // 
            // txtLastName
            // 
            txtLastName.Location = new System.Drawing.Point(452, 87);
            txtLastName.Name = "txtLastName";
            txtLastName.Size = new System.Drawing.Size(216, 23);
            txtLastName.TabIndex = 9;
            // 
            // txtSearchKEY
            // 
            txtSearchKEY.Location = new System.Drawing.Point(452, 23);
            txtSearchKEY.Name = "txtSearchKEY";
            txtSearchKEY.Size = new System.Drawing.Size(216, 23);
            txtSearchKEY.TabIndex = 7;
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new System.Drawing.Point(381, 23);
            label4.Name = "label4";
            label4.Size = new System.Drawing.Size(65, 15);
            label4.TabIndex = 6;
            label4.Text = "Search KEY";
            // 
            // txtFirstName
            // 
            txtFirstName.Location = new System.Drawing.Point(96, 87);
            txtFirstName.Name = "txtFirstName";
            txtFirstName.Size = new System.Drawing.Size(216, 23);
            txtFirstName.TabIndex = 3;
            // 
            // txtCIF
            // 
            txtCIF.Location = new System.Drawing.Point(96, 23);
            txtCIF.Name = "txtCIF";
            txtCIF.Size = new System.Drawing.Size(216, 23);
            txtCIF.TabIndex = 1;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new System.Drawing.Point(25, 23);
            label1.Name = "label1";
            label1.Size = new System.Drawing.Size(24, 15);
            label1.TabIndex = 0;
            label1.Text = "CIF";
            // 
            // groupBox2
            // 
            groupBox2.Controls.Add(cifGRID);
            groupBox2.Location = new System.Drawing.Point(12, 161);
            groupBox2.Name = "groupBox2";
            groupBox2.Size = new System.Drawing.Size(1008, 288);
            groupBox2.TabIndex = 1;
            groupBox2.TabStop = false;
            groupBox2.Enter += groupBox2_Enter;
            // 
            // cifGRID
            // 
            cifGRID.AllowUserToAddRows = false;
            cifGRID.AllowUserToDeleteRows = false;
            cifGRID.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            cifGRID.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] { Column1, Column2, Column3, Column4, Column5, Column6, Column7 });
            cifGRID.Dock = System.Windows.Forms.DockStyle.Fill;
            cifGRID.Location = new System.Drawing.Point(3, 19);
            cifGRID.Name = "cifGRID";
            cifGRID.ReadOnly = true;
            cifGRID.Size = new System.Drawing.Size(1002, 266);
            cifGRID.TabIndex = 0;
            // 
            // Column1
            // 
            Column1.HeaderText = "CIF NO";
            Column1.Name = "Column1";
            Column1.ReadOnly = true;
            // 
            // Column2
            // 
            Column2.HeaderText = "Search Key";
            Column2.Name = "Column2";
            Column2.ReadOnly = true;
            // 
            // Column3
            // 
            Column3.HeaderText = "First Name";
            Column3.Name = "Column3";
            Column3.ReadOnly = true;
            // 
            // Column4
            // 
            Column4.HeaderText = "Middle Name";
            Column4.Name = "Column4";
            Column4.ReadOnly = true;
            // 
            // Column5
            // 
            Column5.HeaderText = "Last Name";
            Column5.Name = "Column5";
            Column5.ReadOnly = true;
            // 
            // Column6
            // 
            Column6.HeaderText = "Type";
            Column6.Name = "Column6";
            Column6.ReadOnly = true;
            // 
            // Column7
            // 
            Column7.HeaderText = "Class";
            Column7.Name = "Column7";
            Column7.ReadOnly = true;
            // 
            // toolStripContainer1
            // 
            toolStripContainer1.BottomToolStripPanelVisible = false;
            // 
            // toolStripContainer1.ContentPanel
            // 
            toolStripContainer1.ContentPanel.AutoScroll = true;
            toolStripContainer1.ContentPanel.Controls.Add(groupBox2);
            toolStripContainer1.ContentPanel.Controls.Add(groupBox1);
            toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(1044, 466);
            toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            toolStripContainer1.LeftToolStripPanelVisible = false;
            toolStripContainer1.Location = new System.Drawing.Point(0, 0);
            toolStripContainer1.Name = "toolStripContainer1";
            toolStripContainer1.RightToolStripPanelVisible = false;
            toolStripContainer1.Size = new System.Drawing.Size(1044, 491);
            toolStripContainer1.TabIndex = 2;
            toolStripContainer1.Text = "toolStripContainer1";
            // 
            // toolStripContainer1.TopToolStripPanel
            // 
            toolStripContainer1.TopToolStripPanel.Controls.Add(toolStrip1);
            // 
            // toolStrip1
            // 
            toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
            toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] { btnNewCIF, btnEditCIF, btnClose });
            toolStrip1.Location = new System.Drawing.Point(3, 0);
            toolStrip1.Name = "toolStrip1";
            toolStrip1.Size = new System.Drawing.Size(237, 25);
            toolStrip1.TabIndex = 0;
            // 
            // btnNewCIF
            // 
            btnNewCIF.Image = (System.Drawing.Image)resources.GetObject("btnNewCIF.Image");
            btnNewCIF.ImageTransparentColor = System.Drawing.Color.Magenta;
            btnNewCIF.Name = "btnNewCIF";
            btnNewCIF.Size = new System.Drawing.Size(71, 22);
            btnNewCIF.Text = "New CIF";
            btnNewCIF.Click += btnNewCIF_Click;
            // 
            // btnEditCIF
            // 
            btnEditCIF.Image = (System.Drawing.Image)resources.GetObject("btnEditCIF.Image");
            btnEditCIF.ImageTransparentColor = System.Drawing.Color.Magenta;
            btnEditCIF.Name = "btnEditCIF";
            btnEditCIF.Size = new System.Drawing.Size(67, 22);
            btnEditCIF.Text = "Edit CIF";
            // 
            // btnClose
            // 
            btnClose.Image = (System.Drawing.Image)resources.GetObject("btnClose.Image");
            btnClose.ImageTransparentColor = System.Drawing.Color.Magenta;
            btnClose.Name = "btnClose";
            btnClose.Size = new System.Drawing.Size(56, 22);
            btnClose.Text = "Close";
            // 
            // CIFList
            // 
            AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            ClientSize = new System.Drawing.Size(1044, 491);
            Controls.Add(toolStripContainer1);
            Name = "CIFList";
            Text = "CIFList";
            groupBox1.ResumeLayout(false);
            groupBox1.PerformLayout();
            groupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)cifGRID).EndInit();
            toolStripContainer1.ContentPanel.ResumeLayout(false);
            toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
            toolStripContainer1.TopToolStripPanel.PerformLayout();
            toolStripContainer1.ResumeLayout(false);
            toolStripContainer1.PerformLayout();
            toolStrip1.ResumeLayout(false);
            toolStrip1.PerformLayout();
            ResumeLayout(false);
        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox txtCIF;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtFirstName;
        private System.Windows.Forms.TextBox txtLastName;
        private System.Windows.Forms.TextBox txtSearchKEY;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtNationalID;
        private System.Windows.Forms.Button btnSearch;
        private System.Windows.Forms.TextBox txtMobileNo;
        private System.Windows.Forms.DataGridView cifGRID;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column1;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column2;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column3;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column4;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column5;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column6;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column7;
        private System.Windows.Forms.ToolStripContainer toolStripContainer1;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripButton btnNewCIF;
        private System.Windows.Forms.ToolStripButton btnEditCIF;
        private System.Windows.Forms.ToolStripButton btnClose;
    }
}