﻿using System;
using System.Collections.Generic;

namespace SIS.OpenCore.Server.Data.TODO // Check the correct table attributes
{
    public partial class LUT_GL_ACCT_CATEGORY
    {
        public short ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public short? ParentCat { get; set; }
    }
}