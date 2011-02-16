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
			if (num > max)
			{
				num = max;
			}
			
			if (num < min)
			{
				num = min;
			}
			
			return num;
		}
		
		/**
		 * 计算参数 num 的阶乘。零的阶乘为 1 。
		 * <br />
		 * 阶乘：n 的阶乘为 n * (n - 1) * (n - 2) * ... * 2 * 1
		 * @param num 用来计算阶乘的数字。
		 * @return 返回 num 的阶乘。
		 * 
		 */		
		public static function factorial(num:Number):Number
		{
			if (num == 0)
			{
				return 1;
			}
			
			return num * factorial(num - 1);
		}
		
		/**
		 * 判断一个数是不是奇数。
		 * @param num 待判断的数。
		 * @return 如果是奇数，则返回 true ；是偶数，则返回 false 。
		 * 
		 */		
		public static function isOdd(num:Number):Boolean
		{
			return Boolean(num & 1);
		}
		
	}
}