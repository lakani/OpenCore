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



namespace SIS.OpenCore.Client.Adapter
{
	public partial class GLAcctAdapter : BaseAdapter
	{
		
		public GLAcctAdapter(string url, HttpClient httpClient) : base(httpClient)
		{
			const string ConstURL = "/v1/api/OpenCore/system/Objects/GLLedger/";
			if (string.IsNullOrEmpty(_stURL))
				_stURL = ConstURL;
			else
				_stURL = url;
		}

		public async Task<PostGLLedgerResponseModel?> AddNewGLAcct(PostGLLedgerRequestModel newRequest)
		{
			try
			{
				var httpResponse = await _httpClient.PostAsJsonAsync(_stURL + "Create", newRequest);
				var NewGLResult = JsonSerializer.Deserialize<PostGLLedgerResponseModel>
					(await httpResponse.Content.ReadAsStringAsync(), new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

				if (NewGLResult != null && NewGLResult.Successful == true && NewGLResult.GL != null && string.IsNullOrEmpty(NewGLResult.GL) == false )  { return NewGLResult; }
					else { return NewGLResult; }

			}
			catch(Exception ex)
			{
				Console.WriteLine(ex.Message);
				return null;
			}
		}

		public async Task<GetGLLedgerResponseModel?> Search(GetGLLedgerRequestModel search)
		{
			try
			{
				var httpResponse = await _httpClient.PostAsJsonAsync(_stURL + "Search", search);
				var SearchResult = JsonSerializer.Deserialize<GetGLLedgerResponseModel>
				(await httpResponse.Content.ReadAsStringAsync(), new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

				if (SearchResult != null && SearchResult.Successful == true && SearchResult.Gls != null && SearchResult.Gls.Any() == true )  { return SearchResult; }
				else { return null; }
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				return null;
			}
		}
	}
}
