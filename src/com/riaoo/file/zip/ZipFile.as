package com.riaoo.file.zip
{
	import com.riaoo.file.CRC32;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * 一个 ZipFile 对象代表一个 zip 文件包.
	 * <br />
	 * 利用 ZipFile 类你可以在flash里创建 zip 文件包，也可以修改已有 zip 文件包的各种信息，还可以添加和删除 zip 文件包里的文件。
	 * @author Administrator Y.Boy
	 * 
	 */	
	public class ZipFile
	{
		
		private var _data:ByteArray; // zip 文件包的字节数据。
		private var _entries:Array; // 所有 entry 信息。一个 entry 对应 zip 文件包里的一个文件（包括文件夹）。
		private var _comment:String = "技术支持：Y.Boy | http://riaoo.com"; // zip 文件注释。
		
		/**
		 * 构造函数。在创建一个新的 zip 文件包时，不需要传递参数 data 。
		 * @param data zip 文件包的字节数据。
		 * 
		 */		
		public function ZipFile(data:ByteArray = null)
		{
			_data = new ByteArray();
			_data.endian = Endian.LITTLE_ENDIAN;
			
			if (data)
			{
				_data.writeBytes(data);
				parse();
			}else
			{
				_entries = []; // 0 个 entry
				
				var commentBytes:ByteArray = new ByteArray(); // zip 文件包的注释
				commentBytes.writeMultiByte(_comment, "gb2312");
				
				// 写入 中央目录记录的结尾
				_data.writeUnsignedInt(ZipFormat.ENDSIG); // 中央目录记录签名
				_data.writeShort(0x00); // 磁盘编号。注意：现时不做分卷，只有一卷，所以为 0
				_data.writeShort(0x00); // 中央目录开始磁盘编号。注意：因不做分卷，所以为 0
				_data.writeShort(0x00); // 本磁盘上在中央目录里的入口总数。注意：1. 未知；2. 不做分卷；3. 值跟以下的 中央目录里的入口总数 一样
				_data.writeShort(0x00); // 中央目录里的入口总数。注意：未知
				_data.writeUnsignedInt(0x0000); // 中央目录的大小。注意：未知
				_data.writeUnsignedInt(0x0000); // 中央目录对第一张磁盘的偏移量。注意：1. 未知；2. 不做分卷
				_data.writeShort(commentBytes.length); // .ZIP 文件注释长度
				_data.writeBytes(commentBytes); // .ZIP 文件注释。注意：现在使用了默认值
			}
		}
		
		/**
		 * 获取 zip 文件包的字节数据。
		 * @return 返回 zip 文件包的字节数据。
		 * 
		 */		
		public function get data():ByteArray
		{
			return _data;
		}
		
		/**
		 * 设置 zip 文件包的字节数据。
		 * @param value zip 文件包的字节数据。
		 * 
		 */		
		public function set data(value:ByteArray):void
		{
			value.endian = Endian.LITTLE_ENDIAN;
			_data.clear();
			_data.writeBytes(value);
			value.clear();
			parse();
		}
		
		/**
		 * 获取 zip 文件包里的所有文件。所有 entry 信息。一个 entry 对应 zip 文件包里的一个文件（包括文件夹）。
		 * @return 返回 zip 文件包里的所有文件。
		 * 
		 */		
		public function get entries():Array
		{
			return _entries;
		}
		
		/**
		 * 获取 zip 文件包的注释。
		 * @return 
		 * 
		 */		
		public function get comment():String
		{
			return _comment;
		}
		
		/**
		 * 设置 zip 文件包的注释。
		 * @param value zip 文件包的注释。
		 * 
		 */		
		public function set comment(value:String):void
		{
			var commentBytes:ByteArray = new ByteArray();
			commentBytes.endian = Endian.LITTLE_ENDIAN;
			commentBytes.writeMultiByte(value, "gb2312");
			
			var endSig:uint = getPositionENDSIG();
			_data.position = endSig + ZipFormat.ENDCOM;
			_data.writeShort(commentBytes.length); // 设置 .ZIP 文件注释长度
			_data.length = _data.position + commentBytes.length; // 设置预期的 zip 文件包长度，因为注释的旧值可能比新值要长，要截断多出来的注释
			_data.writeBytes(commentBytes); // 设置注释
			commentBytes.clear();
		}
		
		/**
		 * 获取 zip 文件包里的文件数目。包括文件夹，文件夹是一种特殊的文件。
		 * @return 返回这个 zip 文件包里的文件数目。
		 * 
		 */		
		public function get numEntries():int
		{
			return _entries.length;
		}
		
		/**
		 * 获取这个 zip 文件包的大小，单位：字节。
		 * @return 返回这个 zip 文件包的大小，单位：字节。
		 * 
		 */		
		public function get size():uint
		{
			return _data.length;
		}
		
		/**
		 * 根据指定的名称，获取 zip 文件包里的文件条目（Entry），非字节数据。要获取字节数据，请查阅 ZipEntry.getEntryData() 。
		 * @param name 文件名称，一个包含完整路径的字符串。
		 * @return 返回指定名称的文件条目（Entry）。如果文件不存在，则返回 null 。
		 * 
		 */		
		public function getEntry(name:String):ZipEntry
		{
			for each (var e:ZipEntry in _entries)
			{
				if (name == e.name)
					return e;
			}
			
			return null;
		}
		
		/**
		 * 获取 zip 文件包里指定的文件字节数据。
		 * @param entry 一个 ZipEntry 对象。通常由 getEntry() 方法获得。
		 * @return 返回文件解压缩后的字节数据。
		 * 
		 * @see getEntry()
		 * 
		 */		
		public function getEntryData(entry:ZipEntry):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			
			if (entry && entry.compressedSize > 0)
			{
				_data.position = entry.offsetLOC + ZipFormat.LOCHDR + entry.nameLength + entry.extraLength; // 文件数据位置
				_data.readBytes(bytes, 0, entry.compressedSize);
				switch (entry.method)
				{
					case ZipFormat.DEFLATED:
						bytes.inflate();
						break;
						
					case ZipFormat.STORED:
						break;
						
					default:
						throw new ZipError(ZipError.COMPRESSION_METHOD_INVALID);
				}
			}
			
			return bytes;
		}
		
		/**
		 * 向 zip 文件包里添加一个文件。
		 * @param entry 一个 ZipEntry 对象。
		 * @param entryData 文件的字节数据。通常情况下，字节数据长度为零时，是一个文件夹。假如为 null ，则理论上为文件夹了。
		 * 
		 */		
		public function addEntry(entry:ZipEntry, entryData:ByteArray = null):void
		{
			// 验证信息
			if (!entry.name)
			{
				throw new ZipError(ZipError.FILE_NAME_IS_NULL);
			}else if (getEntry(entry.name))
			{
				throw new ZipError(ZipError.FILE_EXISTED);
			}
			
			if (!entryData)
				entryData = new ByteArray();
			
			var newData:ByteArray = new ByteArray();
			var bytesLOC:ByteArray = new ByteArray(); // 文件标头 - Local file header
			var bytesCEN:ByteArray = new ByteArray(); // 中央目录结构 - Central directory structure
			var nameBytes:ByteArray = new ByteArray();
			var commentBytes:ByteArray = new ByteArray();
			var oldEndSig:uint = getPositionENDSIG();
			var isDirectory:Boolean = entry.name.charAt(entry.name.length - 1) ==  "/";
			newData.endian = Endian.LITTLE_ENDIAN;
			bytesLOC.endian = Endian.LITTLE_ENDIAN;
			bytesCEN.endian = Endian.LITTLE_ENDIAN;
			nameBytes.endian = Endian.LITTLE_ENDIAN;
			commentBytes.endian = Endian.LITTLE_ENDIAN;
			entryData.endian = Endian.LITTLE_ENDIAN;
			nameBytes.writeMultiByte(entry.name, "gb2312");
			commentBytes.writeMultiByte(entry.comment, "gb2312");
			
			// 完善 entry 信息
			entry.versionMadeBy = 20;
			entry.flag = 0;
			entry.dostime = getDosTime(new Date().time);
			if (isDirectory)
			{
				entry.version = 10;
				entry.method = 0;
				entry.extFileAttributes = 16;
				entry.compressedSize = 0;
				entry.size = 0;
				entry.crc32 = 0;
			}else
			{
				var crc32:CRC32 = new CRC32();
				crc32.update(entryData); // 必须是未压缩数据
				entry.crc32 = crc32.getValue();
				entry.size = entryData.length;
				entryData.deflate(); // 压缩数据
				entry.compressedSize = entryData.length;
				entry.version = 20;
				entry.method = 8;
				entry.extFileAttributes = 32;
			}
			entry.nameLength = nameBytes.length;
			entry.extraLength = entry.extra.length;
			entry.commentLength = commentBytes.length;
			entry.diskNumberStart = 0;
			entry.intFileAttributes = 0;
			if (_entries.length)
			{
				entry.offsetLOC = (_entries[0] as ZipEntry).offsetCEN;
				for each (var e:ZipEntry in _entries)
				{
					if (e.offsetCEN < entry.offsetLOC)
						entry.offsetLOC = e.offsetCEN;
				}
			}else
			{
				entry.offsetLOC = 0;
			}
			entry.offsetCEN = oldEndSig; // 还要加上 bytesLOC.length 的，在稍后会加上
			_entries.push(entry); // 添加到 _entries 列表中
			
			// 建立 loc
			bytesLOC.position = 0;
			bytesLOC.writeUnsignedInt(ZipFormat.LOCSIG);
			bytesLOC.writeShort(entry.version);
			bytesLOC.writeShort(entry.flag);
			bytesLOC.writeShort(entry.method);
			bytesLOC.writeUnsignedInt(entry.dostime);
			bytesLOC.writeUnsignedInt(entry.crc32);
			bytesLOC.writeUnsignedInt(entry.compressedSize);
			bytesLOC.writeUnsignedInt(entry.size);
			bytesLOC.writeShort(entry.nameLength);
			bytesLOC.writeShort(entry.extraLength);
			bytesLOC.writeBytes(nameBytes);
			bytesLOC.writeBytes(entry.extra);
			bytesLOC.writeBytes(entryData);
			
			// 建立 cen
			bytesCEN.position = 0;
			bytesCEN.writeUnsignedInt(ZipFormat.CENSIG);
			bytesCEN.writeShort(entry.versionMadeBy);
			bytesCEN.writeShort(entry.version);
			bytesCEN.writeShort(entry.flag);
			bytesCEN.writeShort(entry.method);
			bytesCEN.writeUnsignedInt(entry.dostime);
			bytesCEN.writeUnsignedInt(entry.crc32);
			bytesCEN.writeUnsignedInt(entry.compressedSize);
			bytesCEN.writeUnsignedInt(entry.size);
			bytesCEN.writeShort(entry.nameLength);
			bytesCEN.writeShort(entry.extraLength);
			bytesCEN.writeShort(entry.commentLength);
			bytesCEN.writeShort(entry.diskNumberStart);
			bytesCEN.writeShort(entry.intFileAttributes);
			bytesCEN.writeUnsignedInt(entry.extFileAttributes);
			bytesCEN.writeUnsignedInt(entry.offsetLOC);
			bytesCEN.writeBytes(nameBytes);
			bytesCEN.writeBytes(entry.extra);
			bytesCEN.writeBytes(commentBytes);
			
			// 所有 entry.offsetCEN 都要增加 bytesLOC.length
			for each (var ze:ZipEntry in _entries)
			{
				ze.offsetCEN += bytesLOC.length;
			}
			
			// 建立新的 zip 文件包字节数据
			newData.position = 0;
			if (entry.offsetLOC)
				newData.writeBytes(_data, 0, entry.offsetLOC);
			newData.writeBytes(bytesLOC);
			if (entry.offsetLOC)
				newData.writeBytes(_data, entry.offsetLOC, oldEndSig - entry.offsetLOC);
			newData.writeBytes(bytesCEN);
			newData.writeBytes(_data, oldEndSig, _data.length - oldEndSig);
			_data.clear();
			_data.writeBytes(newData);
			
			// 修改 中央目录记录的结尾 的相关信息
			updateValueOfENDOFF();
			updateValueOfENDSIZ(bytesCEN.length);
			updateValueOfENDSUB();
			updateValueOfENDTOT();
			
			// 释放资源
			newData.clear();
			bytesLOC.clear();
			bytesCEN.clear();
			nameBytes.clear();
			commentBytes.clear();
		}
		
		/**
		 * 删除指定的文件。
		 * @param entry 要删除的文件对应的 entry 。
		 * @return 返回已删除文件的字节数据。
		 * 
		 */		
		public function removeEntry(entry:ZipEntry):ByteArray
		{
			var removedData:ByteArray = getEntryData(entry);
			
			// 在 _entries 移除 entry
			for (var i:int = 0; i < _entries.length; i++)
			{
				var e:ZipEntry = _entries[i] as ZipEntry;
				if (entry.name == e.name)
				{
					_entries.splice(i, 1);
					break;
				}
			}
			
			var locLength:uint = entry.compressedSize + ZipFormat.LOCHDR + entry.nameLength + entry.extraLength;
			var cenLength:uint = ZipFormat.CENHDR + entry.nameLength + entry.extraLength + entry.commentLength;
			// 修改 offsetLOC、offsetCEN
			for each (var ze:ZipEntry in _entries)
			{
				if (ze.offsetLOC > entry.offsetLOC)
				{
					ze.offsetLOC -= locLength;
					updateValueOfCENDOFF(ze, ze.offsetLOC);
				}
				
				ze.offsetCEN -= locLength;
				if (ze.offsetCEN > entry.offsetCEN)
					ze.offsetCEN -= cenLength;
			}
			
			// 修改 _data
			var newData:ByteArray = new ByteArray();
			newData.endian = Endian.LITTLE_ENDIAN;
			newData.position = 0;
			if (entry.offsetLOC)
				newData.writeBytes(_data, 0, entry.offsetLOC);
			newData.writeBytes(_data, entry.offsetLOC + locLength, entry.offsetCEN - entry.offsetLOC - locLength);
			newData.writeBytes(_data, entry.offsetCEN + cenLength, _data.length - entry.offsetCEN - cenLength);
			_data.clear();
			_data.writeBytes(newData);
			newData.clear();
			
			// 修改 ENDSUB、ENDTOT、ENDSIZ、ENDOFF
			updateValueOfENDOFF();
			updateValueOfENDSIZ(-cenLength);
			updateValueOfENDSUB();
			updateValueOfENDTOT();
			
			parse();
			
			return removedData;
		}
		
		/**
		 * 修改文件名。
		 * @param entry 需要修改名称的文件。
		 * @param name 新名称。
		 * 
		 */		
		public function setEntryName(entry:ZipEntry, name:String):void
		{
			var nameBytes:ByteArray = new ByteArray();
			nameBytes.endian = Endian.LITTLE_ENDIAN;
			nameBytes.writeMultiByte(name, "gb2312");
			
			var lengthOffset:uint = nameBytes.length - entry.nameLength; // 长度差
			
			// Local file header - length
			_data.position = entry.offsetLOC + ZipFormat.LOCNAM;
			_data.writeShort(nameBytes.length);
			
			// Central directory structure - length
			_data.position = entry.offsetCEN + ZipFormat.CENNAM;
			_data.writeShort(nameBytes.length);
			
			// 中央目录结构 - 相关的标头偏移量
			for each(var e:ZipEntry in _entries)
			{
				if (e.offsetLOC > entry.offsetLOC)
				{
					_data.position = e.offsetCEN + ZipFormat.CENOFF;
					_data.writeUnsignedInt(e.offsetLOC + lengthOffset);
				}
			}
			
			// data - ByteArray
			var divideLOC:uint = entry.offsetLOC + ZipFormat.LOCHDR;
			var divideCEN:uint = entry.offsetCEN + ZipFormat.CENHDR;
			var newData:ByteArray = new ByteArray();
			newData.endian = Endian.LITTLE_ENDIAN;
			newData.writeBytes(_data, 0, divideLOC);
			newData.writeBytes(nameBytes);
			newData.writeBytes(_data, divideLOC + entry.nameLength, divideCEN - divideLOC - entry.nameLength);
			newData.writeBytes(nameBytes);
			newData.writeBytes(_data, divideCEN + entry.nameLength, _data.length - divideCEN - entry.nameLength);
			_data.clear();
			_data.writeBytes(newData);
			
			// 修改 entries 信息 及 相关的标头偏移量
			entry.name = name;
			entry.nameLength = nameBytes.length;
			for each (var ze:ZipEntry in _entries)
			{
				// LOC
				if (ze.offsetLOC > entry.offsetLOC)
					ze.offsetLOC += lengthOffset; // 相关的标头偏移量：无论是 entry 信息还是 _data 上的值都要改变
				
				// CEN
				ze.offsetCEN += lengthOffset; // 第一次，LOC 变动时，全部 CEN 都要改变
				if (ze.offsetCEN > entry.offsetCEN)
					ze.offsetCEN += lengthOffset; // 第二次，CEN 变动时，只有后面的才需要改变
			}
			
			// 修改 中央目录记录的结尾 的相关信息
			updateValueOfENDSIZ(lengthOffset);
			updateValueOfENDOFF();
			
			newData.clear();
			nameBytes.clear();
		}
		
		/**
		 * 修改文件的额外字段。
		 * @param entry 需要修改额外字段的文件。
		 * @param extra 新的额外字段。
		 * 
		 */		
		public function setEntryExtra(entry:ZipEntry, extra:ByteArray):void
		{
			extra.endian = Endian.LITTLE_ENDIAN;
			var lengthOffset:uint = extra.length - entry.extraLength;
			
			_data.position = entry.offsetLOC + ZipFormat.LOCEXT;
			_data.writeShort(extra.length); // Local file header
			
			_data.position = entry.offsetCEN + ZipFormat.CENEXT;
			_data.writeShort(extra.length); // Central directory structure
			
			// 中央目录结构 - 相关的标头偏移量
			for each(var e:ZipEntry in _entries)
			{
				if (e.offsetLOC > entry.offsetLOC)
				{
					_data.position = e.offsetCEN + ZipFormat.CENOFF;
					_data.writeUnsignedInt(e.offsetLOC + lengthOffset);
				}
			}
			
			var divideLOC:uint = entry.offsetLOC + ZipFormat.LOCHDR + entry.nameLength;
			var divideCEN:uint = entry.offsetCEN + ZipFormat.CENHDR + entry.nameLength;
			var newData:ByteArray = new ByteArray();
			newData.endian = Endian.LITTLE_ENDIAN;
			newData.writeBytes(_data, 0, divideLOC);
			newData.writeBytes(extra);
			newData.writeBytes(_data, divideLOC + entry.extraLength, divideCEN - divideLOC - entry.extraLength);
			newData.writeBytes(extra);
			newData.writeBytes(_data, divideCEN + entry.extraLength, _data.length - divideCEN - entry.extraLength);
			_data.clear();
			_data.writeBytes(newData);
			newData.clear();
			
			entry.extraLength = extra.length;
			entry.extra = extra;
			for each (var ze:ZipEntry in _entries)
			{
				// LOC
				if (ze.offsetLOC > entry.offsetLOC)
					ze.offsetLOC += lengthOffset; // 相关的标头偏移量：无论是 entry 信息还是 _data 上的值都要改变
				
				// CEN
				ze.offsetCEN += lengthOffset; // 第一次，LOC 变动时，全部 CEN 都要改变
				if (ze.offsetCEN > entry.offsetCEN)
					ze.offsetCEN += lengthOffset; // 第二次，CEN 变动时，只有后面的才需要改变
			}
			
			// 修改 中央目录记录的结尾 的相关信息
			updateValueOfENDSIZ(lengthOffset);
			updateValueOfENDOFF();
		}
		
		/**
		 * 修改文件注释。
		 * @param entry 需要修改文件注释的文件。
		 * @param comment 新的文件注释。
		 * 
		 */		
		public function setEntryComment(entry:ZipEntry, comment:String):void
		{
			var commentBytes:ByteArray = new ByteArray();
			commentBytes.endian = Endian.LITTLE_ENDIAN;
			commentBytes.writeMultiByte(comment, "gb2312");
			
			// 修改文件注释长度
			_data.position = entry.offsetCEN + ZipFormat.CENCOM;
			_data.writeShort(commentBytes.length);
			
			// 修改文件注释
			var divide:uint = entry.offsetCEN + ZipFormat.CENHDR + entry.nameLength + entry.extraLength; // 分割界限
			var newData:ByteArray = new ByteArray();
			newData.endian = Endian.LITTLE_ENDIAN;
			newData.writeBytes(_data, 0, divide);
			newData.writeBytes(commentBytes); // 新注释
			newData.writeBytes(_data, divide + entry.commentLength, _data.length - divide - entry.commentLength); // 剩下部分
			_data.clear();
			_data.writeBytes(newData);
			
			// 修改 entries 信息
			var lengthOffset:uint = commentBytes.length - entry.commentLength; // 新旧注释长度的差距
			entry.comment = comment;
			entry.commentLength = commentBytes.length;
			for each (var e:ZipEntry in _entries)
			{
				if (e.offsetCEN > entry.offsetCEN)
					e.offsetCEN += lengthOffset; // 修改后面的 entry 的偏移量
			}
			
			// 修改 中央目录记录的结尾 的相关信息
			updateValueOfENDSIZ(lengthOffset);
			updateValueOfENDOFF();
			
			newData.clear();
			commentBytes.clear();
		}
		
		/**
		 * 修改文件的最后修改时间。
		 * @param entry 需要修改最后修改时间的文件。
		 * @param time 新的时间。自 1970 年 1 月 1 日午夜（通用时间）以来的毫秒数。
		 * 
		 */		
		public function setEntryTime(entry:ZipEntry, time:Number):void
		{
			entry.dostime = getDosTime(time);
			
			// 修改 文件标头 - Local file header
			_data.position = entry.offsetLOC + ZipFormat.LOCTIM;
			_data.writeUnsignedInt(entry.dostime);
			
			// 修改 中央目录结构的文件标头 - Central directory structure
			_data.position = entry.offsetCEN + ZipFormat.CENTIM;
			_data.writeUnsignedInt(entry.dostime);
		}
		
//		/**
//		 * 
//		 * @return 返回一个副本。
//		 * 
//		 */		
//		public function clone():ZipFile
//		{
//			var b:ByteArray = new ByteArray();
//			b.writeObject(this);
//			b.position = 0;
//			return b.readObject() as ZipFile;
//		}
		
		/**
		 * 
		 * @return 返回在 中央目录记录的结尾 的 中央目录记录签名 的位置。
		 * 
		 */		
		private function getPositionENDSIG():uint
		{
			// 一个 entry 也没有时
			_data.position = 0;
			if (_data.readUnsignedInt() == ZipFormat.ENDSIG)
				return _data.position - ZipFormat.ENDSIG_LENGTH;
			
			// 有 entry 时
			_data.position = _data.length - ZipFormat.ENDSIG_LENGTH;
			while (_data.position > ZipFormat.ENDSIG_LENGTH)
			{
				if (_data.readInt() == ZipFormat.ENDSIG)
					return _data.position - ZipFormat.ENDSIG_LENGTH;
				
				_data.position -= ZipFormat.ENDSIG_LENGTH + 1;
			}
			
			throw new ZipError(ZipError.ZIP_INVALID);
			return 0;
		}
		
		/**
		 * 
		 * @return 返回 中央目录对第一张磁盘的偏移量 。
		 * 
		 */		
		private function getPositionCENSIG():uint
		{
			var endSig:uint = getPositionENDSIG();
			_data.position = endSig + ZipFormat.ENDOFF; 
			return _data.readUnsignedInt();
		}
		
		/**
		 * 把表示日期时间的毫秒数转为 DOS 时间。
		 * @param time 自 1970 年 1 月 1 日午夜（通用时间）以来的毫秒数。
		 * 
		 */		
		private function getDosTime(time:Number):uint
		{
			var d:Date = new Date(time);
			var dostime:uint = 
					(d.fullYear - 1980 & 0x7F) << 25
					| (d.month + 1) << 21
					| d.date << 16
					| d.hours << 11
					| d.minutes << 5
					| d.seconds >> 1;
			return dostime;
		}
		
		/**
		 * 分析 中央目录结构 ，获得文件总数、 zip 文件注释、所有 entry 信息。
		 * 
		 */		
		private function parse():void
		{
//			trace("\n====================== parse ========================");
			
			var endSig:uint = getPositionENDSIG();
			
			// 中央目录里的入口总数，即文件总数
			_data.position = endSig + ZipFormat.ENDTOT;
			_entries = new Array(_data.readShort());
			
			// .ZIP 文件注释
			_data.position = endSig + ZipFormat.ENDCOM; // .ZIP 文件注释长度
			_comment = _data.readMultiByte(_data.readShort(), "gb2312");
			
			// 获取所有 entry
			_data.position = getPositionCENSIG();
			for (var i:int = 0; i < _entries.length; i++)
			{
				var entry:ZipEntry      = new ZipEntry("");
				entry.offsetCEN         = _data.position;
										  _data.readUnsignedInt().toString(16); // 标头签名。没用抛掉，以使 _data.position 递增 4
				entry.versionMadeBy     = _data.readShort();
				entry.version           = _data.readShort();
				entry.flag              = _data.readShort();
				entry.method            = _data.readShort();
				entry.dostime           = _data.readUnsignedInt();
				entry.crc32             = _data.readUnsignedInt();
				entry.compressedSize    = _data.readUnsignedInt();
				entry.size              = _data.readUnsignedInt();
				entry.nameLength        = _data.readShort();
				entry.extraLength       = _data.readShort();
				entry.commentLength     = _data.readShort();
				entry.diskNumberStart   = _data.readShort();
				entry.intFileAttributes = _data.readShort();
				entry.extFileAttributes = _data.readUnsignedInt();
				entry.offsetLOC         = _data.readUnsignedInt();
				entry.name              = _data.readMultiByte(entry.nameLength, "gb2312");
				if (entry.extraLength)
					_data.readBytes(entry.extra, 0, entry.extraLength);
//				以上两行可代替为：
//				entry.extra.writeBytes(_data, _data.position, entry.extraLength);
//				_data.position += entry.extraLength;
				entry.comment           = _data.readMultiByte(entry.commentLength, "gb2312");
				_entries[i] = entry;
				
				// 单个文件（entry）信息
//				trace("version made by", entry.versionMadeBy);
//				trace("所需版本", entry.version);
//				trace("一般用途位标记", entry.flag);
//				trace("压缩方法", entry.method);
//				trace("文件的最后修改时间 + 文件的最后修改日期", new Date(entry.getTime()).toString());
//				trace("crc-32", entry.crc32.toString(16));
//				trace("压缩后的大小", entry.compressedSize);
//				trace("解压缩后的大小", entry.size);
//				trace("文件名长度", entry.nameLength);
//				trace("额外字段长度", entry.extraLength);
//				trace("文件注释长度", entry.commentLength);
//				trace("磁盘开始号", entry.diskNumberStart);
//				trace("内部文件属性", entry.intFileAttributes);
//				trace("外部文件属性", entry.extFileAttributes);
//				trace("相关的标头偏移量", entry.offsetLOC);
//				trace("在 中央目录结构 里的标头偏移量", entry.offsetCEN);
//				trace("文件名", entry.name);
//				trace("额外字段", entry.extra.readMultiByte(entry.extraLength, "gb2312"));
//				trace("文件注释", entry.comment);
//				trace("================");
				
			} // end for
			
			// 全面分析 中央目录记录的结尾
//			_data.position = endSig;
//			trace("中央目录记录的结尾 的位置", endSig);
//			trace("中央目录记录签名", "0x" + _data.readUnsignedInt().toString(16));
//			trace("磁盘编号", _data.readShort());
//			trace("中央目录开始磁盘编号", _data.readShort());
//			trace("本磁盘上在中央目录里的入口总数", _data.readShort());
//			trace("中央目录里的入口总数", _data.readShort());
//			trace("中央目录的大小", _data.readUnsignedInt());
//			trace("中央目录对第一张磁盘的偏移量", _data.readUnsignedInt());
//			trace(".ZIP 文件注释长度", _data.readShort());
//			trace(".ZIP 文件注释", _comment);
			
		} // end parse()
		
		/**
		 * 更新 相关的标头偏移量 。
		 * @param entry 要修改的 entry 。
		 * @param value 相关的标头偏移量 的新值。
		 * 
		 */		
		private function updateValueOfCENDOFF(entry:ZipEntry, value:uint):void
		{
			_data.position = entry.offsetCEN + ZipFormat.CENOFF;
			_data.writeUnsignedInt(value);
		}
		
		/**
		 * 更新 中央目录记录的结尾 的 中央目录的大小。
		 * @param lengthOffset 长度差 = 新值 - 旧值。
		 * 
		 */		
		private function updateValueOfENDSIZ(lengthOffset:uint):void
		{
			var endSig:uint = getPositionENDSIG();
			_data.position = endSig + ZipFormat.ENDSIZ;
			var newEndSize:uint = _data.readUnsignedInt() + lengthOffset;
			_data.position = endSig + ZipFormat.ENDSIZ;
			_data.writeUnsignedInt(newEndSize);
		}
		
		/**
		 * 更新 中央目录记录的结尾 的 中央目录对第一张磁盘的偏移量 。
		 * @param endSig 中央目录记录签名 的位置。
		 * 
		 */		
		private function updateValueOfENDOFF():void
		{
			var endSig:uint = getPositionENDSIG();
			
			var newEndOffset:uint
			if (_entries.length)
			{
				newEndOffset = (_entries[0] as ZipEntry).offsetCEN;
				for each (var entry:ZipEntry in _entries)
				{
					if (entry.offsetCEN < newEndOffset)
						newEndOffset = entry.offsetCEN;
				}
			}else
			{
				newEndOffset = 0;
			}
			_data.position = endSig + ZipFormat.ENDOFF;
			_data.writeUnsignedInt(newEndOffset);
		}
		
		/**
		 * 更新 本磁盘上在中央目录里的入口总数。
		 * 
		 */		
		private function updateValueOfENDSUB():void
		{
			var endSig:uint = getPositionENDSIG();
			_data.position = endSig + ZipFormat.ENDSUB;
			_data.writeShort(_entries.length);
		}
		
		/**
		 * 更新 中央目录里的入口总数。
		 * 
		 */		
		private function updateValueOfENDTOT():void
		{
			var endSig:uint = getPositionENDSIG();
			_data.position = endSig + ZipFormat.ENDTOT;
			_data.writeShort(_entries.length);
		}

	} // end class
} // end package