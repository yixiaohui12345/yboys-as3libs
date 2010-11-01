package com.riaoo.javascript
{
	/**
	 * Navigator 对象包含有关浏览器的信息。
	 * 
	 * @author Y.Boy | <a href="http://riaoo.com/" target="_blank">riaoo.com</a>
	 * 
	 * @see http://www.w3school.com.cn/htmldom/dom_obj_navigator.asp
	 * 
	 */	
	public interface INavigator
	{
		/**
		 * 返回浏览器的代码名。
		 */		
		function get appCodeName():String;
		
		/**
		 * 返回浏览器的次级版本。
		 */		
		function get appMinorVersion():String;
		
		/**
		 * 返回浏览器的名称。
		 */		
		function get appName():String;
		
		/**
		 * 返回浏览器的平台和版本信息。
		 */		
		function get appVersion():String;
		
		/**
		 * 返回当前浏览器的语言。
		 */		
		function get browserLanguage():String;
		
		/**
		 * 返回指明浏览器中是否启用 cookie 的布尔值。
		 */		
		function get cookieEnabled():String;
		
		/**
		 * 返回浏览器系统的 CPU 等级。
		 */		
		function get cpuClass():String;
		
		/**
		 * 返回指明系统是否处于脱机模式的布尔值。
		 */		
		function get onLine():String;
		
		/**
		 * 返回运行浏览器的操作系统平台。
		 */		
		function get platform():String;
		
		/**
		 * 返回 OS 使用的默认语言。
		 */		
		function get systemLanguage():String;
		
		/**
		 * 返回由客户机发送服务器的 user-agent 头部的值。
		 */		
		function get userAgent():String;
		
		/**
		 * 返回 OS 的自然语言设置。
		 */		
		function get userLanguage():String;
		
		/**
		 * 规定浏览器是否启用 Java。
		 */		
		function javaEnabled():Boolean;
		
		/**
		 * 规定浏览器是否启用数据污点 (data tainting)。
		 */		
		function taintEnabled():Boolean;
	}
}