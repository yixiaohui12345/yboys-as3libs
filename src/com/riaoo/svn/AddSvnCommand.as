package com.riaoo.svn
{
	
	import flash.utils.IDataInput;
	
	public class AddSvnCommand extends AbstractSvnCommand
	{
		public var path:String;
		
		public function AddSvnCommand()
		{
			super();
		}
		
		/**
		 * 初始化命令参数。
		 * @param path
		 */		
		public function initArguments(path:String):void
		{
			this.path = path;
		}
		
		override public function get commandName():String
		{
			return SvnCommandNameEnum.ADD;
		}
		
		override public function generateNativeProcessStartupInfoArguments():Vector.<String>
		{
			var args:Vector.<String> = new Vector.<String>();
			args.push(this.commandName, this.path);
			return args;
		}
		
		override internal function onResult():void
		{
			
		}
		
		override internal function onError():void
		{
			
		}
		
	}
}