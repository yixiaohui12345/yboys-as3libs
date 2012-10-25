package com.riaoo.svn
{
	/**
	 * 从版本库签出工作副本。
	 * @author yboyjiang
	 */	
	public class CheckoutSvnCommand extends AbstractSvnCommand
	{
		/**
		 * 版本库 URL 。
		 */		
		public var url:String;
		
		/**
		 * 检出至目录。
		 */		
		public var path:String;
		
		public function CheckoutSvnCommand()
		{
			super();
		}
		
		/**
		 * 初始化命令参数。
		 * @param path
		 */		
		public function initArguments(url:String, path:String):void
		{
			this.url = url;
			this.path = path;
		}
		
		override public function get commandName():String
		{
			return SvnCommandNameEnum.CHECKOUT;
		}
		
		override public function generateNativeProcessStartupInfoArguments():Vector.<String>
		{
			var args:Vector.<String> = new Vector.<String>();
			args.push(SvnCommandNameEnum.CHECKOUT, this.url, this.path, "--depth="+SvnDepthEnum.INFINITY); // 默认导出深度为全递归。
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