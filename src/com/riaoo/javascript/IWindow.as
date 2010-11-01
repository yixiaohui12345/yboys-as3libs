package com.riaoo.javascript
{
	/**
	 * Window 对象表示浏览器中打开的窗口。
	 * <br />
	 * 如果文档包含框架（frame 或 iframe 标签），浏览器会为 HTML 文档创建一个 window 对象，并为每个框架创建一个额外的 window 对象。
	 * 
	 * @author Y.Boy | <a href="http://riaoo.com/" target="_blank">riaoo.com</a>
	 * 
	 * @see http://www.w3school.com.cn/htmldom/dom_obj_window.asp
	 */	
	public interface IWindow
	{
		/**
		 * 返回窗口中所有命名的框架。该集合是 Window 对象的数组，每个 Window 对象在窗口中含有一个框架或 <iframe>。属性 frames.length 存放数组 frames[] 中含有的元素个数。注意，frames[] 数组中引用的框架可能还包括框架，它们自己也具有 frames[] 数组。
		 */		
		function get frames():Array;
		
		/**
		 * 返回窗口是否已被关闭。
		 * <br />
		 * 当浏览器窗口关闭时，表示该窗口的 Windows 对象并不会消失，它将继续存在，不过它的 closed 属性将设置为 true。
		 */		
		function get closed():Boolean;
		
		/**
		 * 设置或返回窗口状态栏中的默认文本。该文本会在页面加载时被显示。
		 */		
		function get defaultStatus():String;
		function set defaultStatus(value:String):void;
		
		/**
		 * 对 Document 对象的只读引用。每个载入浏览器的 HTML 文档都会成为 Document 对象。
		 * 
		 * @see com.riaoo.javascript.IDocument
		 */		
		function get document():IDocument;
		
		/**
		 * 对 History 对象的只读引用。History 对象包含用户（在浏览器窗口中）访问过的 URL。
		 * 
		 * @see com.riaoo.javascript.IHistory
		 */		
		function get history():IHistory;
		
		/**
		 * 返回窗口的文档显示区的高度。这里的宽度和高度不包括菜单栏、工具栏以及滚动条等的高度。
		 * <br />
		 * <strong>注意：</strong>IE 不支持这些属性。它用 document.documentElement 或 ducument.body （与 IE 的版本相关）的 clientWidth 和 clientHeight 属性作为替代。
		 */		
		function get innerHeight():Number;
		
		/**
		 * @see com.riaoo.javascript.IWindow.innerheight
		 */		
		function get innerWidth():Number;
		
		/**
		 * 设置或返回窗口中的框架数量。
		 */		
		function get length():Number;
		function set length(value:Number):void;
		
		/**
		 * 用于窗口或框架的 Location 对象。
		 */		
		function get location():ILocation;
		
		/**
		 * 设置或返回窗口的名称。
		 * <br />
		 * name 属性可设置或返回存放窗口的名称的一个字符串。
		 * 该名称是在 open() 方法创建窗口时指定的或者使用一个 <frame> 标记的 name 属性指定的。
		 * 窗口的名称可以用作一个 <a> 或者 <form> 标记的 target 属性的值。
		 * 以这种方式使用 target 属性声明了超链接文档或表单提交结果应该显示于指定的窗口或框架中。
		 */		
		function get name():String;
		function set name(value:String):void;
		
		/**
		 * 对 Navigator 对象的只读引用。
		 */		
		function get navigator():INavigator;
		
		/**
		 * 返回对创建此窗口的窗口的引用。opener 属性非常有用，创建的窗口可以引用创建它的窗口所定义的属性和函数。
		 * <br />
		 * 注意：只有表示顶层窗口的 Window 对象的 operner 属性才有效，表示框架的 Window 对象的 operner 属性无效。
		 */		
		function get opener():IWindow;
		
		/**
		 * 返回窗口的外部高度。注意：IE 不支持此属性，且没有提供替代的属性。
		 */		
		function get outerHeight():Number;
		
		/**
		 * @see com.riaoo.javascript.IWindow.outerHeight
		 */		
		function get outerWidth():Number;
		
		/**
		 * 设置或返回当前页面相对于窗口显示区左上角的 X 位置。
		 */		
		function get pageXOffset():Number;
		
		/**
		 * 设置或返回当前页面相对于窗口显示区左上角的 Y 位置。
		 */		
		function get pageYOffset():Number;
		
		/**
		 * 返回父窗口。
		 */		
		function get parent():IWindow;
		
		/**
		 * 对 Screen 对象的只读引用。
		 */		
		function get screen():IScreen;
		
		/**
		 * 返回对当前窗口的引用。等价于 Window 属性。
		 */		
		function get self():IWindow;
		
		/**
		 * 可设置或返回窗口状态栏中的文本。
		 * 
		 * @see http://www.w3school.com.cn/htmldom/prop_win_status.asp
		 */		
		function get status():String;
		function set status(value:String):void;
		
		/**
		 * 返回最顶层的先辈窗口。
		 * <br />
		 * 该属性返回对一个顶级窗口的只读引用。如果窗口本身就是一个顶级窗口，top 属性存放对窗口自身的引用。如果窗口是一个框架，那么 top 属性引用包含框架的顶层窗口。
		 */		
		function get top():IWindow;
		
		/**
		 * window 属性等价于 self 属性，它包含了对窗口自身的引用。
		 */		
		function get window():IWindow;
		
		/**
		 * 只读整数。
		 * 声明了窗口的左上角在屏幕上的的 x 坐标和 y 坐标。
		 * IE、Safari 和 Opera 支持 screenLeft 和 screenTop，而 Firefox 和 Safari 支持 screenX 和 screenY。
		 */		
		function get screenX():Number;
		
		/**
		 * @see com.riaoo.javascript.IWindow.screenX
		 */		
		function get screenY():Number;
		
		/**
		 * 显示带有一段消息和一个确认按钮的警告框。
		 * @param message 需要在警告框里显示的消息。
		 * 
		 */		
		function alert(message:String):void;
		
		/**
		 * 把键盘焦点从顶层窗口移开。注意：在某些浏览器上，该方法可能无效。
		 * 
		 */		
		function blur():void;
		
		/**
		 * 取消由 setInterval() 设置的 timeout。
		 * @param id 由 setInterval() 返回的 ID 值。
		 * 
		 */		
		function clearInterval(id:Number):void;
		
		/**
		 * 取消由 setTimeout() 方法设置的 timeout。
		 * @param id 由 setTimeout() 返回的 ID 值。
		 * 
		 */		
		function clearTimeout(id:Number):void;
		
		/**
		 * 关闭浏览器窗口。
		 * <br />
		 * 方法 close() 将关闭有 window 指定的顶层浏览器窗口。
		 * 某个窗口可以通过调用 self.close() 或只调用 close() 来关闭其自身。
		 * 只有通过 JavaScript 代码打开的窗口才能够由 JavaScript 代码关闭。这阻止了恶意的脚本终止用户的浏览器。
		 * 
		 */		
		function close():void;
		
		/**
		 * 弹出确认框。
		 * @param message 需要在确认框里显示的消息。
		 * @return 如果用户点击确认，那么返回值为 true 。如果用户点击取消，那么返回值为 false 。
		 */		
		function confirm(message:String):Boolean;
		
		/**
		 * 创建一个 pop-up 窗口。
		 * @return 
		 * 
		 */		
		function createPopup():IWindow;
		
		/**
		 * 把键盘焦点给予一个窗口。
		 * 
		 */		
		function focus():void;
		
		/**
		 * 可相对窗口的当前坐标把它移动指定的像素。
		 * @param x 要把窗口右移的像素数。
		 * @param y 要把窗口左移的像素数。
		 * 
		 */		
		function moveBy(x:Number, y:Number):void;
		
		/**
		 * 把窗口的左上角移动到一个指定的坐标。
		 * @param x 窗口新位置的 x 坐标。
		 * @param y 窗口新位置的 y 坐标。
		 * 
		 */		
		function moveTo(x:Number, y:Number):void;
		
		/**
		 * 打开一个新的浏览器窗口或查找一个已命名的窗口。
		 * 有关参数的详细信息请看：http://www.w3school.com.cn/htmldom/met_win_open.asp
		 * @param url
		 * @param name
		 * @param features 一个 WindowFeatures 对象。
		 * @param replace
		 * @return 
		 * 
		 * @see http://www.w3school.com.cn/htmldom/met_win_open.asp
		 */		
		function open(url:String, name:String, features:WindowFeatures, replace:Boolean):IWindow;
		
		/**
		 * 打印当前窗口的内容。
		 * 
		 */		
		function print():void;
		
		/**
		 * 弹出提示框。
		 * @param message
		 * @param content
		 * @return 如果用户点击确认，那么返回值为输入的值。如果用户点击取消，那么返回值为 null 。
		 * 
		 */		
		function prompt(message:String, content:String = ""):String;
		
		/**
		 * 按照指定的像素调整窗口的大小。
		 * @param width 要使窗口宽度增加的像素数。可以是正、负数值。
		 * @param height 要使窗口高度增加的像素数。可以是正、负数值。
		 * 
		 */		
		function resizeBy(width:Number, height:Number):void;
		
		/**
		 * 把窗口的大小调整到指定的宽度和高度。
		 * @param width 想要调整到的窗口的宽度。以像素计。
		 * @param height 想要调整到的窗口的高度。以像素计。
		 * 
		 */		
		function resizeTo(width:Number, height:Number):void;
		
		/**
		 * 按照指定的像素值来滚动内容。
		 * @param x 把文档向右滚动的像素数。
		 * @param y 把文档向下滚动的像素数。
		 * 
		 */		
		function scrollBy(x:Number, y:Number):void;
		
		/**
		 * 把内容滚动到指定的坐标。
		 * @param x 要在窗口文档显示区左上角显示的文档的 x 坐标。
		 * @param y 要在窗口文档显示区左上角显示的文档的 y 坐标。
		 * 
		 */		
		function scrollTo(x:Number, y:Number):void;
		
		/**
		 * 以指定的间隔（以毫秒为单位）运行函数。
		 * @param closure 要执行的函数的名称。
		 * @param delay 间隔（以毫秒为单位）。
		 * @param params 传递给 closure 函数的可选参数列表。
		 * @return 时进程的唯一数字标识符。使用此标识符可通过调用 clearInterval() 方法取消进程。
		 * 
		 */		
		function setInterval(closure:Function, delay:Number, ...params):Number;
		
		/**
		 * 在指定的延迟（以毫秒为单位）后运行指定的函数。
		 * @param closure 要执行的函数的名称。
		 * @param delay 执行函数之前的延迟时间（以毫秒为单位）。
		 * @param params 传递给 closure 函数的可选参数列表。
		 * @return 超时进程的唯一数字标识符。使用此标识符可通过调用 clearTimeout() 方法取消进程。
		 * 
		 */		
		function setTimeout(closure:Function, delay:Number, ...params):Number;
	}
}