using System.Collections.Generic;
using System.Linq;
using System;
using SIS.OpenCore.EL;
using SIS.OpenCore.BL.Objects;



namespace SIS.OpenCore.BL.Transactions
{
    public partial class TRAN_POST_AE
    {

        static public Guid Post(TRAN_POST_AE_TYPE_PARAM[] ae_Param )        
        {
            string stBaseCurrency;

            stBaseCurrency = Settings.fn_OPT_GetBaseCurrency();
            
            if(Retrive_GL_Info(ae_Param,stBaseCurrency) == false)
                return Guid.Empty;

            return new Guid();
        }

        // Ensure that all legs are within the same company
        static public bool Retrive_GL_Info(TRAN_POST_AE_TYPE_PARAM[] Legs, string stBaseCurr )
        {
            foreach(TRAN_POST_AE_TYPE_PARAM Leg in Legs)
            {
                if (Leg.GL == true)
                    Leg.GL_Info = GL.fn_GetGLInfo(Leg.Acct_No, stBaseCurr);
                if (Leg.GL_Info == null)
                    return false;
            }

            return true;
        }



    }
}