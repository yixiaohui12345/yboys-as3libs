package com.riaoo.svn
{
	/**
	 * 把文件和目录纳入版本控制，通过调度加到版本库。它们会在下一次提交时加入。
	 * @author yboyjiang
	 */	
	public class AddSvnCommand extends AbstractSvnCommand
	{
		/**
		 * 要添加的目录或文件的路径。
		 */		
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