package com.riaoo.file.zip
{
	import flash.utils.ByteArray;
	
	/**
	 * 一个 ZipEntry 对象指向 zip 文件包里的一个文件（包括文件夹，文件夹是一种特殊的文件）.
	 * <br />
	 * 在 zip 格式说明书（<a href="http://www.pkware.com/documents/casestudies/APPNOTE.TXT" target="_blank">http://www.pkware.com/documents/casestudies/APPNOTE.TXT</a>）里用 "entry" 一词表示 zip 文件包里的单个文件。
	 * <br />
	 * ZipEntry 对象不表示文件实际的字节数据。要取得 zip 文件包里某个文件的字节数据，请查看 ZipFile.getEntryData() 。
	 * <p>
	 * <strong>注意：</strong>ZipEntry 类所有属性均为 internal 类型，即包内可见。你不应该直接访问这些属性，而是通过对应的方法来取得相关属性值。
	 * </p>
	 * @author Administrator Y.Boy
	 * 
	 */	
	public class ZipEntry
	{
		internal var name              :String;    // 名称。一个包含完整路径的字符串。 变量
		internal var extra             :ByteArray; // 额外字段 变量
		internal var comment           :String;    // 注释 变量
		internal var crc32             :uint; // crc-32 4 字节
		internal var compressedSize    :uint; // 压缩后的大小 4 字节
		internal var size              :uint; // 解压缩后的大小 4 字节
		internal var method            :int;  // 压缩方法 2 字节 (8=DEFLATE; 0=UNCOMPRESSED)
		internal var versionMadeBy     :int;  // version made by 2 字节
		internal var version           :int;  // 所需版本 2 字节
		internal var flag              :int;  // 一般用途位标记 2 字节
		internal var dostime           :uint; // 文件的最后修改时间（日期+时间） 共 4 字节
		internal var nameLength        :int;  // 文件名长度 2 字节
		internal var extraLength       :int;  // 额外字段长度 2 字节
		internal var commentLength     :int;  // 文件注释长度 2 字节
		internal var diskNumberStart   :int;  // 磁盘开始号 2 字节
		internal var intFileAttributes :int;  // 内部文件属性 2 字节
		internal var extFileAttributes :uint; // 外部文件属性 4 字节
		internal var offsetLOC         :uint; // 相关的标头偏移量 4 字节
		internal var offsetCEN         :uint; // 在 中央目录结构 里的标头偏移量 4 字节
		
		/**
		 * 构造函数。
		 * @param name 文件名称。
		 * 
		 */		
		public function ZipEntry(name:String)
		{
			this.name = name;
			this.extra = new ByteArray();
			this.comment = "技术支持：Y.Boy | http://www.riahome.cn";
		}
		
		/**
		 * 获取文件名称（包含完整路径，例如：cn/riahome/file.zip）。
		 * @return 一个包含完整路径的字符串。
		 * 
		 */		
		public function getName():String
		{
			return this.name;
		}
		
		/**
		 * 获取额外字段。
		 * @return 一个二进制数据。
		 * 
		 */		
		public function getExtra():ByteArray
		{
			return this.extra;
		}
		
		/**
		 * 获取注释。
		 * @return 注释，字符串。
		 * 
		 */		
		public function getComment():String
		{
			return this.comment;
		}
		
		/**
		 * 获取文件的最后修改时间，自 1970 年 1 月 1 日午夜（通用时间）以来的毫秒数。
		 * @return 获取文件的最后修改时间，一个毫秒数。
		 * 
		 */		
		public function getTime():Number
		{
			var year:Number = ((this.dostime >> 25) & 0x7F) + 1980;
			var month:Number = ((this.dostime >> 21) & 0x0F) - 1;
			var date:Number = (this.dostime >> 16) & 0x1F;
			var hour:Number = (this.dostime >> 11) & 0x1F;
			var minute:Number = (this.dostime >> 5) & 0x3F;
			var second:Number = (this.dostime << 1) & 0x3E;
			var d:Date = new Date(year, month, date, hour, minute, second);
			return d.time;
//			return year + "年" + month + "月" + date + "日, " + hour + ":" + minute + ":" + second;
		}
		
		/**
		 * 获取 crc-32 检验码。
		 * @return 一个4字节的无符号数。
		 * 
		 */		
		public function getCRC32():uint
		{
			return this.crc32;
		}
		
		/**
		 * 获取压缩后的文件大小，单位：字节。
		 * @return 一个4字节的无符号数。
		 * 
		 */		
		public function getCompressedSize():uint
		{
			return this.compressedSize;
		}
		
		/**
		 * 获取解压缩后的文件大小，单位：字节。
		 * @return 一个4字节的无符号数。
		 * 
		 */		
		public function getSize():uint
		{
			return this.size;
		}
		
		/**
		 * 获取压缩方法(8=DEFLATE; 0=UNCOMPRESSED)。
		 * @return 一个整数。
		 * 
		 */		
		public function getMethod():int
		{
			return this.method;
		}
		
//		/**
//		 * 
//		 * @return 返回一个副本。
//		 * 
//		 */		
//		public function clone():ZipEntry
//		{
//			var b:ByteArray = new ByteArray();
//			b.writeObject(this);
//			b.position = 0;
//			return b.readObject() as ZipEntry;
//		}
		
		/**
		 * 如果这是一个文件夹，则返回 true ，否则返回 false 。
		 * @return 
		 * 
		 */		
		public function isDirectory():Boolean
		{
			return this.name.charAt(this.name.length - 1) ==  "/";
		}
		
		/**
		 * 这里返回属性 name 的值，跟 getName() 方法返回的值一样。
		 * @return 
		 * 
		 */		
		public function toString():String
		{
			return this.name;
		}

	}
}