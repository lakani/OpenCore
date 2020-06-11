using System.Net.Http;
using System.Collections.Generic;

public partial class CurRates
    {
        [JsonProperty("base")]
        public string Base { get; set; }

        [JsonProperty("date")]
        public DateTimeOffset Date { get; set; }

        [JsonProperty("time_last_updated")]
        public long TimeLastUpdated { get; set; }

        [JsonProperty("rates")]
        public Dictionary<string, double> Rates { get; set; }
    }


Console.WriteLine("Hello world!");

using (var client = new HttpClient())
{
    client.BaseAddress = new Uri("https://api.exchangerate-api.com/v4/latest/");
    client.DefaultRequestHeaders.Accept.Clear();
    //HTTP GET
    var responseTask = client.GetAsync("EGP");
    responseTask.Wait();

    var result = responseTask.Result;
    if (result.IsSuccessStatusCode)
    {
        var readTask = result.Content.ReadAsAsync<CurRates>();
        readTask.Wait();

        CurRates root = readTask.Result;
    }            
}