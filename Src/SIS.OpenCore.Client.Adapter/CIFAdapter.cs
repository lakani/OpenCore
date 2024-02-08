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
using System.Net.Http.Headers;
using SIS.OpenCore.Shared.Model.Common;



namespace SIS.OpenCore.Client.Adapter
{
	public partial class CIFAdapter : BaseAdapter
	{
		
		public CIFAdapter(string url, HttpClient httpClient) : base(httpClient)
		{
			const string ConstURL = "/v1/api/OpenCore/system/Objects/CIF/";
			if (string.IsNullOrEmpty(_stURL))
				_stURL = ConstURL;
			else
				_stURL = url;
		}

		public async Task<GetCIFResponseModel?> Search(GetCIFRequestModel search)
		{
			try
			{
				var httpResponse = await _httpClient.PostAsJsonAsync(_stURL + "Search", search);
				var SearchResult = JsonSerializer.Deserialize<GetCIFResponseModel>
				(await httpResponse.Content.ReadAsStringAsync(), new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

				if (SearchResult != null && SearchResult.Successful == true && SearchResult.CIFArr != null && SearchResult.CIFArr.Any() == true )  { return SearchResult; }
				else { return null; }
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				throw new Exception(ex.Message);
			}
		}

		//PostCIFRequestModel
		public async Task<BaseResponseModel?> Create(PostCIFRequestModel newCIF)
		{
			try
			{
				var httpResponse = await _httpClient.PostAsJsonAsync(_stURL + "Create", newCIF);
				var SearchResult = JsonSerializer.Deserialize<BaseResponseModel>
				(await httpResponse.Content.ReadAsStringAsync(), new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

				if (SearchResult != null && SearchResult.Successful == true )  { return SearchResult; }
				else { return null; }
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				throw new Exception(ex.Message);
			}
		}

		///v1/api/OpenCore/system/Objects/CIF/ + "Create"
	}
}
