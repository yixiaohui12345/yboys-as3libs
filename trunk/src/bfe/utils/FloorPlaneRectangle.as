package bfe.utils
{
	import flash.geom.Rectangle;
	
	public class FloorPlaneRectangle extends Rectangle
	{
		public var data:Object;
		
		public function FloorPlaneRectangle(x:Number=0, y:Number=0, width:Number=0, height:Number=0, data:Object=null)
		{
			super(x, y, width, height);
			this.data = data;
		}
		
		override public function clone():Rectangle
		{
			return new FloorPlaneRectangle(this.x, this.y, this.width, this.height, this.data);
		}
		
	}
}