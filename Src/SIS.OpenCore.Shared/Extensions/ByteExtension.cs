using System;

namespace SIS.OpenCore.Shared.Extensions
{
    public static partial class ByteExtensions
    {
        /// <summary>
        ///     TRy Parse for Byte which return Value.
        /// </summary>
        /// <param name="val1">The first of two 8-bit unsigned integers to compare.</param>
        /// <param name="val2">The second of two 8-bit unsigned integers to compare.</param>
        /// <returns>Parameter  or , whichever is larger.</returns>
        public static Byte TryParse(this Byte pThis, string value)
        {
            byte ret;
            if (false == byte.TryParse(value, out ret))
                ret = 0;
            return ret;
        }

        public static Byte TryParse(this Byte? pThis, string value)
        {
            byte ret;
            if (false == byte.TryParse(value, out ret))
                ret = 0;
            return ret;
        }
    }
}
