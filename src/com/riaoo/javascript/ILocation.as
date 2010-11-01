package com.riaoo.javascript
{
	/**
	 * Location 对象包含有关当前 URL 的信息。
	 * 
	 * @author Y.Boy | <a href="http://riaoo.com/" target="_blank">riaoo.com</a>
	 * 
	 * @see http://www.w3school.com.cn/htmldom/dom_obj_location.asp
	 */	
	public interface ILocation
	{
		/**
		 * 设置或返回从井号 (#) 开始的 URL（锚）。
		 */		
		function get hash():String;
		function set hash(value:String):void;
		
		/**
		 * 设置或返回主机名和当前 URL 的端口号。
		 */		
		function get host():String;
		function set host(value:String):void;
		
		/**
		 * 设置或返回当前 URL 的主机名。
		 */		
		function get hostName():String;
		function set hostName(value:String):void;
		
		/**
		 * 设置或返回完整的 URL。
		 */		
		function get href():String;
		function set href(value:String):void;
		
		/**
		 * 设置或返回当前 URL 的路径部分。
		 */		
		function get pathName():String;
		function set pathName(value:String):void;
		
		/**
		 * 设置或返回当前 URL 的端口号。
		 */		
		function get port():String;
		function set port(value:String):void;
		
		/**
		 * 设置或返回当前 URL 的协议。
		 */		
		function get protocol():String;
		function set protocol(value:String):void;
		
		/**
		 * 设置或返回从问号 (?) 开始的 URL（查询部分）。
		 */		
		function get search():String;
		function set search(value:String):void;
		
		/**
		 * 加载一个新的文档。
		 * @param url 新文档的网址。
		 */		
		function assign(url:String):void;
		
		/**
		 * 刷新页面。
		 * @param force 是否强制（绕过缓存）刷新页面。
		 */		
		function reload(force:Boolean = false):void;
		
		/**
		 * 用一个新文档取代当前文档。
		 * @param newURL 新文档的网址。
		 */		
		function replace(newURL:String):void;
		
		/**
		 * 返回完整的 URL 。
		 * @return 
		 * 
		 */		
		function toString():String;
	}
}