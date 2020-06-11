using System;
using System.Collections.Generic;

namespace SIS.OpenCore.EL
{
    public partial class DEF_BusinessDate
    {
        public int ID { get; set; }
        public DateTime? BusinessDay { get; set; }
        public bool? IsClosed { get; set; }
        public bool? IsEndOfWeek { get; set; }
        public bool? IsEndOfMonth { get; set; }
        public bool? IsEndOfQuarter { get; set; }
        public bool? IsEndOfYear { get; set; }
    }
}
