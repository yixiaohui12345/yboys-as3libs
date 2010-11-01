package com.riaoo.javascript
{
	/**
	 * 声明了新窗口要显示的标准浏览器的特征。
	 * 
	 * @author Y.Boy
	 * 
	 * @see http://www.w3school.com.cn/htmldom/met_win_open.asp#windowfeatures
	 */	
	public class WindowFeatures
	{
		/**
		 * 是否使用剧院模式显示窗口。默认为 false 。
		 */		
		public var channelmode:Boolean = false;
		
		/**
		 * 是否添加目录按钮。默认为 true 。
		 */		
		public var directories:Boolean = true;
		
		/**
		 * 是否使用全屏模式显示浏览器。默认是 false 。处于全屏模式的窗口必须同时处于剧院模式。
		 */		
		public var fullscreen:Boolean = false;
		
		/**
		 * 窗口文档显示区的高度。以像素计。
		 */		
		public var height:Number;
		
		/**
		 * 窗口的 x 坐标。以像素计。
		 */		
		public var left:Number;
		
		/**
		 * 是否显示地址字段。默认是 true 。
		 */		
		public var location:Boolean = true;
		
		/**
		 * 是否显示菜单栏。默认是 true 。
		 */		
		public var menubar:Boolean = true;
		
		/**
		 * 窗口是否可调节尺寸。默认是 true 。
		 */		
		public var resizable:Boolean = true;
		
		/**
		 * 是否显示滚动条。默认是 true 。
		 */		
		public var scrollbars:Boolean = true;
		
		/**
		 * 是否添加状态栏。默认是 true 。
		 */		
		public var status:Boolean = true;
		
		/**
		 * 是否显示标题栏。默认是 true 。
		 */		
		public var titlebar:Boolean = true;
		
		/**
		 * 是否显示浏览器的工具栏。默认是 true 。
		 */		
		public var toolbar:Boolean = true;
		
		/**
		 * 窗口的 y 坐标。
		 */		
		public var top:Number;
		
		/**
		 * 窗口的文档显示区的宽度。以像素计。
		 */		
		public var width:Number;
		
		/**
		 * 构造函数。
		 * 
		 */		
		public function WindowFeatures()
		{
		}
		
		public function toString():String
		{
			var result:String = "channelmode=" + int(this.channelmode);
			result += ",directories=" + int(this.directories);
			result += ",fullscreen=" + int(this.fullscreen);
			result += ",location=" + int(this.location);
			result += ",menubar=" + int(this.menubar);
			result += ",resizable=" + int(this.resizable);
			result += ",scrollbars=" + int(this.scrollbars);
			result += ",status=" + int(this.status);
			result += ",titlebar=" + int(this.titlebar);
			result += ",toolbar=" + int(this.toolbar);
			
			if (!isNaN(this.height))
			{
				result += ",height=" + this.height;
			}
			
			if (!isNaN(this.left))
			{
				result += ",left=" + this.left;
			}
			
			if (!isNaN(this.top))
			{
				result += ",top=" + this.top;
			}
			
			if (!isNaN(this.width))
			{
				result += ",width=" + this.width;
			}
			
			return result;
		}
		
	}
}