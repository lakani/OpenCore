using System;
using System.Net.Http;
using System.Windows.Forms;
using Microsoft.Extensions.DependencyInjection;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Client.Adapter;
using System.Threading.Tasks;


namespace SIS.OpenCore.Client.Win
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private readonly HttpClient _httpClient;
        private readonly IServiceProvider _serviceProvider;

        public LoginForm(IServiceProvider serviceProvider, HttpClient httpClient) : this()
        {
            _httpClient = httpClient;
            _serviceProvider = serviceProvider;
        }

        private async void btnLogin_Click(object sender, EventArgs e)
        {
            var user = new ApplicationUser();

            user.UserName = txtUser.Text;
            user.PlainPassword = txtPassword.Text;

            var mainForm = _serviceProvider.GetRequiredService<MainForm>();
            var authAdapter = _serviceProvider.GetRequiredService<AuthenticationAdapter>();

            var Ret = await authAdapter.ADLoginAsync("FAISAL", txtUser.Text, txtPassword.Text);
            if (Ret.StatusCode == System.Net.HttpStatusCode.OK)
            {
                this.DialogResult = DialogResult.OK;
                //this.Close();
            }
            else
            {
                MessageBox.Show("Incorrect User/Password");
            }

            //mainForm.StartPosition =  FormStartPosition.CenterScreen;
            //mainForm.Show();


        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            // No need for Application.Exit() here
        }

        private void LoginForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (e.CloseReason == CloseReason.UserClosing)
            {
                this.DialogResult = DialogResult.Cancel;
            }
        }
    }
}
