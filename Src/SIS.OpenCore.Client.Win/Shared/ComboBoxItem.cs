using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIS.OpenCore.Client.Win.Shared
{
	public class ComboBoxItemShort
	{
		public string Text { get; set; }
		public short Value { get; set; }

		public override string ToString()
		{
			return Text;
		}
	}

    public class ComboBoxItemInt
    {
        public string Text { get; set; }
        public int Value { get; set; }

        public override string ToString()
        {
            return Text;
        }
    }
}
