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
using SIS.OpenCore.Shared.Model.Objects.CIF;



namespace SIS.OpenCore.Client.Adapter
{
	public partial class CIFClassAdapter : BaseAdapter
	{
		
		public CIFClassAdapter(string url, HttpClient httpClient) : base(httpClient)
		{
			const string ConstURL = "/v1/api/OpenCore/system/Objects/CIFClass";
			if (string.IsNullOrEmpty(_stURL))
				_stURL = ConstURL;
			else
				_stURL = url;
		}

		public async Task<CIF_CLASS[]?> List()
		{
			try
			{
                HttpResponseMessage httpResponse;
				httpResponse = await _httpClient.GetAsync(_stURL + "?nClassID=" + 0);
				var SearchResult = JsonSerializer.Deserialize<CIF_CLASS[]>
				(await httpResponse.Content.ReadAsStringAsync(), new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

				if (SearchResult != null && SearchResult.Any() == true)  { return SearchResult; }
				else { return null; }
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				throw new Exception(ex.Message);
			}
		}

		public async Task<CIF_CLASS?> Search(int nClassID)
		{
			try
			{
                HttpResponseMessage httpResponse;
				httpResponse = await _httpClient.GetAsync(_stURL + "?nClassID=" + nClassID);
				var SearchResult = JsonSerializer.Deserialize<CIF_CLASS>
				(await httpResponse.Content.ReadAsStringAsync(), new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

				if (SearchResult != null )  { return SearchResult; }
				else { return null; }
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				throw new Exception(ex.Message);
			}
		}
	}
}
