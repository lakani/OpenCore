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
	public partial class CIFTypeAdapter : BaseAdapter
	{
		
		public CIFTypeAdapter(string url, HttpClient httpClient) : base(httpClient)
		{
			//CIFTypeURL
			const string ConstURL = "/v1/api/OpenCore/system/Objects/CIFType/";
			if (string.IsNullOrEmpty(_stURL))
				_stURL = ConstURL;
			else
				_stURL = url;
		}

		public async Task<LUT_CIF_TYPE[]?> List()
		{
			try
			{
                HttpResponseMessage httpResponse;
				httpResponse = await _httpClient.GetAsync(_stURL );
                var SearchResult = JsonSerializer.Deserialize<LUT_CIF_TYPE[]>
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
	}
}
