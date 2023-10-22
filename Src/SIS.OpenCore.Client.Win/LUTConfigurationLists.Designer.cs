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
			label2 = new System.Windows.Forms.Label();
			listBoxData = new System.Windows.Forms.ListBox();
			txtNewRecord = new System.Windows.Forms.TextBox();
			btnAdd = new System.Windows.Forms.Button();
			button2 = new System.Windows.Forms.Button();
			button3 = new System.Windows.Forms.Button();
			button4 = new System.Windows.Forms.Button();
			SuspendLayout();
			// 
			// cmbConfiguration
			// 
			cmbConfiguration.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			cmbConfiguration.FormattingEnabled = true;
			cmbConfiguration.Items.AddRange(new object[] { "Zone", "Company", "Branch", "Sector", "Dep", "Unit" });
			cmbConfiguration.Location = new System.Drawing.Point(30, 50);
			cmbConfiguration.Name = "cmbConfiguration";
			cmbConfiguration.Size = new System.Drawing.Size(592, 27);
			cmbConfiguration.TabIndex = 0;
			cmbConfiguration.SelectionChangeCommitted += OnSelectedAsync;
			// 
			// label1
			// 
			label1.AutoSize = true;
			label1.Location = new System.Drawing.Point(30, 21);
			label1.Name = "label1";
			label1.Size = new System.Drawing.Size(96, 20);
			label1.TabIndex = 1;
			label1.Text = "Confifuration";
			// 
			// label2
			// 
			label2.AutoSize = true;
			label2.Location = new System.Drawing.Point(30, 103);
			label2.Name = "label2";
			label2.Size = new System.Drawing.Size(50, 20);
			label2.TabIndex = 2;
			label2.Text = "label2";
			// 
			// listBoxData
			// 
			listBoxData.FormattingEnabled = true;
			listBoxData.ItemHeight = 19;
			listBoxData.Location = new System.Drawing.Point(30, 138);
			listBoxData.Name = "listBoxData";
			listBoxData.Size = new System.Drawing.Size(592, 213);
			listBoxData.TabIndex = 3;
			listBoxData.Click += OnDataListClick;
			listBoxData.MouseDoubleClick += OnDataListMouseDblClick;
			// 
			// txtNewRecord
			// 
			txtNewRecord.Location = new System.Drawing.Point(30, 357);
			txtNewRecord.Name = "txtNewRecord";
			txtNewRecord.Size = new System.Drawing.Size(495, 26);
			txtNewRecord.TabIndex = 4;
			// 
			// btnAdd
			// 
			btnAdd.Location = new System.Drawing.Point(531, 357);
			btnAdd.Name = "btnAdd";
			btnAdd.Size = new System.Drawing.Size(91, 28);
			btnAdd.TabIndex = 5;
			btnAdd.Text = "Add";
			btnAdd.UseVisualStyleBackColor = true;
			btnAdd.Click += OnAddNewRecord;
			// 
			// button2
			// 
			button2.Location = new System.Drawing.Point(531, 104);
			button2.Name = "button2";
			button2.Size = new System.Drawing.Size(90, 28);
			button2.TabIndex = 6;
			button2.Text = "Delete";
			button2.UseVisualStyleBackColor = true;
			// 
			// button3
			// 
			button3.Location = new System.Drawing.Point(337, 399);
			button3.Name = "button3";
			button3.Size = new System.Drawing.Size(91, 28);
			button3.TabIndex = 7;
			button3.Text = "Save";
			button3.UseVisualStyleBackColor = true;
			button3.Click += OnSave;
			// 
			// button4
			// 
			button4.Location = new System.Drawing.Point(229, 399);
			button4.Name = "button4";
			button4.Size = new System.Drawing.Size(91, 28);
			button4.TabIndex = 8;
			button4.Text = "Close";
			button4.UseVisualStyleBackColor = true;
			button4.Click += OnClose;
			// 
			// LUTConfigurationLists
			// 
			AutoScaleDimensions = new System.Drawing.SizeF(8F, 19F);
			AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			ClientSize = new System.Drawing.Size(663, 439);
			Controls.Add(button4);
			Controls.Add(button3);
			Controls.Add(button2);
			Controls.Add(btnAdd);
			Controls.Add(txtNewRecord);
			Controls.Add(listBoxData);
			Controls.Add(label2);
			Controls.Add(label1);
			Controls.Add(cmbConfiguration);
			Name = "LUTConfigurationLists";
			Text = "static data maintenance";
			ResumeLayout(false);
			PerformLayout();
		}

		#endregion

		private System.Windows.Forms.ComboBox cmbConfiguration;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.ListBox listBox1;
		private System.Windows.Forms.TextBox txtNewRecord;
		private System.Windows.Forms.Button btnAdd;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Button button3;
		private System.Windows.Forms.Button button4;
		private System.Windows.Forms.ListBox listBoxData;
	}
}