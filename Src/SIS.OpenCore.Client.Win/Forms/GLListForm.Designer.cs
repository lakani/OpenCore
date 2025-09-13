namespace SIS.OpenCore.Client.Win
{
	partial class GLListForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(GLListForm));
            label1 = new System.Windows.Forms.Label();
            cbNature = new System.Windows.Forms.ComboBox();
            cbCompany = new System.Windows.Forms.ComboBox();
            label2 = new System.Windows.Forms.Label();
            cbZone = new System.Windows.Forms.ComboBox();
            label3 = new System.Windows.Forms.Label();
            cbDepartment = new System.Windows.Forms.ComboBox();
            label4 = new System.Windows.Forms.Label();
            cbSector = new System.Windows.Forms.ComboBox();
            label5 = new System.Windows.Forms.Label();
            cbBranch = new System.Windows.Forms.ComboBox();
            label6 = new System.Windows.Forms.Label();
            cbProduct = new System.Windows.Forms.ComboBox();
            label7 = new System.Windows.Forms.Label();
            cbUnit = new System.Windows.Forms.ComboBox();
            label8 = new System.Windows.Forms.Label();
            txtLedger = new System.Windows.Forms.TextBox();
            label9 = new System.Windows.Forms.Label();
            btnFind = new System.Windows.Forms.Button();
            GRID_GLs = new System.Windows.Forms.DataGridView();
            toolStripContainer1 = new System.Windows.Forms.ToolStripContainer();
            toolStrip1 = new System.Windows.Forms.ToolStrip();
            toolStripButton1 = new System.Windows.Forms.ToolStripButton();
            toolStripButton2 = new System.Windows.Forms.ToolStripButton();
            toolStripButton3 = new System.Windows.Forms.ToolStripButton();
            ID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Name = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Zone = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Branch = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Sector = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Department = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Unit = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Product = new System.Windows.Forms.DataGridViewTextBoxColumn();
            Ledger = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)GRID_GLs).BeginInit();
            toolStripContainer1.ContentPanel.SuspendLayout();
            toolStripContainer1.TopToolStripPanel.SuspendLayout();
            toolStripContainer1.SuspendLayout();
            toolStrip1.SuspendLayout();
            SuspendLayout();
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new System.Drawing.Point(55, 27);
            label1.Name = "label1";
            label1.Size = new System.Drawing.Size(43, 15);
            label1.TabIndex = 1;
            label1.Text = "Nature";
            // 
            // cbNature
            // 
            cbNature.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            cbNature.FormattingEnabled = true;
            cbNature.Location = new System.Drawing.Point(55, 44);
            cbNature.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            cbNature.Name = "cbNature";
            cbNature.Size = new System.Drawing.Size(224, 23);
            cbNature.TabIndex = 2;
            cbNature.SelectedIndexChanged += comboBox1_SelectedIndexChanged;
            // 
            // cbCompany
            // 
            cbCompany.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            cbCompany.FormattingEnabled = true;
            cbCompany.Location = new System.Drawing.Point(279, 44);
            cbCompany.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            cbCompany.Name = "cbCompany";
            cbCompany.Size = new System.Drawing.Size(224, 23);
            cbCompany.TabIndex = 4;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new System.Drawing.Point(279, 27);
            label2.Name = "label2";
            label2.Size = new System.Drawing.Size(59, 15);
            label2.TabIndex = 3;
            label2.Text = "Company";
            // 
            // cbZone
            // 
            cbZone.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            cbZone.FormattingEnabled = true;
            cbZone.Location = new System.Drawing.Point(509, 44);
            cbZone.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            cbZone.Name = "cbZone";
            cbZone.Size = new System.Drawing.Size(224, 23);
            cbZone.TabIndex = 6;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new System.Drawing.Point(503, 27);
            label3.Name = "label3";
            label3.Size = new System.Drawing.Size(34, 15);
            label3.TabIndex = 5;
            label3.Text = "Zone";
            // 
            // cbDepartment
            // 
            cbDepartment.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            cbDepartment.FormattingEnabled = true;
            cbDepartment.Location = new System.Drawing.Point(279, 98);
            cbDepartment.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            cbDepartment.Name = "cbDepartment";
            cbDepartment.Size = new System.Drawing.Size(224, 23);
            cbDepartment.TabIndex = 12;
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Location = new System.Drawing.Point(279, 81);
            label4.Name = "label4";
            label4.Size = new System.Drawing.Size(70, 15);
            label4.TabIndex = 11;
            label4.Text = "Department";
            // 
            // cbSector
            // 
            cbSector.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            cbSector.FormattingEnabled = true;
            cbSector.Location = new System.Drawing.Point(55, 98);
            cbSector.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            cbSector.Name = "cbSector";
            cbSector.Size = new System.Drawing.Size(224, 23);
            cbSector.TabIndex = 10;
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Location = new System.Drawing.Point(55, 81);
            label5.Name = "label5";
            label5.Size = new System.Drawing.Size(40, 15);
            label5.TabIndex = 9;
            label5.Text = "Sector";
            // 
            // cbBranch
            // 
            cbBranch.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            cbBranch.FormattingEnabled = true;
            cbBranch.Location = new System.Drawing.Point(733, 44);
            cbBranch.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            cbBranch.Name = "cbBranch";
            cbBranch.Size = new System.Drawing.Size(224, 23);
            cbBranch.TabIndex = 8;
            // 
            // label6
            // 
            label6.AutoSize = true;
            label6.Location = new System.Drawing.Point(733, 27);
            label6.Name = "label6";
            label6.Size = new System.Drawing.Size(44, 15);
            label6.TabIndex = 7;
            label6.Text = "Branch";
            // 
            // cbProduct
            // 
            cbProduct.FormattingEnabled = true;
            cbProduct.Location = new System.Drawing.Point(733, 98);
            cbProduct.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            cbProduct.Name = "cbProduct";
            cbProduct.Size = new System.Drawing.Size(224, 23);
            cbProduct.TabIndex = 16;
            // 
            // label7
            // 
            label7.AutoSize = true;
            label7.Location = new System.Drawing.Point(733, 81);
            label7.Name = "label7";
            label7.Size = new System.Drawing.Size(49, 15);
            label7.TabIndex = 15;
            label7.Text = "Product";
            // 
            // cbUnit
            // 
            cbUnit.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            cbUnit.FormattingEnabled = true;
            cbUnit.Location = new System.Drawing.Point(509, 98);
            cbUnit.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            cbUnit.Name = "cbUnit";
            cbUnit.Size = new System.Drawing.Size(224, 23);
            cbUnit.TabIndex = 14;
            // 
            // label8
            // 
            label8.AutoSize = true;
            label8.Location = new System.Drawing.Point(509, 81);
            label8.Name = "label8";
            label8.Size = new System.Drawing.Size(29, 15);
            label8.TabIndex = 13;
            label8.Text = "Unit";
            // 
            // txtLedger
            // 
            txtLedger.Location = new System.Drawing.Point(55, 156);
            txtLedger.Name = "txtLedger";
            txtLedger.Size = new System.Drawing.Size(448, 23);
            txtLedger.TabIndex = 17;
            // 
            // label9
            // 
            label9.AutoSize = true;
            label9.Location = new System.Drawing.Point(55, 138);
            label9.Name = "label9";
            label9.Size = new System.Drawing.Size(43, 15);
            label9.TabIndex = 18;
            label9.Text = "Ledger";
            // 
            // btnFind
            // 
            btnFind.Location = new System.Drawing.Point(792, 155);
            btnFind.Name = "btnFind";
            btnFind.Size = new System.Drawing.Size(165, 23);
            btnFind.TabIndex = 19;
            btnFind.Text = "Search";
            btnFind.UseVisualStyleBackColor = true;
            btnFind.Click += btnFind_Click;
            // 
            // GRID_GLs
            // 
            GRID_GLs.AllowUserToDeleteRows = false;
            GRID_GLs.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            GRID_GLs.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] { ID, Name, Zone, Branch, Sector, Department, Unit, Product, Ledger });
            GRID_GLs.Location = new System.Drawing.Point(23, 216);
            GRID_GLs.Name = "GRID_GLs";
            GRID_GLs.Size = new System.Drawing.Size(1138, 270);
            GRID_GLs.TabIndex = 20;
            // 
            // toolStripContainer1
            // 
            toolStripContainer1.BottomToolStripPanelVisible = false;
            // 
            // toolStripContainer1.ContentPanel
            // 
            toolStripContainer1.ContentPanel.AutoScroll = true;
            toolStripContainer1.ContentPanel.Controls.Add(GRID_GLs);
            toolStripContainer1.ContentPanel.Controls.Add(btnFind);
            toolStripContainer1.ContentPanel.Controls.Add(label9);
            toolStripContainer1.ContentPanel.Controls.Add(txtLedger);
            toolStripContainer1.ContentPanel.Controls.Add(cbProduct);
            toolStripContainer1.ContentPanel.Controls.Add(label7);
            toolStripContainer1.ContentPanel.Controls.Add(cbUnit);
            toolStripContainer1.ContentPanel.Controls.Add(label8);
            toolStripContainer1.ContentPanel.Controls.Add(cbDepartment);
            toolStripContainer1.ContentPanel.Controls.Add(label4);
            toolStripContainer1.ContentPanel.Controls.Add(cbSector);
            toolStripContainer1.ContentPanel.Controls.Add(label5);
            toolStripContainer1.ContentPanel.Controls.Add(cbBranch);
            toolStripContainer1.ContentPanel.Controls.Add(label6);
            toolStripContainer1.ContentPanel.Controls.Add(cbZone);
            toolStripContainer1.ContentPanel.Controls.Add(label3);
            toolStripContainer1.ContentPanel.Controls.Add(cbCompany);
            toolStripContainer1.ContentPanel.Controls.Add(label2);
            toolStripContainer1.ContentPanel.Controls.Add(cbNature);
            toolStripContainer1.ContentPanel.Controls.Add(label1);
            toolStripContainer1.ContentPanel.Size = new System.Drawing.Size(1188, 514);
            toolStripContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            toolStripContainer1.LeftToolStripPanelVisible = false;
            toolStripContainer1.Location = new System.Drawing.Point(0, 0);
            toolStripContainer1.Name = "toolStripContainer1";
            toolStripContainer1.RightToolStripPanelVisible = false;
            toolStripContainer1.Size = new System.Drawing.Size(1188, 539);
            toolStripContainer1.TabIndex = 21;
            toolStripContainer1.Text = "toolStripContainer1";
            // 
            // toolStripContainer1.TopToolStripPanel
            // 
            toolStripContainer1.TopToolStripPanel.Controls.Add(toolStrip1);
            // 
            // toolStrip1
            // 
            toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
            toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] { toolStripButton1, toolStripButton2, toolStripButton3 });
            toolStrip1.Location = new System.Drawing.Point(3, 0);
            toolStrip1.Name = "toolStrip1";
            toolStrip1.Size = new System.Drawing.Size(296, 25);
            toolStrip1.TabIndex = 0;
            // 
            // toolStripButton1
            // 
            toolStripButton1.Image = (System.Drawing.Image)resources.GetObject("toolStripButton1.Image");
            toolStripButton1.ImageTransparentColor = System.Drawing.Color.Magenta;
            toolStripButton1.Name = "toolStripButton1";
            toolStripButton1.Size = new System.Drawing.Size(116, 22);
            toolStripButton1.Text = "New GL Account";
            toolStripButton1.Click += toolStripButton1_Click;
            // 
            // toolStripButton2
            // 
            toolStripButton2.Image = (System.Drawing.Image)resources.GetObject("toolStripButton2.Image");
            toolStripButton2.ImageTransparentColor = System.Drawing.Color.Magenta;
            toolStripButton2.Name = "toolStripButton2";
            toolStripButton2.Size = new System.Drawing.Size(112, 22);
            toolStripButton2.Text = "Edit GL Account";
            // 
            // toolStripButton3
            // 
            toolStripButton3.Image = (System.Drawing.Image)resources.GetObject("toolStripButton3.Image");
            toolStripButton3.ImageTransparentColor = System.Drawing.Color.Magenta;
            toolStripButton3.Name = "toolStripButton3";
            toolStripButton3.Size = new System.Drawing.Size(56, 22);
            toolStripButton3.Text = "Close";
            // 
            // ID
            // 
            ID.HeaderText = "Nature";
            ID.Name = "ID";
            ID.ReadOnly = true;
            // 
            // Name
            // 
            Name.HeaderText = "Company";
            Name.Name = "Name";
            // 
            // Zone
            // 
            Zone.HeaderText = "Zone";
            Zone.Name = "Zone";
            // 
            // Branch
            // 
            Branch.HeaderText = "Branch";
            Branch.Name = "Branch";
            // 
            // Sector
            // 
            Sector.HeaderText = "Sector";
            Sector.Name = "Sector";
            // 
            // Department
            // 
            Department.HeaderText = "Department";
            Department.Name = "Department";
            // 
            // Unit
            // 
            Unit.HeaderText = "Unit";
            Unit.Name = "Unit";
            // 
            // Product
            // 
            Product.HeaderText = "Product";
            Product.Name = "Product";
            // 
            // Ledger
            // 
            Ledger.HeaderText = "Ledger";
            Ledger.Name = "Ledger";
            Ledger.Width = 170;
            // 
            // GLListForm
            // 
            AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            ClientSize = new System.Drawing.Size(1188, 539);
            Controls.Add(toolStripContainer1);
            Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            ShowInTaskbar = false;
            Text = "GLListForm";
            FormClosing += GLListForm_FormClosing;
            Load += GLListForm_Load;
            ((System.ComponentModel.ISupportInitialize)GRID_GLs).EndInit();
            toolStripContainer1.ContentPanel.ResumeLayout(false);
            toolStripContainer1.ContentPanel.PerformLayout();
            toolStripContainer1.TopToolStripPanel.ResumeLayout(false);
            toolStripContainer1.TopToolStripPanel.PerformLayout();
            toolStripContainer1.ResumeLayout(false);
            toolStripContainer1.PerformLayout();
            toolStrip1.ResumeLayout(false);
            toolStrip1.PerformLayout();
            ResumeLayout(false);
        }

        #endregion
        private System.Windows.Forms.Label label1;
		private System.Windows.Forms.ComboBox cbNature;
		private System.Windows.Forms.ComboBox cbCompany;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.ComboBox cbZone;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.ComboBox cbDepartment;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.ComboBox cbSector;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.ComboBox cbBranch;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.ComboBox cbProduct;
		private System.Windows.Forms.Label label7;
		private System.Windows.Forms.ComboBox cbUnit;
		private System.Windows.Forms.Label label8;
		private System.Windows.Forms.TextBox txtLedger;
		private System.Windows.Forms.Label label9;
		private System.Windows.Forms.Button btnFind;
		private System.Windows.Forms.DataGridView GRID_GLs;
		private System.Windows.Forms.ToolStripContainer toolStripContainer1;
		private System.Windows.Forms.ToolStrip toolStrip1;
		private System.Windows.Forms.ToolStripButton toolStripButton1;
		private System.Windows.Forms.ToolStripButton toolStripButton2;
        private System.Windows.Forms.ToolStripButton toolStripButton3;
        private System.Windows.Forms.DataGridViewTextBoxColumn ID;
        private System.Windows.Forms.DataGridViewTextBoxColumn Name;
        private System.Windows.Forms.DataGridViewTextBoxColumn Zone;
        private System.Windows.Forms.DataGridViewTextBoxColumn Branch;
        private System.Windows.Forms.DataGridViewTextBoxColumn Sector;
        private System.Windows.Forms.DataGridViewTextBoxColumn Department;
        private System.Windows.Forms.DataGridViewTextBoxColumn Unit;
        private System.Windows.Forms.DataGridViewTextBoxColumn Product;
        private System.Windows.Forms.DataGridViewTextBoxColumn Ledger;
    }
}