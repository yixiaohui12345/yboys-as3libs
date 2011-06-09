package com.riaoo.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	
	/**
	 * 有关显示对象的工具类。
	 * @author Y.Boy
	 */	
	public class DisplayObjectUtil
	{
		public function DisplayObjectUtil()
		{
		}
		
		/**
		 * 获取显示对象的实际宽高，哪怕 DisplayObject.scrollRect 属性被定义了。类似 DisplayObject.getBounds() 方法
		 * @param displayObject 一个可能包含 scrollRect 属性的显示对象。
		 * @return 显示对象的实际宽高。
		 */		
		public static function getFullBounds(displayObject:DisplayObject):Rectangle
		{
			var bounds:Rectangle;
			var transform:Transform;
			var toGlobalMatrix:Matrix;
			var currentMatrix:Matrix;
			
			transform = displayObject.transform;
			currentMatrix = transform.matrix;
			toGlobalMatrix = transform.concatenatedMatrix;
			toGlobalMatrix.invert();
			transform.matrix = toGlobalMatrix;
			bounds = transform.pixelBounds.clone();
			transform.matrix = currentMatrix;
			return bounds;
		}
		
	}
}