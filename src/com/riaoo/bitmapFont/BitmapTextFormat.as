package com.riaoo.bitmapFont
{
	/**
	 * 描述位图文本的一些信息，用于描述位图文本样式。
	 * @author yboyjiang
	 * @see BitmapTextField
	 */	
	public class BitmapTextFormat
	{
		/**
		 * 对齐方式。
		 * @see BitmapTextFormatAlign
		 */		
		public var align:String;
		
		/**
		 * 背景颜色。ARGB 颜色值。
		 */		
		public var backgroundColor:uint;
		
		/**
		 * 字符间的距离。该值指定在每个字符之后添加到进距的像素数。默认值是 0 。
		 */		
		public var letterSpacing:int;
		
		/**
		 * 行距。默认值是 0 。
		 */		
		public var leading:int;
		
		/**
		 * 采用了 css 里的 padding 概念。此属性是指左边的内边距大小。
		 */		
		public var paddingLeft:int;
		
		/**
		 * 采用了 css 里的 padding 概念。此属性是指右边的内边距大小。
		 */		
		public var paddingRight:int;
		
		/**
		 * 采用了 css 里的 padding 概念。此属性是指顶部的内边距大小。
		 */		
		public var paddingTop:int;
		
		/**
		 * 构造函数。
		 * @param backgroundColor
		 * @param letterSpacing
		 * @param leading
		 * @param paddingLeft
		 * @param paddingRight
		 * @param paddingTop
		 * @param paddingBottom
		 * @param align
		 */		
		public function BitmapTextFormat(backgroundColor:uint=0, letterSpacing:int=0, leading:int=0,
									paddingLeft:int=0, paddingRight:int=0, paddingTop:int=0,
									align:String="left")
		{
			this.backgroundColor = backgroundColor;
			this.letterSpacing = letterSpacing;
			this.leading = leading;
			this.paddingLeft = paddingLeft;
			this.paddingRight = paddingRight;
			this.paddingTop = paddingTop;
			this.align = align;
		}
		
		/**
		 * 创建一份副本。
		 * @return
		 */		
		public function clone():BitmapTextFormat
		{
			var clone:BitmapTextFormat = new BitmapTextFormat(this.backgroundColor, this.letterSpacing, this.leading,
										this.paddingLeft, this.paddingRight, this.paddingTop, this.align);
			return clone;
		}
		
		/**
		 * 从 source 处复制所有属性到当前实例。
		 * @param source 源。
		 */		
		public function copy(source:BitmapTextFormat):void
		{
			this.backgroundColor = source.backgroundColor;
			this.letterSpacing = source.letterSpacing;
			this.leading = source.leading;
			this.paddingLeft = source.paddingLeft;
			this.paddingRight = source.paddingRight;
			this.paddingTop = source.paddingTop;
			this.align = source.align;
		}
		
	}
}