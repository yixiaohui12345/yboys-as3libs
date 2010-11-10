package com.riaoo.utils
{
	import flash.display.Loader;
	
	/**
	 * 作用于把 swf 文件作为资源库的类。
	 * @author Y.Boy | riaoo.com
	 */	
	public class SWFLibrary
	{
		/**
		 * 荒废了的构造函数。
		 * 
		 */		
		public function SWFLibrary()
		{
		}
		
		/**
		 * 获取指定类名的一个实例。如果 swf 文件未成功加载，则返回 null 。
		 * @param swf 一个 swf 文件，里面有很多素材。
		 * @param className 类名。
		 * @return 一个实例。
		 */		
		public static function getInstance(swf:Loader, className:String):*
		{
			try
			{
				var TheClass:Class = swf.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
				return new TheClass();
			}
			catch(e:Error)
			{
			}
			
			return null;
		}
		
		/**
		 * 获取指定类名的一个类对象。如果 swf 文件未成功加载，则返回 null 。
		 * @param swf 一个 swf 文件，里面有很多素材。
		 * @param className 类名。
		 * @return 一个类对象。
		 */		
		public static function getClass(swf:Loader, className:String):Class
		{
			try
			{
				return swf.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
			}
			catch(e:Error)
			{
			}
			
			return null;
		}
		
	}
}