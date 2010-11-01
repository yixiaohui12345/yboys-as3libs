package com.riaoo.javascript
{
	/**
	 * History 对象包含用户（在浏览器窗口中）访问过的 URL。
	 * 
	 * @author Y.Boy | <a href="http://riaoo.com/" target="_blank">riaoo.com</a>
	 * 
	 * @see http://www.w3school.com.cn/htmldom/dom_obj_history.asp
	 * 
	 */	
	public interface IHistory
	{
		/**
		 * 返回浏览器历史列表中的 URL 数量。
		 */		
		function get length():uint;
		
		/**
		 * 加载 history 列表中的前一个 URL。
		 */		
		function back():void;
		
		/**
		 * 加载 history 列表中的下一个 URL。
		 */		
		function forward():void;
		
		/**
		 * 加载 history 列表中的某个具体页面。
		 * @param location 此参数可以是要访问的 URL ，或 URL 的子串；也可以是要访问的 URL 在 History 的 URL 列表中的相对位置。
		 * <br />
		 * 例如：go(-1) 等同于后退；go("http://riaoo.com/") 跳转到指定的网页。
		 */		
		function go(location:*):void;
	}
}