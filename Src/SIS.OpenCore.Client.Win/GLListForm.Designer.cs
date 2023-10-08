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
			System.Windows.Forms.TreeNode treeNode1 = new System.Windows.Forms.TreeNode("Asset");
			System.Windows.Forms.TreeNode treeNode2 = new System.Windows.Forms.TreeNode("Liability");
			System.Windows.Forms.TreeNode treeNode3 = new System.Windows.Forms.TreeNode("Income");
			System.Windows.Forms.TreeNode treeNode4 = new System.Windows.Forms.TreeNode("Expense");
			System.Windows.Forms.TreeNode treeNode5 = new System.Windows.Forms.TreeNode("Capital");
			treeView1 = new System.Windows.Forms.TreeView();
			label1 = new System.Windows.Forms.Label();
			comboBox1 = new System.Windows.Forms.ComboBox();
			comboBox2 = new System.Windows.Forms.ComboBox();
			label2 = new System.Windows.Forms.Label();
			comboBox3 = new System.Windows.Forms.ComboBox();
			label3 = new System.Windows.Forms.Label();
			SuspendLayout();
			// 
			// treeView1
			// 
			treeView1.Location = new System.Drawing.Point(26, 334);
			treeView1.Name = "treeView1";
			treeNode1.Name = "AssetNode";
			treeNode1.Text = "Asset";
			treeNode2.Name = "LiabilityNode";
			treeNode2.Text = "Liability";
			treeNode3.Name = "IncomeNode";
			treeNode3.Text = "Income";
			treeNode4.Name = "ExpenseNode";
			treeNode4.Text = "Expense";
			treeNode5.Name = "CapitalNode";
			treeNode5.Text = "Capital";
			treeView1.Nodes.AddRange(new System.Windows.Forms.TreeNode[] { treeNode1, treeNode2, treeNode3, treeNode4, treeNode5 });
			treeView1.Size = new System.Drawing.Size(705, 260);
			treeView1.TabIndex = 0;
			// 
			// label1
			// 
			label1.AutoSize = true;
			label1.Location = new System.Drawing.Point(68, 40);
			label1.Name = "label1";
			label1.Size = new System.Drawing.Size(54, 20);
			label1.TabIndex = 1;
			label1.Text = "Nature";
			// 
			// comboBox1
			// 
			comboBox1.FormattingEnabled = true;
			comboBox1.Items.AddRange(new object[] { "Asset", "Liability", "Income", "Expense", "Capital" });
			comboBox1.Location = new System.Drawing.Point(68, 66);
			comboBox1.Name = "comboBox1";
			comboBox1.Size = new System.Drawing.Size(153, 27);
			comboBox1.TabIndex = 2;
			// 
			// comboBox2
			// 
			comboBox2.FormattingEnabled = true;
			comboBox2.Items.AddRange(new object[] { "Asset", "Liability", "Income", "Expense", "Capital" });
			comboBox2.Location = new System.Drawing.Point(258, 66);
			comboBox2.Name = "comboBox2";
			comboBox2.Size = new System.Drawing.Size(153, 27);
			comboBox2.TabIndex = 4;
			// 
			// label2
			// 
			label2.AutoSize = true;
			label2.Location = new System.Drawing.Point(258, 40);
			label2.Name = "label2";
			label2.Size = new System.Drawing.Size(43, 20);
			label2.TabIndex = 3;
			label2.Text = "Zone";
			// 
			// comboBox3
			// 
			comboBox3.FormattingEnabled = true;
			comboBox3.Items.AddRange(new object[] { "Asset", "Liability", "Income", "Expense", "Capital" });
			comboBox3.Location = new System.Drawing.Point(444, 66);
			comboBox3.Name = "comboBox3";
			comboBox3.Size = new System.Drawing.Size(153, 27);
			comboBox3.TabIndex = 6;
			// 
			// label3
			// 
			label3.AutoSize = true;
			label3.Location = new System.Drawing.Point(444, 40);
			label3.Name = "label3";
			label3.Size = new System.Drawing.Size(72, 20);
			label3.TabIndex = 5;
			label3.Text = "Company";
			// 
			// GLListForm
			// 
			AutoScaleDimensions = new System.Drawing.SizeF(8F, 19F);
			AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			ClientSize = new System.Drawing.Size(1481, 683);
			Controls.Add(comboBox3);
			Controls.Add(label3);
			Controls.Add(comboBox2);
			Controls.Add(label2);
			Controls.Add(comboBox1);
			Controls.Add(label1);
			Controls.Add(treeView1);
			Name = "GLListForm";
			Text = "GLListForm";
			ResumeLayout(false);
			PerformLayout();
		}

		#endregion

		private System.Windows.Forms.TreeView treeView1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.ComboBox comboBox1;
		private System.Windows.Forms.ComboBox comboBox2;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.ComboBox comboBox3;
		private System.Windows.Forms.Label label3;
	}
}