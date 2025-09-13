using System;
//
//namespace SIS.OpenCore.Client.MAUI.Shared.Components
namespace SIS.OpenCore.WebClient.Client.Components
{
    public class OnMenuItemClickArg
    {
        public string Label { get; set; }
        public Type ComponentType { get; set; }

        public Dictionary<string, object> ComponentParams { get; set; } = [];
    };
}


