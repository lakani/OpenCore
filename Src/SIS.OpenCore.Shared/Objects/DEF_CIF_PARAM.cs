using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SIS.OpenCore.Model;

namespace SIS.OpenCore.Shared.Objects
{
    public class DEF_CIF_PARAM : DEF_CIF
    {
        public string Name { get; set; }
        public int cRecords { get; set; }
    }
}
