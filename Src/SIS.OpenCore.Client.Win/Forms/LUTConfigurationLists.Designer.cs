namespace SIS.OpenCore.Client.Win
{
	partial class LUTConfigurationLists
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
			cmbConfiguration = new System.Windows.Forms.ComboBox();
			label1 = new System.Windows.Forms.Label();
			button3 = new System.Windows.Forms.Button();
			button4 = new System.Windows.Forms.Button();
			listBoxData = new System.Windows.Forms.DataGridView();
			ID = new System.Windows.Forms.DataGridViewTextBoxColumn();
			Name = new System.Windows.Forms.DataGridViewTextBoxColumn();
			((System.ComponentModel.ISupportInitialize)listBoxData).BeginInit();
			SuspendLayout();
			// 
			// cmbConfiguration
			// 
			cmbConfiguration.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			cmbConfiguration.FormattingEnabled = true;
			cmbConfiguration.Items.AddRange(new object[] { "Zone", "Company", "Branch", "Sector", "Dep", "Unit" });
			cmbConfiguration.Location = new System.Drawing.Point(26, 39);
			cmbConfiguration.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
			cmbConfiguration.Name = "cmbConfiguration";
			cmbConfiguration.Size = new System.Drawing.Size(518, 23);
			cmbConfiguration.TabIndex = 0;
			cmbConfiguration.SelectionChangeCommitted += OnSelectedAsync;
			// 
			// label1
			// 
			label1.AutoSize = true;
			label1.Location = new System.Drawing.Point(26, 17);
			label1.Name = "label1";
			label1.Size = new System.Drawing.Size(78, 15);
			label1.TabIndex = 1;
			label1.Text = "Confifuration";
			// 
			// button3
			// 
			button3.Location = new System.Drawing.Point(295, 315);
			button3.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
			button3.Name = "button3";
			button3.Size = new System.Drawing.Size(80, 22);
			button3.TabIndex = 7;
			button3.Text = "Save";
			button3.UseVisualStyleBackColor = true;
			button3.Click += OnSave;
			// 
			// button4
			// 
			button4.Location = new System.Drawing.Point(200, 315);
			button4.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
			button4.Name = "button4";
			button4.Size = new System.Drawing.Size(80, 22);
			button4.TabIndex = 8;
			button4.Text = "Close";
			button4.UseVisualStyleBackColor = true;
			button4.Click += OnClose;
			// 
			// listBoxData
			// 
			listBoxData.AllowUserToDeleteRows = false;
			listBoxData.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			listBoxData.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] { ID, Name });
			listBoxData.Location = new System.Drawing.Point(26, 72);
			listBoxData.Name = "listBoxData";
			listBoxData.Size = new System.Drawing.Size(518, 233);
			listBoxData.TabIndex = 9;
			listBoxData.RowsAdded += RowsAdded;
			// 
			// ID
			// 
			ID.HeaderText = "ID";
			ID.Name = "ID";
			ID.ReadOnly = true;
			// 
			// Name
			// 
			Name.HeaderText = "Name";
			Name.Name = "Name";
			// 
			// LUTConfigurationLists
			// 
			AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
			AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			ClientSize = new System.Drawing.Size(580, 347);
			Controls.Add(listBoxData);
			Controls.Add(button4);
			Controls.Add(button3);
			Controls.Add(label1);
			Controls.Add(cmbConfiguration);
			Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
			Text = "static data maintenance";
			FormClosing += LUTConfigurationLists_FormClosing;
			((System.ComponentModel.ISupportInitialize)listBoxData).EndInit();
			ResumeLayout(false);
			PerformLayout();
		}

		#endregion

		private System.Windows.Forms.ComboBox cmbConfiguration;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Button button3;
		private System.Windows.Forms.Button button4;
		private System.Windows.Forms.DataGridView listBoxData;
		private System.Windows.Forms.DataGridViewTextBoxColumn ID;
		private System.Windows.Forms.DataGridViewTextBoxColumn Name;
	}
}