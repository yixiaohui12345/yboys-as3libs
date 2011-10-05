package com.riaoo.svn
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	
	/**
	 * 执行成功后调度此事件。
	 */	
	[Event(name="result", type="com.riaoo.svn.SvnEvent")]
	
	/**
	 * 出现 IO 错误时调度此事件。
	 */	
	[Event(name="ioError", type="com.riaoo.svn.SvnEvent")]
	
	/**
	 * 请不要直接实例化抽象类。
	 * @author yboyjiang
	 */	
	public class AbstractSvnCommand extends EventDispatcher
	{
		protected static const ERROR_MESSAGE:String = "无法调用抽象类的方法。";
		
		/**
		 * 执行命令完成后获得的数据。
		 */		
		protected var _resultData:ByteArray;
		
		public function AbstractSvnCommand()
		{
		}
		
		/**
		 * 命令的名称。
		 * @see com.riaoo.svn.SvnCommandNameEnum
		 */		
		public function get commandName():String
		{
			throw new Error(ERROR_MESSAGE);
			return "";
		}
		
		/**
		 * 生成 NativeProcessStartupInfo.arguments 属性所需要的数据。
		 * @return 一个 NativeProcessStartupInfo.arguments 属性所需要的数据。
		 * 
		 * @see flash.desktop.NativeProcessStartupInfo
		 */		
		public function generateNativeProcessStartupInfoArguments():Vector.<String>
		{
			throw new Error(ERROR_MESSAGE);
			return null;
		}
		
		/**
		 * 执行命令完成后获得的数据。应当监听 result 事件，并判断 SvnEvent.resultStatus 类型。
		 * @see com.riaoo.svn.SvnEvent.resultStatus
		 */		
		public function get resultData():IDataInput
		{
			return this._resultData;
		}
		
		/**
		 * 每当接收到数据时都被 Svn 对象调用。
		 * @param data 接收到的数据。
		 */		
		internal function receiveResultData(data:IDataInput):void
		{
			if (!this._resultData)
			{
				this._resultData = new ByteArray();
			}
			data.readBytes(this._resultData, this._resultData.bytesAvailable, data.bytesAvailable);
		}
		
		/**
		 * 执行结束后，给 Svn 对象调用的回调函数。
		 */		
		internal function onResult():void
		{
			throw new Error(ERROR_MESSAGE);
		}
		
		/**
		 * 执行结束后，给 Svn 对象调用的回调函数。
		 */		
		internal function onError():void
		{
			throw new Error(ERROR_MESSAGE);
		}
		
		/**
		 * 打印输出的文字消息。
		 * @return 
		 */		
		public function toMessage(charSet:String="gb2312"):String
		{
			if (this._resultData && this._resultData.length)
			{
				this._resultData.position = 0;
				var msg:String = this._resultData.readMultiByte(this._resultData.bytesAvailable, charSet);
				return msg;
			}
			return "";
		}
		
	}
}