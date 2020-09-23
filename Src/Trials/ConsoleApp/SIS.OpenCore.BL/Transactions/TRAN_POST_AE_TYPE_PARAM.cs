using System.Linq;
using System;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;



namespace SIS.OpenCore.BL.Transactions
{
    public partial class TRAN_POST_AE_TYPE_PARAM
    {
        // [Row_NUM] [int] IDENTITY(1,1) NOT NULL,
        // [Acct_CR_DR] [nvarchar](2) NULL,
        // [Acct_No] [nvarchar](max) NULL,
        // [GL] [bit] NULL,
        // [Acct_Amt] [decimal](28, 3) NULL,
        // [Acct_Curr] [nvarchar](3) NULL,
        // [EffDt] [datetime] NULL,
        // [Acct_Description] [nvarchar](max) NULL

        public  short           Category;
        public  string          Acct_CR_DR;
        public  string          Acct_No;
        public  bool            GL;
        public  decimal         Trn_Amt;
        public  string          Acct_Curr;
        public  DateTime        EffDt;
        public  string          Acct_Description;
        public  DEF_GL          GL_Info;
        public  DEF_CK_ACCT     CK_Acct;

    }
}