using System;
using System.Linq;
using SIS.OpenCore.Shared.Model.Common;


namespace SIS.OpenCore.Shared.Model.GetRequest
{
    public class GetCIFRequestModel : BaseRequesModel , IEquatable<int>
    {
        public int?         CIF_ID { get; set; }
        public string?      CIF_NO { get; set; }
        public string?      SearchKey { get; set; }
        public string?      FirstName { get; set; }
        public string?      MiddleName { get; set; }
        public string?      LastName { get; set; }
        public string?      FamilyName { get; set; }

        public bool Equals(int other)
        {
            if(other == 0)
            {
                if(     CIF_ID == 0 && 
                        string.IsNullOrEmpty(CIF_NO) && 
                        string.IsNullOrEmpty(SearchKey) && 
                        string.IsNullOrEmpty(FirstName) && 
                        string.IsNullOrEmpty(MiddleName) && 
                        string.IsNullOrEmpty(LastName) && 
                        string.IsNullOrEmpty(FamilyName) )

                        return true;
                else
                {
                    return false;
                }
            }
            else return false;
        }
    }
}
