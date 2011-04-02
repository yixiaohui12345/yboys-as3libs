package com.riaoo.display
{
	import com.riaoo.valueObject.Padding;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * 支持九切片缩放的 Bitmap 的子类。当设置 width、height、scaleX、scaleY 属性时，会自动进行九切片缩放，而非进行拉伸缩放。
	 * @author Y.Boy
	 */	
	public class BitmapScale9 extends Bitmap
	{
		protected var padding:Padding; // 原始 scale9Grid 的 padding 数据。
		
		public function BitmapScale9(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			this.padding = new Padding();
		}
		
		override public function set bitmapData(value:BitmapData):void
		{
			super.bitmapData = value;
			this.updatePadding();
		}
		
		override public function set scale9Grid(value:Rectangle):void
		{
			super.scale9Grid = value;
			this.updatePadding();
		}
		
		override public function set width(value:Number):void
		{
			this.setSize(value, this.height);
		}
		
		override public function set height(value:Number):void
		{
			this.setSize(this.width, value);
		}
		
		public function setSize(w:Number, h:Number):void
		{
			w = Math.max(w, this.padding.left + this.padding.right + 1); // 保证 scale9Grid 部分最小宽度为 1 像素
			h = Math.max(h, this.padding.top + this.padding.bottom + 1); // 同上
			this.scale9(w, h);
			this.updateScale9Grid();
		}
		
		/**
		 * 进行九切片缩放。
		 */		
		protected function scale9(newWidth:Number, newHeight:Number):void
		{
			var bmpData:BitmapData = new BitmapData(newWidth, newHeight, true, 0x00000000);
			
			var rows:Array = [0, this.scale9Grid.top, this.scale9Grid.bottom, this.bitmapData.height];
			var cols:Array = [0, this.scale9Grid.left, this.scale9Grid.right, this.bitmapData.width];
			var dRows:Array = [0, this.scale9Grid.top, newHeight - (this.bitmapData.height - this.scale9Grid.bottom), newHeight];
			var dCols:Array = [0, this.scale9Grid.left, newWidth - (this.bitmapData.width - this.scale9Grid.right), newWidth];
			
			var originRect:Rectangle;
			var drawRect:Rectangle;
			var m:Matrix = new Matrix();
			
			for (var cx:int = 0; cx < 3; cx++)
			{
				for (var cy:int = 0; cy < 3; cy++)
				{
					originRect = new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
					drawRect = new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
					m.identity();
					m.a = drawRect.width / originRect.width;
					m.d = drawRect.height / originRect.height;
					m.tx = drawRect.x - originRect.x * m.a;
					m.ty = drawRect.y - originRect.y * m.d;
					bmpData.draw(this.bitmapData, m, null, null, drawRect, this.smoothing);
				}
			}
			
			super.bitmapData.dispose();
			super.bitmapData = bmpData;
		}
		
		/**
		 * 把 scale9Grid 序列化为 padding。另一种替代方法是，保存原 bitmapData 数据。但保存 padding 信息更多省资源。
		 * @return 
		 */		
		private function updatePadding():void
		{
			this.padding.top = this.scale9Grid.y;
			this.padding.right = this.bitmapData.width - this.scale9Grid.right;
			this.padding.bottom = bitmapData.height - this.scale9Grid.bottom;
			this.padding.left = this.scale9Grid.x;
		}
		
		/**
		 * 把 padding 序列化为 scale9Grid。计算新的 scale9Grid 值。
		 * @return 
		 */		
		private function updateScale9Grid():void
		{
			var rect:Rectangle = new Rectangle();
			rect.x = this.padding.left;
			rect.y = this.padding.top;
			rect.width = this.bitmapData.width - this.padding.left - this.padding.right;
			rect.height = this.bitmapData.height - this.padding.top - this.padding.bottom;
			this.scale9Grid = rect;
		}
		
	}
}