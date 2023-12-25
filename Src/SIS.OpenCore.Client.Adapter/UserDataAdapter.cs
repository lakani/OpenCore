using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Security.Policy;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Net.Http.Json;
using System.Text.Json.Nodes;
using SIS.OpenCore.Shared.Model.Objects.UserData;
using System.Linq;
using SIS.OpenCore.Shared.Model.GetRequest;
using SIS.OpenCore.Shared.Model.PostRequest;



namespace SIS.OpenCore.Client.Adapter
{
	public partial class UserDataAdapter : BaseAdapter
	{
		
		public UserDataAdapter(string url, HttpClient httpClient) : base(httpClient)
		{
			const string ConstURL = "v1/api/OpenCore/system/Settings/UserData?Configuration=";
			if (string.IsNullOrEmpty(_stURL))
				_stURL = ConstURL;
			else
				_stURL = url;
		}

		public async Task<GetUserDataResponseModel			> GetListAsync(string stUserDataConfig)
		{
			return await GetUserDataAsync(stUserDataConfig);
		}

		public async Task<GetUserDataResponseModel?> GetZoneListAsync()
		{
			return await GetUserDataAsync("Zone");
		}

		public async Task<GetUserDataResponseModel?> GetCompanyListAsync()
		{
			return await GetUserDataAsync("Company");
		}

		public async Task<GetUserDataResponseModel?> GetBranchListAsync()
		{
			return await GetUserDataAsync("Branch");
		}

		public async Task<GetUserDataResponseModel?> GetSectorListAsync()
		{
			return await GetUserDataAsync("Sector");
		}

		public async Task<GetUserDataResponseModel?> GetDepListAsync()
		{
			return await GetUserDataAsync("Dep");
		}

		public async Task<GetUserDataResponseModel?> GetUnitListAsync()
		{
			return await GetUserDataAsync("Unit");
		}

		public string[] GetUserDataConfigList()
		{
			string[] configs = {"Zone",  "Company", "Branch", "Sector", "Dep", "Unit"};
			return configs;
		}

		public async Task<GetUserDataResponseModel?> GetUserDataAsync(string Config)
		{
			try
			{
				BaseUserData x  = new BaseUserData();
				x.Name = Config;


				var result = await _httpClient.GetAsync(_stURL + Config);
				var data = JsonSerializer.Deserialize<GetUserDataResponseModel>(await result.Content.ReadAsStringAsync(),
					new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

				if (data != null && data.Records.Count() > 0)
					return data;
				else
					return null;
			}
			catch (Exception ex) {
				int x = 0;
				x = 1;
				return null;
			}
			
		}

		public async Task<short> PostUserDataAsync(string Config, short[] Ids, string[] values)
		{
			try
			{
				var request = new PostUserDataRequestModel();
				request.ids = Ids;
				request.Values = values;
				request.Configuration = Config;

				var result = await _httpClient.PostAsJsonAsync(_stURL + Config, request);
				if (result.IsSuccessStatusCode) { return 0; }
				else { return -1; }
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				return -1;
			}
		}
	}
}
