package com.riaoo.svn
{
	import flash.events.Event;
	
	public class SvnEvent extends Event
	{
		/**
		 * 命令执行完成后获得的输出流。
		 */		
		public static const RESULT_STATUS_OUTPUT:String = "resultStatusOutput";
		
		/**
		 * 命令执行完成后获得的错误流。
		 */		
		public static const RESULT_STATUS_ERROR:String = "resultStatusError";
		
		/**
		 * 执行成功事件常量。
		 */		
		public static const RESULT:String = "result";
		
		/**
		 * 执行错误事件常量。
		 */		
		public static const IO_ERROR:String = "ioError";
		
		/**
		 * 当前调度此事件的命令对象。
		 */		
		public var currentCommand:AbstractSvnCommand;
		
		/**
		 * 命令执行完成后的状态，只有两种：输出流（RESULT_STATUS_OUTPUT） 和 错误流（RESULT_STATUS_ERROR）。
		 */		
		public var resultStatus:String;
		
		/**
		 * 构造函数。
		 * @param type
		 */		
		public function SvnEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			var e:SvnEvent = new SvnEvent(this.type);
			e.currentCommand = this.currentCommand;
			return e;
		}
		
	}
}