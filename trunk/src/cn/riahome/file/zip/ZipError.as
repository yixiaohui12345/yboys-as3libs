package cn.riahome.file.zip
{
	/**
	 * 在处理 zip 文件时有机会发生的错误。ZipError 类包含这些错误信息。
	 * @author Administrator Y.Boy
	 * 
	 */	
	public class ZipError extends Error
	{
		public static const COMPRESSION_METHOD_INVALID:String = "不支持或无效的压缩方法，只支持 DEFLATE 压缩算法。";
		public static const ZIP_INVALID:String = "已损坏或无效的 zip 文件。";
		public static const FILE_NAME_IS_NULL:String = "文件名不能为空。";
		public static const FILE_EXISTED:String = "文件已存在。";
		
		/**
		 * 构造函数。
		 * @param message 与 ZipError 对象关联的字符串。
		 * @param id 与特定错误消息关联的引用数字。
		 * 
		 */		
		public function ZipError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
		
	}
}