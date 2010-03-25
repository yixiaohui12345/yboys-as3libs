package com.riaoo.utils
{
	/**
	 * MathUtil 类包含一些有用的处理数字的方法。
	 * @author Y.Boy
	 * 
	 */	
	public class MathUtil
	{
		public function MathUtil()
		{
		}
		
		/**
		 * 此方法返回处于合法区间内的数（区间为闭区间）。若 num 小于 min ，则返回 min ；若 num 大于 max ，则返回 max ；否则返回 num 。
		 * @param num 目标值。
		 * @param max 最大值。
		 * @param min 最小值。
		 * @return 返回一个处于 [min, max] 区间内的数。
		 * 
		 */		
		public static function clamp(num:Number, min:Number, max:Number):Number
		{
			if (num < min)
			{
				num = min;
			}
			else if (num > max)
			{
				num = max;
			}
			
			return num;
		}
		
	}
}