﻿using System;
using System.Collections.Generic;

namespace SIS.OpenCore.Server.Data.TODO // Check the correct table attributes
{
    public partial class CIF_CK_ACCT_ACCT_STRUCT
    {
        public short AccountStructID { get; set; }
        public string AccountCode { get; set; }
        public string GLNum { get; set; }
        public short GLCategory { get; set; }
        public string GLComments { get; set; }
    }
}