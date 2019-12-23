using System;
using System.Collections.Generic;

namespace ConsoleApp.EF
{
    public partial class DefBusinessDate
    {
        public int Id { get; set; }
        public DateTime? BusinessDay { get; set; }
        public bool? IsClosed { get; set; }
        public bool? IsEndOfWeek { get; set; }
        public bool? IsEndOfMonth { get; set; }
        public bool? IsEndOfQuarter { get; set; }
        public bool? IsEndOfYear { get; set; }
    }
}
