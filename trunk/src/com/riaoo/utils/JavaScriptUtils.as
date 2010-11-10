package com.riaoo.utils
{
	import flash.external.ExternalInterface;
	
	/**
	 * 工具类。
	 * @author jiangxuejian
	 */	
	public class JavaScriptUtils
	{
		public static const FIREFOX:String = "Firefox";
		public static const SAFARI:String = "Safari";
		public static const MSIE:String = "MSIE";
		public static const OPERA:String = "Opera";
		
		public function JavaScriptUtils()
		{
		}
		
		/**
		 * 获取浏览器名称。当浏览器不属于以下类型之一时，返回空字符串：Firefox、Safari、MSIE、Opera ，否则返回上述类型之一。
		 * @return 返回值由 SDOUtils 静态属枚举。
		 */		
		public static function getBrowserName():String
		{
			var browser:String = "";
			var browserAgent:String = ExternalInterface.call("function SDOGetBrowserName(){return navigator.userAgent;}");
			
			if (browserAgent)
			{
				if (browserAgent.indexOf(FIREFOX) >= 0)
				{
					browser = FIREFOX;
				}
				if (browserAgent.indexOf(SAFARI) >= 0)
				{
					browser = SAFARI;
				}
				if (browserAgent.indexOf(MSIE) >= 0)
				{
					browser = MSIE;
				}
				if (browserAgent.indexOf(OPERA) >= 0)
				{
					browser = OPERA;
				}
			}
			
			return browser;
		}
		
	}
}