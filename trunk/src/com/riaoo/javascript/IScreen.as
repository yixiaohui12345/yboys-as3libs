package com.riaoo.javascript
{
	/**
	 * Screen 对象包含有关客户端显示屏幕的信息。
	 * 
	 * @author Y.Boy | <a href="http://riaoo.com/" target="_blank">riaoo.com</a>
	 * 
	 * @see http://www.w3school.com.cn/htmldom/dom_obj_screen.asp
	 * 
	 */	
	public interface IScreen
	{
		/**
		 * 返回显示屏幕的高度 (除 Windows 任务栏之外)。
		 */		
		function get availHeight():Number;
		
		/**
		 * 返回显示屏幕的宽度 (除 Windows 任务栏之外)。
		 */		
		function get availWidth():Number;
		
		/**
		 * 设置或返回调色板的比特深度。
		 */		
		function get bufferDepth():Number;
		function set bufferDepth(value:Number):void;
		
		/**
		 * 返回目标设备或缓冲器上的调色板的比特深度。
		 */		
		function get colorDepth():Number;
		
		/**
		 * 返回显示屏幕的每英寸水平点数。
		 */		
		function get deviceXDPI():Number;
		
		/**
		 * 返回显示屏幕的每英寸垂直点数。
		 */		
		function get deviceYDPI():Number;
		
		/**
		 * 返回用户是否在显示控制面板中启用了字体平滑。
		 */		
		function get fontSmoothingEnabled():Boolean;
		
		/**
		 * 返回显示屏幕的高度。
		 */		
		function get height():Number;
		
		/**
		 * 返回显示屏幕每英寸的水平方向的常规点数。
		 */		
		function get logicalXDPI():Number;
		
		/**
		 * 返回显示屏幕每英寸的垂直方向的常规点数。
		 */		
		function get logicalYDPI():Number;
		
		/**
		 * 返回显示屏幕的颜色分辨率（比特每像素）。
		 */		
		function get pixelDepth():Number;
		
		/**
		 * 设置或返回屏幕的刷新率。
		 */		
		function get updateInterval():Number;
		function set updateInterval(value:Number):void;
		
		/**
		 * 返回显示器屏幕的宽度。
		 */		
		function get width():Number;
	}
}