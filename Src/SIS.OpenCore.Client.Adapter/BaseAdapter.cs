using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;


namespace SIS.OpenCore.Client.Adapter
{
	public partial class BaseAdapter
	{
		protected HttpClient _httpClient;
		protected string		_stURL = string.Empty;

		public BaseAdapter(HttpClient httpClient)
		{
			_httpClient = httpClient;
		}
	}
}
