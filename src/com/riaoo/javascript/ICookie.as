package com.riaoo.javascript
{
	/**
	 * JavaScript 的 cookies 。
	 * 
	 * @author Y.Boy | <a href="http://riaoo.com/" target="_blank">riaoo.com</a>
	 * 
	 * @see http://baike.baidu.com/view/835.htm
	 * @see http://www.imf7.com/archives/19
	 */	
	public interface ICookie
	{
		/**
		 * 添加一个 cookie 。
		 * 
		 * @param name 变量名。
		 * @param value 变量值。
		 * @param seconds 有效时间，以称为单位计算。
		 * @param path 路径。指定与cookie关联的WEB页。
		 * @param domain 域。指定关联的WEB服务器或域。
		 * @param secure 安全。指定cookie的值通过网络如何在用户和WEB服务器之间传递。
		 * 
		 */		
		function add(name:String = "", value:String = "", seconds:int = 0, path:String = "/", domain:String = "", secure:String = ""):void;
		
		/**
		 * 获取指定名称的 cookie 。
		 * 
		 * @param name 变量名。
		 * @return 如果找不到指定的值，则返回 null 。
		 */		
		function get(name:String):String;
		
		/**
		 * 删除指定名称的 cookie 。
		 * @param name 变量名。
		 * 
		 */		
		function remove(name:String):void;
	}
}