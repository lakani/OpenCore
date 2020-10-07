using System;

namespace SIS.OpenCore.Shared.Extensions
{
    public static partial class ShortExtensions
    {
        /// <summary>
        ///     TRy Parse for short which return Value.
        /// </summary>
        /// <param name="val1">The first of two 8-bit unsigned integers to compare.</param>
        /// <param name="val2">The second of two 8-bit unsigned integers to compare.</param>
        /// <returns>Parameter  or , whichever is larger.</returns>
        public static short TryParse(this short pThis, string value)
        {
            short ret;
            if (false == short.TryParse(value, out ret))
                ret = 0;
            return ret;
        }

        public static short TryParse(this short? pThis, string value)
        {
            short ret;
            if (false == short.TryParse(value, out ret))
                ret = 0;
            return ret;
        }
    }
}
