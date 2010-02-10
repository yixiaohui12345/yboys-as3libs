package com.riaoo.file.zip
{
	internal final class ZipFormat
	{
		/**
		 * zip 文件格式描述类。
		 * 
		 */		
		public function ZipFormat()
		{
		}
		
		/** A. 文件标头 - Local file header **/
		internal static const LOCHDR:uint = 30;         // 总长度
		internal static const LOCSIG:uint = 0x04034b50; // 文件标头签名 4 字节 (0x04034b50)
		internal static const LOCVER:uint = 4;          // 所需版本 2 字节
		internal static const LOCFLG:uint = 6;          // 一般用途位标记 2 字节
		internal static const LOCHOW:uint = 8;          // 压缩方法 2 字节 (8=DEFLATE; 0=UNCOMPRESSED)
		internal static const LOCTIM:uint = 10;         // 文件的最后修改时间 2 字节
		// 文件的最后修改日期 2 字节 [开始 12]
		internal static const LOCCRC:uint = 14;         // crc-32 4 字节
		internal static const LOCSIZ:uint = 18;         // 压缩后的大小 4 字节
		internal static const LOCLEN:uint = 22;         // 解压缩后的大小 4 字节
		internal static const LOCNAM:uint = 26;         // 文件名长度 2 字节
		internal static const LOCEXT:uint = 28;         // 额外字段长度 2 字节
		// 文件名 变量
		// 额外字段 变量
		
		/** B. 文件数据 - File data **/
		
		/** C. 数据描述符记录 - Data descriptor **/
		internal static const EXTHDR:uint = 12;         // 总长度
		internal static const EXTSIG:uint = 0x08074b50; // 
		internal static const EXTCRC:uint = 0;          // crc-32 4 字节
		internal static const EXTSIZ:uint = 4;          // 压缩后的大小 4 字节
		internal static const EXTLEN:uint = 8;          // 解压缩后的大小 4 字节
		
		/** D. 归档解密标头 - Archive decryption header **/
		
		/** E. 归档额外数据记录 - Archive extra data record **/
		// 归档额外数据签名 4 字节 [开始 0] (0x08064b50)
		// 额外字段长度 4 字节 [开始 4]
		// 额外字段 4 字节 [开始 8]
		
		/** F. 中央目录结构 - Central directory structure **/
		internal static const CENHDR:uint = 46;	        // 总长度
		internal static const CENSIG:uint = 0x02014b50; // 中央文件标头签名 4 字节
//		internal static const CENSIG_LENGTH:uint = 4;   // 中央文件标头签名长度 4 字节
		internal static const CENVEM:uint = 4;          // version made by 2 字节
		internal static const CENVER:uint = 6;          // 所需版本 2 字节
		internal static const CENFLG:uint = 8;          // 一般用途位标记 2 字节
		internal static const CENHOW:uint = 10;         // 压缩方法 2 字节
		internal static const CENTIM:uint = 12;         // 文件的最后修改时间 2 字节
		// 文件的最后修改日期 2 字节 [开始 14]
		internal static const CENCRC:uint = 16;         // crc-32 4 字节
		internal static const CENSIZ:uint = 20;         // 压缩后的大小 4 字节
		internal static const CENLEN:uint = 24;         // 解压缩后的大小 4 字节
		internal static const CENNAM:uint = 28;         // 文件名长度 2 字节
		internal static const CENEXT:uint = 30;         // 额外字段长度 2 字节
		internal static const CENCOM:uint = 32;         // 文件注释长度 2 字节
		internal static const CENDSK:uint = 34;         // 磁盘开始号 2 字节
		internal static const CENATT:uint = 36;         // 内部文件属性 2 字节
		internal static const CENATX:uint = 38;         // 外部文件属性 4 字节
		internal static const CENOFF:uint = 42;         // 相关的标头偏移量 4 字节
//		internal static const CENOFF_LENGTH:uint = 4;   // 相关的标头偏移量长度 4 字节
		// 文件名 变量
		// 额外字段 变量
		// 文件注释 变量
		// 数字签名:
		//   标头签名 4 字节 [开始 0] (0x05054b50)
		//   数据大小 2 字节 [开始 4]
		//   签名数据 变量
		
		/** G. 中央目录记录的 Zip64 结尾 - Zip64 end of central directory record **/
		
		/** H. 中央目录定位器的 Zip64 结尾 - Zip64 end of central directory locator **/
		
		/** I. 中央目录记录的结尾 - End of central directory record **/
		internal static const ENDHDR:uint = 22;         // 总长度
		internal static const ENDSIG_LENGTH:uint = 4;	// 中央目录记录签名长度 4 字节
		internal static const ENDSIG:uint = 0x06054b50;	// 中央目录记录签名 4 字节
		// 磁盘编号 2 字节 [开始 4]
		// 中央目录开始磁盘编号 2 字节 [开始 6]
		internal static const ENDSUB:uint = 8;          // 本磁盘上在中央目录里的入口总数 2 字节
		internal static const ENDTOT:uint = 10;	        // 中央目录里的入口总数 2 字节
		internal static const ENDSIZ:uint = 12;         // 中央目录的大小 4 字节
		internal static const ENDOFF:uint = 16;         // 中央目录对第一张磁盘的偏移量 4 字节
		internal static const ENDCOM:uint = 20;         // .ZIP 文件注释长度 2 字节
		// .ZIP 文件注释 变量 [开始 22]
		
		/** 压缩方法 - Compression methods **/
		internal static const STORED   :uint = 0;   // 无压缩
		internal static const DEFLATED :uint = 8; // DEFLATE 压缩算法

	}
}