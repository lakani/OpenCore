using System;

namespace SIS.OpenCore.Shared.Extensions
{
    public static partial class intExtensions
    {
        /// <summary>
        ///     TRy Parse for int which return Value.
        /// </summary>
        /// <param name="val1">The first of two 8-bit unsigned integers to compare.</param>
        /// <param name="val2">The second of two 8-bit unsigned integers to compare.</param>
        /// <returns>Parameter  or , whichever is larger.</returns>
        public static int TryParse(this int pThis, string value)
        {
            int ret;
            if (false == int.TryParse(value, out ret))
                ret = 0;
            return ret;
        }

        public static int TryParse(this int? pThis, string value)
        {
            int ret;
            if (false == int.TryParse(value, out ret))
                ret = 0;
            return ret;
        }
    }
}
