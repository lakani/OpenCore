using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;
using SIS.OpenCore.Shared.Model.Common;
using SIS.OpenCore.Shared.Model.Objects.UserData;


namespace SIS.OpenCore.Client.Adapter
{

    public partial class AuthenticationAdapter : BaseAdapter
    {
        public AuthenticationAdapter(string url, HttpClient httpClient) : base(httpClient)
        {
            const string ConstURL = "/v1/api/OpenCore/system/Identity/Account/auth/Login";
			if (string.IsNullOrEmpty(_stURL))
				_stURL = ConstURL;
			else
				_stURL = url;
        }

        public async Task<HttpResponseMessage> LoginAsync(ApplicationUser loginUser)
        {
            // POST to: v1/api/OpenCore/system/Identity/Account/auth/Login
            return await _httpClient.PostAsJsonAsync("v1/api/OpenCore/system/Identity/Account/auth/Login", loginUser);
        }

        public async Task<HttpResponseMessage> ADLoginAsync(string domain, string username, string password)
        {
            var url = $"v1/api/OpenCore/system/Identity/Account/auth/ADLogin?domain={WebUtility.UrlEncode(domain)}&username={WebUtility.UrlEncode(username)}&password={WebUtility.UrlEncode(password)}";
            var ret = await _httpClient.GetAsync(url);
            var responseBody = await ret.Content.ReadAsStringAsync();
            // Log or inspect responseBody for error details

            return ret;
        }

        public async Task<HttpResponseMessage> LogoutAsync()
        {
            // POST to: v1/api/OpenCore/system/Identity/Account/auth/Logout
            return await _httpClient.PostAsync("v1/api/OpenCore/system/Identity/Account/auth/Logout", null);
        }
    }
}
