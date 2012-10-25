package com.riaoo.utils
{
	import flash.geom.ColorTransform;

	public class ColorUtil
	{
		public function ColorUtil()
		{
		}
		
		/**
		 * 计算反色。
		 * @param rgb RGB 颜色。
		 * @return 参数 rgb 的反色。
		 */		
		public static function getReverseColor(rgb:uint):uint
		{
			var r:uint = 0xFF - (rgb >> 16 & 0xFF);
			var g:uint = 0xFF - (rgb >> 8 & 0xFF);
			var b:uint = 0xFF - (rgb & 0xFF);
			return (r << 16) | (g << 8) | b;
		}
		
		/**
		 * 根据 ColorTransform 输出 Flash CS 里的色调颜色。
		 * @param colorTransform
		 * @return 
		 */		
		public static function colorTransformToTingeColor(colorTransform:ColorTransform):uint
		{
			var r:uint = Math.round(colorTransform.redOffset / (1 - colorTransform.redMultiplier));
			var g:uint = Math.round(colorTransform.greenOffset / (1 - colorTransform.greenMultiplier));
			var b:uint = Math.round(colorTransform.blueOffset / (1 - colorTransform.blueMultiplier));
			var colorNum:uint = r<<16 | g<<8 | b;
			return colorNum; 
		}
		
	}
}