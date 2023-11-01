using SIS.OpenCore.Shared.Model.Common;

#nullable disable

namespace SIS.OpenCore.Shared.Model
{
    /*
        this main the 5 Ledger Accounting Nature 
        
        check the below link
        https://en.wikipedia.org/wiki/Debits_and_credits

        Kind of account	        Debit	    Credit
        Asset	                Increase	Decrease
        Liability	            Decrease	Increase
        Income/Revenue	        Decrease	Increase
        Expense/Cost/Dividend	Increase	Decrease
        Equity/Capital	        Decrease	Increase

    */
    public partial class LUT_GLLedgerNature : BaseEntity
    {
        public int GetPrimaryKey ()
        {
            return ID;
        }
        public short ID { get; set; }
        public string Name { get; set; }
        public string CR_DR { get; set; }
    }
}
