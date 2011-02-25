package com.riaoo.managers
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;
	
	[Event(name="complete",type="flash.events.Event")]
	[Event(name="progress",type="flash.events.ProgressEvent")]
	
	/**
	 * 队列加载器（QueueLoader）的管理器。
	 * 
	 * @author Y.Boy | riaoo.com
	 * 
	 * @see QueueLoader
	 */	
	public class QueueLoaderManager extends EventDispatcher
	{
		private static var instance:QueueLoaderManager;
		
		/**
		 * 构造函数。
		 */		
		public function QueueLoaderManager(privateClass:PrivateClass)
		{
			if (!privateClass)
			{
				throw new Error("QueueLoaderManager 类是单例。");
			}
		}
		
		/**
		 * 获取本类的单例。
		 * @return QueueLoaderManager 类的唯一实例。
		 */		
		public static function getInstance():QueueLoaderManager
		{
			if (!QueueLoaderManager.instance)
			{
				QueueLoaderManager.instance = new QueueLoaderManager(new PrivateClass());
			}
			
			return QueueLoaderManager.instance;
		}
		
		
		
		private var loader:Loader; // image, swf
		private var urlLoader:URLLoader; // binary, text, variables, xml
		private var sound:Sound; // sound
		
		private var queue:Array; // 加载队列
		private var currentID:int = -1; // 当前正加载的 id
		
		/**
		 * 加载队列的长度。包含已加载的和未加载的 QueueLoader 。
		 * <br />
		 * 当全部 QueueLoader 都完成加载后，此属性值变为零。
		 */		
		public function get length():uint
		{
			return this.queue.length;
		}
		
		/**
		 * 添加待加载的 QueueLoader 。
		 * @param loader QueueLoader 实例。
		 */		
		internal function add(loader:QueueLoader):void
		{
			if (!this.queue)
			{
				this.queue = [];
			}
			this.queue.push(loader);
			loader.id = this.queue.length - 1;
			
			if (this.currentID < 0) // 开始加载
			{
				next();
			}
		}
		
		/**
		 * 移除指定的 QueueLoader 对象。
		 * @param loader 待移除的 QueueLoader 对象。
		 */		
		internal function remove(loader:QueueLoader):void
		{
			this.queue[loader.id] = null;
			if (this.currentID == loader.id) // 想移除的 loader 正在下载
			{
				next();
			}
			loader.id = -1;
		}
		
		// 加载下一个。
		private function next():void
		{
			this.currentID++;
			
			// 调度 manager 的进度事件
			var progressEvent:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
			progressEvent.bytesLoaded = this.currentID;
			progressEvent.bytesTotal = this.queue.length;
			dispatchEvent(progressEvent);
			
			// 全部加载完成
			if (this.currentID >= this.queue.length)
			{
				dispose();
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			
			var currentLoader:QueueLoader = this.queue[this.currentID];
			if (currentLoader)
			{
				switch (currentLoader.dataFormat)
				{
					case QueueLoaderDataFormat.IMAGE:
					case QueueLoaderDataFormat.SWF:
					{
						if (!this.loader)
						{
							this.loader = new Loader();
							this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
							this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
							this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
						}
						this.loader.load(currentLoader.url, currentLoader.context);
						break;
					}
					case QueueLoaderDataFormat.BINARY:
					case QueueLoaderDataFormat.TEXT:
					case QueueLoaderDataFormat.VARIABLES:
					case QueueLoaderDataFormat.XML:
					{
						if (!this.urlLoader)
						{
							this.urlLoader = new URLLoader();
							this.urlLoader.addEventListener(Event.COMPLETE, onComplete);
							this.urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
							this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
						}
						this.urlLoader.dataFormat = (currentLoader.dataFormat == QueueLoaderDataFormat.XML)
													? QueueLoaderDataFormat.TEXT
													: currentLoader.dataFormat;
						this.urlLoader.load(currentLoader.url);
						break;
					}
					case QueueLoaderDataFormat.SOUND:
					{
						if (!this.sound)
						{
							this.sound = new Sound();
							this.sound.addEventListener(Event.COMPLETE, onComplete);
							this.sound.addEventListener(ProgressEvent.PROGRESS, onProgress);
							this.sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
						}
						this.sound.load(currentLoader.url, currentLoader.context);
						break;
					}
				} // end switch
				
			}
			else
			{
				next();
			}
		}
		
		// Queueloader complete 。
		private function onComplete(event:Event):void
		{
			var currentLoader:QueueLoader = this.queue[this.currentID];
			switch (currentLoader.dataFormat)
			{
				// Loader
				case QueueLoaderDataFormat.IMAGE:
				{
					currentLoader._data = this.loader.content as Bitmap;
					this.loader.unload();
					break;
				}
				case QueueLoaderDataFormat.SWF:
				{
					this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
					this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
					this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
					currentLoader._data = this.loader;
					this.loader = null;
					break;
				}
				// URLLoader
				case QueueLoaderDataFormat.BINARY:
				case QueueLoaderDataFormat.TEXT:
				case QueueLoaderDataFormat.VARIABLES:
				{
					currentLoader._data = this.urlLoader.data;
					break;
				}
				case QueueLoaderDataFormat.XML:
				{
					currentLoader._data = new XML(this.urlLoader.data);
					break;
				}
				// Sound
				case QueueLoaderDataFormat.SOUND:
				{
					this.sound.removeEventListener(Event.COMPLETE, onComplete);
					this.sound.removeEventListener(ProgressEvent.PROGRESS, onProgress);
					this.sound.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
					currentLoader._data = this.sound;
					this.sound = null;
					break;
				}
			} // end switch
			
			currentLoader.dispatchEvent(event); // 调度 complete 事件
			remove(currentLoader);
		}
		
		// 加载中。
		private function onProgress(event:ProgressEvent):void
		{
			var currentLoader:QueueLoader = this.queue[this.currentID];
			currentLoader.dispatchEvent(event);
		}
		
		// IO 错误。
		private function onIOError(event:IOErrorEvent):void
		{
			var currentLoader:QueueLoader = this.queue[this.currentID];
			currentLoader.dispatchEvent(event);
			remove(currentLoader);
		}
		
		// 清理工作，释放内存。
		private function dispose():void
		{
			this.queue.length = 0;
			this.queue = null;
			
			this.currentID = -1;
			
			if (this.loader)
			{
				this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				this.loader = null;
			}
			
			if (this.urlLoader)
			{
				this.urlLoader.removeEventListener(Event.COMPLETE, onComplete);
				this.urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				this.urlLoader = null;
			}
			
			if (this.sound)
			{
				this.sound.removeEventListener(Event.COMPLETE, onComplete);
				this.sound.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				this.sound.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				this.sound = null;
			}
			
		}
		
	}
}

class PrivateClass{}