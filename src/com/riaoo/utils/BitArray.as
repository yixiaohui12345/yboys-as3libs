package com.riaoo.utils
{
	import flash.utils.ByteArray;
	
	/**
	 * 支持位访问的 ByteArray 子类。
	 * @author Y.Boy
	 * 
	 */	
	public class BitArray extends ByteArray
	{
		/**
		 * 构造函数。可传递一个 ByteArray 对象进行初始化。
		 * @param bytes 现有的 ByteArray 数据。
		 * 
		 */		
		public function BitArray(bytes:ByteArray = null)
		{
			if (bytes != null)
			{
				this.writeBytes(bytes, 0, bytes.length);
			}
		}
		
		/**
		 * 返回由参数 index 指定位置处的位的值。1 为 true，0 为 false 。
		 * @param index 一个整数，指定位在 ByteArray 中的位置。第一个位由 0 指示，最后一个位由 ByteArray.length * 8 - 1 指示。
		 * @return 指定索引处的位的值。或者，如果指定的索引不在该 ByteArray 的索引范围内，则返回 false 。
		 * 
		 */		
		public function getBitAt(index:uint = 0):Boolean
		{
			index++; // 索引值加 1 ，计算出长度
			
			if (index > this.length * 8)
			{
				throw new RangeError("数值不在可接受的范围内。可接受范围为：0 到 ByteArray.length*8-1 。");
				return false;
			}
			
			var byteIndex:uint = Math.ceil(index/8) - 1; // 目标字节的索引
			var shiftCount:uint = (this.length * 8 - index) % 8; // 移动的位数
			
			return Boolean((this[byteIndex] >> shiftCount) & 1);
		}
		
		/**
		 * 设置由参数 index 指定位置处的位的值。如果 index 指定位置处的长度大于当前长度，该字节数组的长度将设置为最大值，右侧将用零填充。
		 * @param index 一个整数，指定位在 ByteArray 中的位置。第一个位由 0 指示，最后一个位由 ByteArray.length * 8 - 1 指示。
		 * @param value 要设置的值。true 为 1 ，false 为 0 。
		 * 
		 */		
		public function setBitAt(index:uint, value:Boolean):void
		{
			index++; // 索引值加 1 ，计算出长度
			
			// 如果 index 指定位置处的长度大于当前长度，该字节数组的长度将设置为最大值，右侧将用零填充。
			var len:uint = Math.ceil(index/8);
			if (len > this.length)
			{
				this.length = len;
			}
			
			if (this.getBitAt(index-1) == value)
				return;
			
			var byteIndex:uint = Math.ceil(index/8) - 1;
			var modRight:uint = (this.length * 8 - index) % 8;
			this[byteIndex] ^= 1 << modRight; // 异或运算，把该位取反
		}
		
	}
}