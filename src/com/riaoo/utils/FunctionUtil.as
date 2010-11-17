package com.riaoo.utils
{
	import flash.display.Sprite;

	public class FunctionUtil
	{
		public function FunctionUtil()
		{
		}
		
		/**
		 * 获取函数名。
		 * @param func 要获取名称的函数。
		 * @return 函数名。
		 */		
		public static function getFunctionName(func:Function):String
		{
			try
			{
				Sprite(func);
			}
			catch (e:Error)
			{
				return e.message.replace(/.+\/(\w+)\(\)\}\@.+/, "$1");
			}
			
			return null;
		}
		
	}
}