package com.riaoo.managers
{
	/**
	 * QueueLoaderDataFormat 类提供了一些用于指定如何接收已下载数据的值。
	 * 
	 * @author Y.Boy | riaoo.com
	 * 
	 */	
	public class QueueLoaderDataFormat
	{
		/**
		 * 二进制。
		 */		
		public static const BINARY:String = "binary";
		
		/**
		 * 纯文本。
		 */		
		public static const TEXT:String = "text";
		
		/**
		 * URL 编码变量。变量=值。
		 */		
		public static const VARIABLES:String = "variables";
		
		/**
		 * XML 。
		 */		
		public static const XML:String = "xml";
		
		/**
		 * 图片：jpg、jpeg、gif、png 。
		 */		
		public static const IMAGE:String = "image";
		
		/**
		 * flash 。
		 */		
		public static const SWF:String = "swf";
		
		/**
		 * 声音。
		 */		
		public static const SOUND:String = "sound";
		
		/**
		 * 荒废了的构造函数。
		 */		
		public function QueueLoaderDataFormat()
		{
		}
	}
}