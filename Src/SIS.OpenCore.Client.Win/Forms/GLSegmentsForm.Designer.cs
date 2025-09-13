namespace SIS.OpenCore.Client.Win
{
	partial class GLSegmentsForm
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
			listView1 = new System.Windows.Forms.ListView();
			SuspendLayout();
			// 
			// listView1
			// 
			listView1.Location = new System.Drawing.Point(56, 92);
			listView1.Name = "listView1";
			listView1.Size = new System.Drawing.Size(650, 278);
			listView1.TabIndex = 1;
			listView1.UseCompatibleStateImageBehavior = false;
			// 
			// GLSegmentsForm
			// 
			AutoScaleDimensions = new System.Drawing.SizeF(8F, 19F);
			AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			ClientSize = new System.Drawing.Size(800, 450);
			Controls.Add(listView1);
			Name = "GLSegmentsForm";
			Text = "GLSegmentsForm";
			ResumeLayout(false);
		}

		#endregion

		private System.Windows.Forms.ListView listView1;
	}
}