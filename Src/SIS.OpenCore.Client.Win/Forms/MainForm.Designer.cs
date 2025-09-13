
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
            sPaymentToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            mT202ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            MenuItem_MT202_List = new System.Windows.Forms.ToolStripMenuItem();
            MenuItem_MT202_New = new System.Windows.Forms.ToolStripMenuItem();
            menuStrip1.SuspendLayout();
            SuspendLayout();
            // 
            // menuStrip1
            // 
            menuStrip1.ImageScalingSize = new System.Drawing.Size(19, 19);
            menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] { fIleToolStripMenuItem, gLToolStripMenuItem, configurationToolStripMenuItem, sPaymentToolStripMenuItem });
            menuStrip1.Location = new System.Drawing.Point(0, 0);
            menuStrip1.Name = "menuStrip1";
            menuStrip1.Padding = new System.Windows.Forms.Padding(5, 2, 0, 2);
            menuStrip1.Size = new System.Drawing.Size(800, 24);
            menuStrip1.TabIndex = 1;
            menuStrip1.Text = "menuStrip1";
            // 
            // fIleToolStripMenuItem
            // 
            fIleToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { listToolStripMenuItem });
            fIleToolStripMenuItem.Name = "fIleToolStripMenuItem";
            fIleToolStripMenuItem.Size = new System.Drawing.Size(36, 20);
            fIleToolStripMenuItem.Text = "CIF";
            // 
            // listToolStripMenuItem
            // 
            listToolStripMenuItem.Name = "listToolStripMenuItem";
            listToolStripMenuItem.Size = new System.Drawing.Size(92, 22);
            listToolStripMenuItem.Text = "List";
            listToolStripMenuItem.Click += listToolStripMenuItem_Click;
            // 
            // gLToolStripMenuItem
            // 
            gLToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { listToolStripMenuItem1, segmentsToolStripMenuItem });
            gLToolStripMenuItem.Name = "gLToolStripMenuItem";
            gLToolStripMenuItem.Size = new System.Drawing.Size(33, 20);
            gLToolStripMenuItem.Text = "GL";
            // 
            // listToolStripMenuItem1
            // 
            listToolStripMenuItem1.Name = "listToolStripMenuItem1";
            listToolStripMenuItem1.Size = new System.Drawing.Size(126, 22);
            listToolStripMenuItem1.Text = "&List";
            listToolStripMenuItem1.Click += listToolStripMenuItem1_Click;
            // 
            // segmentsToolStripMenuItem
            // 
            segmentsToolStripMenuItem.Name = "segmentsToolStripMenuItem";
            segmentsToolStripMenuItem.Size = new System.Drawing.Size(126, 22);
            segmentsToolStripMenuItem.Text = "Se&gments";
            segmentsToolStripMenuItem.Click += segmentsToolStripMenuItem_Click;
            // 
            // configurationToolStripMenuItem
            // 
            configurationToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { staticDataToolStripMenuItem });
            configurationToolStripMenuItem.Name = "configurationToolStripMenuItem";
            configurationToolStripMenuItem.Size = new System.Drawing.Size(93, 20);
            configurationToolStripMenuItem.Text = "Configuration";
            // 
            // staticDataToolStripMenuItem
            // 
            staticDataToolStripMenuItem.Name = "staticDataToolStripMenuItem";
            staticDataToolStripMenuItem.Size = new System.Drawing.Size(130, 22);
            staticDataToolStripMenuItem.Text = "Static Data";
            staticDataToolStripMenuItem.Click += staticDataToolStripMenuItem_Click;
            // 
            // sPaymentToolStripMenuItem
            // 
            sPaymentToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { mT202ToolStripMenuItem });
            sPaymentToolStripMenuItem.Name = "sPaymentToolStripMenuItem";
            sPaymentToolStripMenuItem.Size = new System.Drawing.Size(75, 20);
            sPaymentToolStripMenuItem.Text = "S Payment";
            // 
            // mT202ToolStripMenuItem
            // 
            mT202ToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] { MenuItem_MT202_List, MenuItem_MT202_New });
            mT202ToolStripMenuItem.Name = "mT202ToolStripMenuItem";
            mT202ToolStripMenuItem.Size = new System.Drawing.Size(180, 22);
            mT202ToolStripMenuItem.Text = "MT 202";
            // 
            // MenuItem_MT202_List
            // 
            MenuItem_MT202_List.Name = "MenuItem_MT202_List";
            MenuItem_MT202_List.Size = new System.Drawing.Size(180, 22);
            MenuItem_MT202_List.Text = "List";
            // 
            // MenuItem_MT202_New
            // 
            MenuItem_MT202_New.Name = "MenuItem_MT202_New";
            MenuItem_MT202_New.Size = new System.Drawing.Size(180, 22);
            MenuItem_MT202_New.Text = "New";
            MenuItem_MT202_New.Click += MenuItem_MT202_New_Click;
            // 
            // MainForm
            // 
            AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            ClientSize = new System.Drawing.Size(800, 450);
            Controls.Add(menuStrip1);
            IsMdiContainer = true;
            MainMenuStrip = menuStrip1;
            MdiChildrenMinimizedAnchorBottom = false;
            Name = "MainForm";
            Text = "SIS.OpenCore.Client.Win";
            WindowState = System.Windows.Forms.FormWindowState.Maximized;
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
        private System.Windows.Forms.ToolStripMenuItem sPaymentToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem mT202ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem MenuItem_MT202_List;
        private System.Windows.Forms.ToolStripMenuItem MenuItem_MT202_New;
    }
}

