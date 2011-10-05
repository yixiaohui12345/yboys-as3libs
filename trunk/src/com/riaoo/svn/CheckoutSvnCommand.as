package com.riaoo.svn
{
	public class CheckoutSvnCommand extends AbstractSvnCommand
	{
		public function CheckoutSvnCommand()
		{
			super();
		}
		
		/**
		 * 初始化命令参数。
		 * @param path
		 */		
		public function initArguments():void
		{
		}
		
		override public function get commandName():String
		{
			return SvnCommandNameEnum.CHECKOUT;
		}
		
		override public function generateNativeProcessStartupInfoArguments():Vector.<String>
		{
			var args:Vector.<String> = new Vector.<String>();
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