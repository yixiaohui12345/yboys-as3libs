package com.riaoo.svn
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	
	/**
	 * Svn 类。
	 * @author yboyjiang
	 */	
	public class Svn
	{
		/**
		 * 本机进程的工作目录。
		 */		
		public var workingDirectory:File;
		
		protected var svnExeFile:File; // svn.exe 文件
		protected var nativeProcess:NativeProcess;
		protected var startupInfo:NativeProcessStartupInfo;
		protected var currentCommand:AbstractSvnCommand; // 当前执行的命令
		protected var hasDataBeforeClose:Boolean; // 命令在关闭前是否有返回数据
		protected var _cmdQueue:Vector.<AbstractSvnCommand>;
		
		/**
		 * 构造函数。
		 */		
		public function Svn()
		{
		}
		
		/**
		 * 待执行的命令队列。
		 */		
		public function get cmdQueue():Vector.<AbstractSvnCommand>
		{
			return this._cmdQueue.concat();
		}
		
		/**
		 * 待执行的命令队列的长度。
		 */		
		public function get cmdQueueLength():uint
		{
			return this._cmdQueue.length;
		}
		
		/**
		 * 指示当前是否正在运行。
		 */		
		public function get running():Boolean
		{
			if (this.nativeProcess)
			{
				return this.nativeProcess.running;
			}
			return false;
		}
		
		/**
		 * 启动，同步的。
		 * @param svnExeFile 本地系统上的 svn.exe 文件。通常为以下路径：C:\Program Files\Subversion\bin\svn.exe
		 * @param workingDirectory 本机进程的工作目录。
		 * @return 启动是否成功。如果程序已启动，则返回 false 。
		 */		
		public function startup(svnExeFile:File, workingDirectory:File=null):Boolean
		{
			if (this.svnExeFile)
			{
				return false;
			}
			
			this._cmdQueue = new Vector.<AbstractSvnCommand>();
			this.svnExeFile = svnExeFile;
			this.workingDirectory = workingDirectory;
			
			this.startupInfo = new NativeProcessStartupInfo();
			this.startupInfo.executable = this.svnExeFile;
			
			this.nativeProcess = new NativeProcess();
			this.nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onData);
			this.nativeProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onData);
			this.nativeProcess.addEventListener(Event.STANDARD_OUTPUT_CLOSE, onResult);
			this.nativeProcess.addEventListener(Event.STANDARD_ERROR_CLOSE, onResult);
			this.nativeProcess.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
			this.nativeProcess.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
			this.nativeProcess.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			return true;
		}
		
		/**
		 * 退出，同步的。
		 */		
		public function exit(force:Boolean=false):void
		{
			this.nativeProcess.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onData);
			this.nativeProcess.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, onData);
			this.nativeProcess.removeEventListener(Event.STANDARD_OUTPUT_CLOSE, onResult);
			this.nativeProcess.removeEventListener(Event.STANDARD_ERROR_CLOSE, onResult);
			this.nativeProcess.removeEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
			this.nativeProcess.removeEventListener(NativeProcessExitEvent.EXIT, onExit);
			this.nativeProcess.exit(force);
			this.nativeProcess = null;
			
			this.startupInfo.executable = null;
			this.startupInfo.workingDirectory = null;
			this.startupInfo.arguments = null;
			this.startupInfo = null;
			
			this.workingDirectory = null;
			this.svnExeFile = null;
			this.currentCommand = null;
			
			this._cmdQueue.length = 0;
			this._cmdQueue = null;
		}
		
		/**
		 * 执行命令。
		 * @param command 要执行的命令。
		 */		
		public function exec(command:AbstractSvnCommand):void
		{
			this._cmdQueue.push(command);
			if (!this.running)
			{
				this.execNext();
			}
		}
		
		// 执行下一条命令。
		protected function execNext():void
		{
			if (this._cmdQueue.length)
			{
				var nextCmd:AbstractSvnCommand = this._cmdQueue.shift();
				this.currentCommand = nextCmd;
				this.startupInfo.arguments = this.currentCommand.generateNativeProcessStartupInfoArguments();
				this.startupInfo.workingDirectory = this.workingDirectory;
				this.nativeProcess.start(this.startupInfo);
			}
		}
		
		// 执行完命令。
		private function onResult(event:Event):void
		{
			if (!this.hasDataBeforeClose)
			{
				return;
			}
			
			this.currentCommand.onResult();
			var e:SvnEvent = new SvnEvent(SvnEvent.RESULT);
			e.currentCommand = this.currentCommand;
			if (event.type == Event.STANDARD_OUTPUT_CLOSE) // 成功
			{
				e.resultStatus = SvnEvent.RESULT_STATUS_OUTPUT;
			}
			else if (event.type == Event.STANDARD_ERROR_CLOSE) // 失败
			{
				e.resultStatus = SvnEvent.RESULT_STATUS_ERROR;
			}
			this.currentCommand.dispatchEvent(e);
			this.hasDataBeforeClose = false;
		}
		
		// 有数据可读时。
		private function onData(event:ProgressEvent):void
		{
			if (event.type == ProgressEvent.STANDARD_OUTPUT_DATA)
			{
				this.currentCommand.receiveResultData(this.nativeProcess.standardOutput);
			}
			else if (event.type == ProgressEvent.STANDARD_ERROR_DATA)
			{
				this.currentCommand.receiveResultData(this.nativeProcess.standardError);
			}
			this.hasDataBeforeClose = true;
		}
		
		// IO 错误。
		private function onIOError(event:IOErrorEvent):void
		{
			this.currentCommand.onError();
			this.hasDataBeforeClose = false;
			var e:SvnEvent = new SvnEvent(SvnEvent.IO_ERROR);
			e.currentCommand = this.currentCommand;
			this.currentCommand.dispatchEvent(e);
		}
		
		// 执行完一条命令，执行下一条。
		private function onExit(event:NativeProcessExitEvent):void
		{
			this.execNext();
		}
		
	}
}