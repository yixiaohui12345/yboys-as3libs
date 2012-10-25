package com.riaoo.bitmapFont
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * 位图文本框。
	 * @author yboyjiang
	 */	
	public class BitmapTextField extends Bitmap
	{
		protected var m_textFormat:BitmapTextFormat;
		protected var m_text:String;
		protected var m_width:int;
		protected var m_height:int;
		protected var m_font:BitmapFont;
		
		/**
		 * 构造函数。
		 */		
		public function BitmapTextField()
		{
			this.m_textFormat = new BitmapTextFormat();
		}
		
		/**
		 * 设置文本样式。
		 * @param value
		 */		
		public function set textFormat(value:BitmapTextFormat):void
		{
			this.m_textFormat.copy(value);
		}
		public function get textFormat():BitmapTextFormat
		{
			return this.m_textFormat.clone();
		}
		
		/**
		 * 字体。
		 */		
		public function set font(value:String):void
		{
			this.m_font = BitmapFont.getFont(value);
		}
		public function get font():String
		{
			return this.m_font ? this.m_font.fontName : "";
		}
		
		/**
		 * 文本。
		 */		
		public function set text(value:String):void
		{
			this.m_text = value;
		}
		public function get text():String
		{
			return this.m_text;
		}
		
		/**
		 * 文本长度。
		 * @return 
		 */		
		public function get length():int
		{
			return this.m_text.length;
		}
		
		/**
		 * 被重写了机制。设置该值并不会对显示对象的宽度进行拉伸。设置此属性以指明“画布”的宽度，字符会写在此“画布”上。
		 */		
		override public function set width(value:Number):void
		{
			this.m_width = value;
		}
		override public function get width():Number
		{
			return this.m_width;
		}
		
		/**
		 * 被重写了机制。设置该值并不会对显示对象的高度进行拉伸。设置此属性以指明“画布”的高度，字符会写在此“画布”上。
		 */		
		override public function set height(value:Number):void
		{
			this.m_height = value;
		}
		override public function get height():Number
		{
			return this.m_height;
		}
		
		/**
		 * 文本的最小宽度。
		 */		
		public function get textWidth():int
		{
			if (this.m_text && this.m_font)
			{
				var arr:Array = this.m_text.split("\n");
				var maxWidth:int = 0;
				for each (var str:String in arr)
				{
					var len:int = str.length;
					var sumWidth:int = 0;
					for (var i:int = 0; i < len; i++) // 累加每个字符所占的宽度
					{
						sumWidth += this.m_font.getCharWidth(str.charAt(i)); // 字符宽度
						sumWidth += this.m_textFormat.letterSpacing; // 字符间距
					}
					sumWidth -= this.m_textFormat.letterSpacing; // 减去最后一个多加的字符间距
					if (maxWidth < sumWidth)
					{
						maxWidth = sumWidth;
					}
				}
				return maxWidth;
			}
			return 0;
		}
		
		/**
		 * 文本的最小高度。
		 */		
		public function get textHeight():int
		{
			if (this.m_text && this.m_font)
			{
				var arr:Array = this.m_text.split("\n");
				var sumHeight:int = 0;
				for each (var str:String in arr) // 行
				{
					var len:int = str.length;
					var maxHeight:int = 0; // 当前行所需要的高度
					var maxOffsetY_top:int = 0; // 注册点到 顶部 的最大距离
					var maxOffsetY_bottom:int = 0;  // 注册点到 底部 的最大距离
					for (var i:int = 0; i < len; i++) // 列：单个字符
					{
						var char:String = str.charAt(i);
						var charHeight:int = this.m_font.getCharHeight(char);
						var charOffsetY:int = this.m_font.getCharOffsetY(char);
						if (maxOffsetY_top < charOffsetY)
						{
							maxOffsetY_top = charOffsetY;
						}
						var offsetY_bottom:int = charHeight - charOffsetY;
						if (maxOffsetY_bottom < offsetY_bottom)
						{
							maxOffsetY_bottom = offsetY_bottom;
						}
					}
					maxHeight = maxOffsetY_top + maxOffsetY_bottom;
					sumHeight += maxHeight + this.m_textFormat.leading;
				}
				sumHeight -= this.m_textFormat.leading; // 减去最后一个多加的行距
				return sumHeight;
			}
			return 0;
		}
		
		/**
		 * 释放内存。
		 */		
		public function dispose():void
		{
			this.bitmapData.dispose();
			this.bitmapData = null;
			this.m_textFormat = null;
		}
		
		/**
		 * 渲染。只有在调用此方法后，才有文本显示出来。
		 * <br/>
		 * <strong>注意：</strong>
		 * <ul>
		 * 	<li>如果指定字体不包含字符，则会忽略掉。</li>
		 * 	<li>连续出现多个换行符时，会被视为一个换行。</li>
		 * </ul>
		 */		
		public function render():void
		{
			if (this.bitmapData)
			{
				this.bitmapData.dispose();
				this.bitmapData = null;
			}
			
			if (this.m_text && this.m_font && this.m_width && this.m_height)
			{
				var bg:BitmapData = new BitmapData(this.m_width, this.m_height, true, this.textFormat.backgroundColor);
				var isRightAlign:Boolean = this.m_textFormat.align == BitmapTextFormatAlign.RIGHT;
				var pt:Point = new Point();
				// 起始的点
				var startX:int = isRightAlign
					? this.m_width - this.m_textFormat.paddingRight
					: this.m_textFormat.paddingLeft;
				var startY:int = this.m_textFormat.paddingTop;
				pt.x = startX;
				pt.y = startY;
				var strArr:Array = this.m_text.split("\n");
				var len:int = strArr.length; // 行数
				for (var i:int = 0; i < len; i++) // 逐行渲染
				{
					var str:String = strArr[i]; // 当前行的字符串
					var numChar:int = str.length;
					
					var listChar:Vector.<String> = new Vector.<String>(numChar, true);
					var listCharWidth:Vector.<int> = new Vector.<int>(numChar, true);
					var listCharOffsetY:Vector.<int> = new Vector.<int>(numChar, true);
					
					var char:String = ""; // 遍历中，当前的字符
					var charWidth:int = 0;
					var charHeight:int = 0;
					var charOffsetY:int = 0;
					
					var maxHeight:int = 0; // 当前行所需要的高度
					var maxOffsetY_top:int = 0; // 注册点到 顶部 的最大距离
					var maxOffsetY_bottom:int = 0;  // 注册点到 底部 的最大距离
					
					// 寻找这一行中某个字符，最大的高度。并作数据的缓存。
					for (var n:int = 0; n < numChar; n++)
					{
						char = str.charAt(n);
						charWidth = this.m_font.getCharWidth(char);
						charHeight = this.m_font.getCharHeight(char);
						charOffsetY = this.m_font.getCharOffsetY(char);
						listChar[n] = char;
						listCharWidth[n] = charWidth;
						listCharOffsetY[n] = charOffsetY;
						if (maxOffsetY_top < charOffsetY)
						{
							maxOffsetY_top = charOffsetY;
						}
						var offsetY_bottom:int = charHeight - charOffsetY;
						if (maxOffsetY_bottom < offsetY_bottom)
						{
							maxOffsetY_bottom = offsetY_bottom;
						}
					}
					maxHeight = maxOffsetY_top + maxOffsetY_bottom;
					
					// 右对齐
					if (isRightAlign)
					{
						while (numChar--)
						{
							char = listChar[numChar];
							if (char != " ")
							{
								charWidth = listCharWidth[numChar];
								pt.x -= charWidth; // 右对齐需要减去一个字符的宽度
								charOffsetY = listCharOffsetY[numChar];
								pt.y += maxOffsetY_top - charOffsetY; // 偏移，对齐注册点
								
								// 渲染
								this.m_font.pastePixels(bg, pt, char);
							}
							
							// 下一个字符的 x 位置
							pt.x -= this.m_textFormat.letterSpacing;
							pt.y = startY;
						}
					}
					// 左对齐
					else
					{
						for (var j:int = 0; j < numChar; j++) // 注：j 表示列
						{
							char = listChar[j];
							if (char != " ")
							{
								charOffsetY = listCharOffsetY[j];
								pt.y += maxOffsetY_top - charOffsetY; // 偏移，对齐注册点
								
								// 渲染
								this.m_font.pastePixels(bg, pt, char);
							}
							
							// 下一个字符的位置
							charWidth = listCharWidth[j];
							pt.x += charWidth + this.m_textFormat.letterSpacing;
							pt.y = startY;
						}
					}
					
					pt.x = startX;
					startY += maxHeight + this.m_textFormat.leading; // 下一行的起始 y 位置
					pt.y = startY;
				}
				
				this.bitmapData = bg;
			}
		}
		
	}
}