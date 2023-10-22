
namespace SIS.OpenCore.Client.Win
{
	partial class MainForm
	{
		/// <summary>
		///  Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		///  Clean up any resources being used.
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
		///  Required method for Designer support - do not modify
		///  the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			menuStrip1 = new System.Windows.Forms.MenuStrip();
			fIleToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			listToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			gLToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			listToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
			segmentsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			configurationToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			staticDataToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			menuStrip1.SuspendLayout();
			SuspendLayout();
			// 
			// menuStrip1
			// 
			menuStrip1.ImageScalingSize = new System.Drawing.Size(19, 19);
			menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] { fIleToolStripMenuItem, gLToolStripMenuItem, configurationToolStripMenuItem });
			menuStrip1.Location = new System.Drawing.Point(0, 0);
			menuStrip1.Name = "menuStrip1";
			menuStrip1.Size = new System.Drawing.Size(914, 28);
			menuStrip1.TabIndex = 1;
			menuStrip1.Text = "menuStrip1";
			// 
			// fIleToolStripMenuItem
			// 
			fIleToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { listToolStripMenuItem });
			fIleToolStripMenuItem.Name = "fIleToolStripMenuItem";
			fIleToolStripMenuItem.Size = new System.Drawing.Size(43, 24);
			fIleToolStripMenuItem.Text = "CIF";
			// 
			// listToolStripMenuItem
			// 
			listToolStripMenuItem.Name = "listToolStripMenuItem";
			listToolStripMenuItem.Size = new System.Drawing.Size(217, 26);
			listToolStripMenuItem.Text = "List";
			listToolStripMenuItem.Click += listToolStripMenuItem_Click;
			// 
			// gLToolStripMenuItem
			// 
			gLToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { listToolStripMenuItem1, segmentsToolStripMenuItem });
			gLToolStripMenuItem.Name = "gLToolStripMenuItem";
			gLToolStripMenuItem.Size = new System.Drawing.Size(40, 24);
			gLToolStripMenuItem.Text = "GL";
			// 
			// listToolStripMenuItem1
			// 
			listToolStripMenuItem1.Name = "listToolStripMenuItem1";
			listToolStripMenuItem1.Size = new System.Drawing.Size(217, 26);
			listToolStripMenuItem1.Text = "&List";
			listToolStripMenuItem1.Click += listToolStripMenuItem1_Click;
			// 
			// segmentsToolStripMenuItem
			// 
			segmentsToolStripMenuItem.Name = "segmentsToolStripMenuItem";
			segmentsToolStripMenuItem.Size = new System.Drawing.Size(217, 26);
			segmentsToolStripMenuItem.Text = "Se&gments";
			segmentsToolStripMenuItem.Click += segmentsToolStripMenuItem_Click;
			// 
			// configurationToolStripMenuItem
			// 
			configurationToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { staticDataToolStripMenuItem });
			configurationToolStripMenuItem.Name = "configurationToolStripMenuItem";
			configurationToolStripMenuItem.Size = new System.Drawing.Size(114, 24);
			configurationToolStripMenuItem.Text = "Configuration";
			// 
			// staticDataToolStripMenuItem
			// 
			staticDataToolStripMenuItem.Name = "staticDataToolStripMenuItem";
			staticDataToolStripMenuItem.Size = new System.Drawing.Size(217, 26);
			staticDataToolStripMenuItem.Text = "Static Data";
			staticDataToolStripMenuItem.Click += staticDataToolStripMenuItem_Click;
			// 
			// MainForm
			// 
			AutoScaleDimensions = new System.Drawing.SizeF(8F, 19F);
			AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			ClientSize = new System.Drawing.Size(914, 570);
			Controls.Add(menuStrip1);
			IsMdiContainer = true;
			MainMenuStrip = menuStrip1;
			Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
			Name = "MainForm";
			Text = "SIS.OpenCore.Client.Win";
			Load += MainForm_Load;
			menuStrip1.ResumeLayout(false);
			menuStrip1.PerformLayout();
			ResumeLayout(false);
			PerformLayout();
		}

		#endregion

		private System.Windows.Forms.MenuStrip menuStrip1;
		private System.Windows.Forms.ToolStripMenuItem fIleToolStripMenuItem;
		private System.Windows.Forms.ToolStripMenuItem listToolStripMenuItem;
		private System.Windows.Forms.ToolStripMenuItem gLToolStripMenuItem;
		private System.Windows.Forms.ToolStripMenuItem listToolStripMenuItem1;
		private System.Windows.Forms.ToolStripMenuItem segmentsToolStripMenuItem;
		private System.Windows.Forms.ToolStripMenuItem configurationToolStripMenuItem;
		private System.Windows.Forms.ToolStripMenuItem staticDataToolStripMenuItem;
	}
}

