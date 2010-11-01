package com.riaoo.managers
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	[Event(name="complete",type="flash.events.Event")]
	[Event(name="ioError",type="flash.events.IOErrorEvent")]
	[Event(name="progress",type="flash.events.ProgressEvent")]
	
	/**
	 * 队列加载器。凡使用此类加载资源，都会进行全局的排队加载。由 QueueLoaderManager 统一管理。
	 * 
	 * @author Y.Boy | riaoo.com
	 * 
	 * @see QueueLoaderManager
	 */	
	public class QueueLoader extends EventDispatcher
	{
		/**
		 * 在加载队列里的 id 。如果值为 -1 ，则表明此 QueueLoader 对象不在进加载队列中：要么是还没添加到队列，要么是已经加载完的。
		 */		
		internal var id:int = -1;
		
		/**
		 * 加载的数据。该数据的类型取决于 dataFormat 属性的设置。
		 */		
		internal var _data:*;
		
		/**
		 * 数据类型。QueueLoader.data 属性返回指示数据类型的对象。此属性值由 QueueLoaderDataFormat 枚举。
		 * <br />
		 * 以下是 dataFormat 和 data 属性的对照表：<br />
		 * <ul>
		 *   <li>QueueLoaderDataFormat.BINARY : ByteArray</li>
		 *   <li>QueueLoaderDataFormat.TEXT : String</li>
		 *   <li>QueueLoaderDataFormat.VARIABLES : URLVariables</li>
		 *   <li>QueueLoaderDataFormat.XML : XML</li>
		 *   <li>QueueLoaderDataFormat.IMAGE : Bitmap</li>
		 *   <li>QueueLoaderDataFormat.SWF : Loader</li>
		 *   <li>QueueLoaderDataFormat.SOUND : Sound</li>
		 * </ul>
		 * 
		 */		
		public var dataFormat:String;
		
		/**
		 * 加载地址。
		 */		
		public var url:URLRequest;
		
		/**
		 * 上下文对象，可以是 SoundLoaderContext 对象或 LoaderContext 对象及其子类。
		 */		
		public var context:*;
		
		/**
		 * 构造函数。
		 */		
		public function QueueLoader()
		{
		}
		
		/**
		 * 加载的数据。该数据的类型取决于 dataFormat 属性的设置。
		 */		
		public function get data():*
		{
			return _data;
		}
		
		/**
		 * 调用此方法不一定会马上执行加载操作，而是放进加载队列，等待加载。
		 * @param url 一个 URLRequest 对象，指定要下载的 URL 。
		 * @param dataFormat 数据类型。此属性值由 QueueLoaderDataFormat 枚举。
		 * @param context 上下文对象，可以是 SoundLoaderContext 对象或 LoaderContext 对象及其子类。
		 * 
		 * @see QueueLoaderDataFormat
		 */		
		public function load(url:URLRequest, dataFormat:String, context:* = null):void
		{
			this.url = url;
			this.context = context;
			this.dataFormat = dataFormat;
			QueueLoaderManager.getInstance().add(this);
		}
		
		/**
		 * 关闭进行中的加载操作。
		 * 
		 */		
		public function close():void
		{
			QueueLoaderManager.getInstance().remove(this);
		}
		
	}
}