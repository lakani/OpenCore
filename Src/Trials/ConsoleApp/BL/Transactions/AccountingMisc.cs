using System.Linq;
using System;
using SIS.OpenCore.DAL;



namespace SIS.OpenCore.BL.Transactions
{
    
    public partial class AccountingMisc
    {
        static public decimal NUM_ACT_CR_DR(decimal OldBalance, decimal TrnAmt, byte Nature, string CR_DR)
        {
            //  ID	    Name		CR_DR
		    //  1		Asset		DR
		    //  2		Liability	CR
		    //  3		Income		CR
		    //  4		Expense		DR
		    //  5		Capital		CR
            decimal ReturnValue = 0;
            
            CR_DR = CR_DR.ToUpper();

            switch (Nature)
            {
                case    1 :                 //  1		Asset		DR
                    if(CR_DR == "CR")       ReturnValue = OldBalance - TrnAmt;
                    if(CR_DR == "DR")       ReturnValue = OldBalance + TrnAmt;
                break;

                case    2 :                 //  2		Liability	CR
                    if(CR_DR == "CR")       ReturnValue = OldBalance + TrnAmt;
                    if(CR_DR == "DR")       ReturnValue = OldBalance - TrnAmt;
                break;

                case    3 :                 //  3		Income		CR
                    if(CR_DR == "CR")       ReturnValue = OldBalance + TrnAmt;
                    if(CR_DR == "DR")       ReturnValue = OldBalance - TrnAmt;
                break;

                case    4 :                 //  4		Expense		DR
                    if(CR_DR == "CR")       ReturnValue = OldBalance - TrnAmt;
                    if(CR_DR == "DR")       ReturnValue = OldBalance + TrnAmt;
                break;

                case    5 :                 //  5		Capital		CR
                    if(CR_DR == "CR")       ReturnValue = OldBalance + TrnAmt;
                    if(CR_DR == "DR")       ReturnValue = OldBalance - TrnAmt;
                break;
            }

            return ReturnValue;

        }
    }
}

