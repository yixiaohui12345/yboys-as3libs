package com.riaoo.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Point;
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
		 * 获取显示对象的实际宽高，哪怕 DisplayObject.scrollRect 属性被定义了。类似 DisplayObject.getBounds() 方法。
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
		
		/**
		 * 获取指定范围里的对象。结果中不包含参数 container 。
		 * @param container
		 * @param rect 在 container 的坐标系下的范围。
		 * @return 如果结果为空，则返回空的数组。
		 * @see flash.display.DisplayObjectContainer.getObjectsUnderPoint()
		 */		
		public static function getObjectUnderRect(container:DisplayObjectContainer, rect:Rectangle):Array
		{
			if (rect.width == 0)
			{
				rect.width = 1;
			}
			if (rect.height == 0)
			{
				rect.height = 1;
			}
			
			var result:Array = [];
			var count:int = container.numChildren;
			var child:DisplayObject;
			while (count--)
			{
				child = container.getChildAt(count);
				if (child is DisplayObjectContainer)
				{
					var pt:Point = new Point(rect.x, rect.y);
					pt = container.localToGlobal(pt); // 先转为全局坐标
					pt = child.globalToLocal(pt); // 再转为局部坐标
					var childRect:Rectangle = new Rectangle(pt.x, pt.y, rect.width, rect.height);
					result = result.concat(getObjectUnderRect(child as DisplayObjectContainer, childRect));
				}
				else if (rect.intersects(child.getBounds(container)))
				{
					result.push(child);
				}
			}
			return result;
		}
		
	}
}