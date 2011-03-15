package com.riaoo.utils
{
	import flash.utils.ByteArray;

	public class StringUtil
	{
		public function StringUtil()
		{
		}
		
		/**
		 * 获取字符串的字节长度。
		 * @param string 字符串。
		 * @param charSet 表示用于解释字节的字符集的字符串。例如：utf-8、gb2312。
		 * @return 字节长度。
		 */		
		public static function getByteLength(string:String, charSet:String="utf-8"):uint
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeMultiByte(string, charSet);
			return bytes.length;
		}
		
		/**
		 * 根据指定的字节长度截取字符串。
		 * @param input 要截取的字符串。
		 * @param limitByteLength 要限制的字节长度。
		 * @param charSet 表示用于解释字节的字符集的字符串。例如：utf-8、gb2312。
		 * @return 截取后的字符串。
		 */		
		public static function substrInByte(input:String, limitByteLength:uint, charSet:String="gb2312"):String
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeMultiByte(input, charSet);
			if (bytes.length <= limitByteLength)
			{
				return input;
			}
			
			bytes.position = 0;
			return bytes.readMultiByte(limitByteLength, charSet);
		}
		
		/**
		 * 右修剪字符串。
		 * @param input 需要修剪的字符串。
		 * @param targetByteLength 修剪后的字节长度。
		 * @param suffixShort 字符串过短时要补上的尾词（会重复补上，直到输出结果满足 targetByteLength 长度为止）。
		 * @param suffixLong 字符串过长时要补上的尾词（只补上一个）。
		 * @param charSet 表示用于解释字节的字符集的字符串。例如：utf-8、gb2312。
		 * @return 修剪后的字符串。
		 */		
		public static function rTrimString(input:String, targetByteLength:uint, suffixShort:String, suffixLong:String, charSet:String="gb2312"):String
		{
			var output:String;
			var inputBytes:ByteArray = new ByteArray();
			inputBytes.writeMultiByte(input, charSet);
			
			var offset:int = inputBytes.length - targetByteLength;
			if (offset == 0) // 正好相等
			{
				output = input;
			}
			else if (offset < 0) // 过短
			{
				var i:int = Math.abs(offset) / getByteLength(suffixShort, charSet);
				while (i--)
				{
					input += suffixShort;
				}
				output = input;
			}
			else if (offset > 0) // 过长
			{
				inputBytes.position = 0;
				var suffixLongByteLength:uint = getByteLength(suffixLong, charSet);
				if (targetByteLength > suffixLongByteLength)
				{
					output = inputBytes.readMultiByte(targetByteLength - suffixLongByteLength, charSet) + suffixLong;
				}
				else
				{
					output = inputBytes.readMultiByte(targetByteLength, charSet);
				}
			}
			
			return output;
		}
		
	}
}