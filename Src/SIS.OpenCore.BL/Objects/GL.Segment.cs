using System.Linq;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SIS.OpenCore.Model;
using SIS.OpenCore.DAL;
using SIS.OpenCore.DAL.Context;
using SIS.OpenCore.BL;


namespace SIS.OpenCore.BL.Objects
{
    public partial class Segment
    {
        public byte     Type;
        public string   Name;
        public string   DigitsValue;
        public short    DigitsLength;
    }
}
