package com.riaoo.svn
{
	/**
	 * 检出深度。
	 * @author yboyjiang
	 */	
	public class SvnDepthEnum
	{
		/**
		 * 仅此项。
		 */		
		public static const EMPTH:String = "empty";
		
		/**
		 * 仅文件子节点。
		 */		
		public static const FILES:String = "files";
		
		/**
		 * 直接子节点，包含文件夹。
		 */		
		public static const IMMEDIATES:String = "immediates";
		
		/**
		 * 全递归。
		 */		
		public static const INFINITY:String = "infinity";
		
		public function SvnDepthEnum()
		{
		}
	}
}