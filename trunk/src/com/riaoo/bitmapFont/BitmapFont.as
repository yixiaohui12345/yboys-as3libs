package com.riaoo.bitmapFont
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * 位图字体。
	 * @author yboyjiang
	 */	
	public class BitmapFont
	{
		/**
		 * 字体名称。
		 */		
		protected var m_fontName:String;
		
		/**
		 * 位图数据源。
		 */		
		protected var m_bitmapData:BitmapData;
		
		/**
		 * 字符映射表：字符=索引。
		 */		
		protected var m_charMap:Dictionary;
		
		/**
		 * CharItem 数据。
		 */		
		protected var m_charItemList:Vector.<CharItem>;
		
		protected var m_pt:Point; // 为提高性能的临时变量
		
		/**
		 * 构造函数。
		 * @param bitmapData 位图数据源。
		 * @param config 配置信息。
		 */		
		public function BitmapFont(bitmapData:BitmapData, config:XML)
		{
			this.m_bitmapData = bitmapData;
			this.m_fontName = String(config.@fontName);
			
			var itemList:XMLList = config.Item;
			var count:int = itemList.length();
			this.m_charMap = new Dictionary();
			this.m_charItemList = new Vector.<CharItem>(count, true);
			for (var i:int = 0; i < count; i++)
			{
				var item:XML = itemList[i];
				var charItem:CharItem = new CharItem();
				charItem.decode(item);
				this.m_charItemList[i] = charItem;
				this.m_charMap[charItem.char] = i;
			}
		}
		
		public function get fontName():String
		{
			return this.m_fontName;
		}
		
		/**
		 * 指定能否使用当前的字体显示提供的字符串。
		 * @param str
		 * @return 
		 */		
		public function hasGlyphs(str:String):Boolean
		{
			var count:int = str.length;
			for (var i:int = 0; i < count; i++)
			{
				var char:String = str.charAt(i);
				if (!this.m_charMap[char])
				{
					return false;
				}
			}
			return true;
		}
		
		/**
		 * 向目标位图写入指定字符的像素数据。一次只能写入一个字符。
		 * @param targetBitmapData 目标位图。
		 * @param targetPoint 目标点。
		 * @param char 要写入的字符。
		 * @return 如果写入成功，则返回 true 。
		 */		
		public function pastePixels(targetBitmapData:BitmapData, targetPoint:Point, char:String):Boolean
		{
			if (!char)
			{
				return false;
			}
			
			var i:Object = this.m_charMap[char];
			if (i === null)
			{
				return false;
			}
			
			var charItem:CharItem = this.m_charItemList[i];
			this.m_pt ||= new Point();
			this.m_pt.x = charItem.rect.x;
			this.m_pt.y = charItem.rect.y;
			targetBitmapData.copyPixels(this.m_bitmapData, charItem.rect, targetPoint, this.m_bitmapData, this.m_pt, true);
			return true;
		}
		
		/**
		 * 获取指定单个字符的宽度。
		 * @param char
		 * @return
		 */		
		public function getCharWidth(char:String):int
		{
			var i:Object = this.m_charMap[char];
			if (i === null)
			{
				return 0;
			}
			return this.m_charItemList[i].rect.width;
		}
		
		/**
		 * 获取指定单个字符的高度。
		 * @param char
		 * @return
		 */		
		public function getCharHeight(char:String):int
		{
			var i:Object = this.m_charMap[char];
			if (i === null)
			{
				return 0;
			}
			return this.m_charItemList[i].rect.height;
		}
		
		/**
		 * 获取指定单个字符的垂直偏移量。偏移量是指从顶部到注册点的距离。
		 * @param char
		 * @return 
		 */		
		public function getCharOffsetY(char:String):int
		{
			var i:Object = this.m_charMap[char];
			if (i === null)
			{
				return 0;
			}
			return this.m_charItemList[i].offsetY;
		}
		
		//--------------------------------------
		// 静态
		//--------------------------------------
		
		private static var _fontMap:Dictionary; // 字体字典
		
		/**
		 * 列出所有可用的位图字体。
		 * @return 
		 */		
		public static function enumerateFonts():Vector.<BitmapFont>
		{
			var result:Vector.<BitmapFont> = new Vector.<BitmapFont>();
			for each (var font:BitmapFont in _fontMap)
			{
				result.push(font);
			}
			return result;
		}
		
		/**
		 * 注册一种位图字体。
		 * @param bitmapFont
		 */		
		public static function registerFont(bitmapFont:BitmapFont):void
		{
			if (!_fontMap)
			{
				_fontMap = new Dictionary();
			}
			_fontMap[bitmapFont.fontName] = bitmapFont;
		}
		
		/**
		 * 获取指定字体名称的字体。
		 * @param fontName 字体名称。
		 * @return 
		 */		
		public static function getFont(fontName:String):BitmapFont
		{
			if (_fontMap)
			{
				return _fontMap[fontName];
			}
			return null;
		}
		
	}
}
import flash.geom.Rectangle;

/**
 * 解析 xml 中的每个 Item 节点。
 * 如：
	<BitmapFont fontName="YBoyName">
		<Item char="不" x="0" y="0" width="99" height="89" offsetX="49" offsetY="72"/>
	</BitmapFont>
 * @author yboyjiang
 */
class CharItem
{
	public var char:String;
	public var rect:Rectangle;
	public var offsetX:int;
	public var offsetY:int;
	
	public function decode(xml:XML):void
	{
		this.char = String(xml.@char);
		this.rect = new Rectangle();
		this.rect.x = int(xml.@x);
		this.rect.y = int(xml.@y);
		this.rect.width = int(xml.@width);
		this.rect.height = int(xml.@height);
		this.offsetX = int(xml.@offsetX);
		this.offsetY = int(xml.@offsetY);
	}
	
}