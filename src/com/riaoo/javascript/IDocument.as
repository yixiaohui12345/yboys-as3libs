package com.riaoo.javascript
{
	/**
	 * 每个载入浏览器的 HTML 文档都会成为 Document 对象。
	 * Document 对象使我们可以从脚本中对 HTML 页面中的所有元素进行访问。
	 * 
	 * @author Y.Boy | <a href="http://riaoo.com/" target="_blank">riaoo.com</a>
	 * 
	 * @see http://www.w3school.com.cn/htmldom/dom_obj_document.asp
	 * 
	 */	
	public interface IDocument
	{
		//--------------------
		// Document 对象集合
		//--------------------
		/**
		 * 提供对文档中所有 HTML 元素的访问。
		 */		
		function get all():Array;
		
		/**
		 * 返回对文档中所有 Anchor 对象的引用。
		 */		
		function get anchors():Array;
		
		/**
		 * 返回对文档中所有 Applet 对象的引用。
		 */		
		function get applets():Array;
		
		/**
		 * 返回对文档中所有 Form 对象引用。
		 */		
		function get forms():Array;
		
		/**
		 * 返回对文档中所有 Image 对象引用。
		 */		
		function get images():Array;
		
		/**
		 * 返回对文档中所有 Area 和 Link 对象引用。
		 */		
		function get links():Array;
		
		
		
		//--------------------
		// Document 对象属性
		//--------------------
		/**
		 * 提供对 <body> 元素的直接访问。
		 * 对于定义了框架集的文档，该属性引用最外层的 <frameset>。
		 */		
		function get body():*;
		
		/**
		 * 设置或返回与当前文档有关的所有 cookie 。对 cookie 的任何操作请参考 ICookie 。
		 * 
		 * @see com.riaoo.javascript.ICookie
		 */		
		function get cookie():ICookie;
		
		/**
		 * 返回下载当前文档的服务器域名。
		 */		
		function get domain():String;
		
		/**
		 * 返回文档最后被修改的日期和时间。
		 */		
		function get lastModified():String;
		
		/**
		 * 返回载入当前文档的文档的 URL。
		 */		
		function get referrer():String;
		
		/**
		 * 当前文档的标题。
		 */		
		function get title():String;
		function set title(value:String):void;
		
		/**
		 * 当前文档的 URL。
		 * <br />
		 * <strong>说明：</strong>一般情况下，该属性的值与包含文档的 Window 的 location.href 属性相同。不过，在 URL 重定向发生的时候，这个 URL 属性保存了文档的实际 URL，而 location.href 保存了请求的 URL。
		 */		
		function get URL():String;
		
		
		
		//--------------------
		// Document 对象方法
		//--------------------
		/**
		 * 关闭一个由 document.open 方法打开的输出流，并显示选定的数据。
		 * <strong>说明：</strong>该方法将关闭 open() 方法打开的文档流，并强制地显示出所有缓存的输出内容。如果您使用 write() 方法动态地输出一个文档，必须记住当你这么做的时候要调用 close() 方法，以确保所有文档内容都能显示。一旦调用了 close()，就不应该再次调用 write()，因为这会隐式地调用 open() 来擦除当前文档并开始一个新的文档。
		 */		
		function close():void;
		
		function getElementById():*;
		function getElementsByName():*;
		function getElementsByTagName():*;
		function open():*;
		function write():*;
		function writeln():*;
		
	}
}