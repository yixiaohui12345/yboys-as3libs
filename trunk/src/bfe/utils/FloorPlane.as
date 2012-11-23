package bfe.utils
{
	import flash.geom.Rectangle;
	
	public class FloorPlane
	{
		private var rectArray:Vector.<FloorPlaneRectangle>;
		
		public function dealRectangleArgsArray(rectList:Vector.<FloorPlaneRectangle>, maxWidth:int, gap:int=1):Vector.<FloorPlaneRectangle>
		{
			var rectArraySort:Array = [];
			rectArraySort.length = rectList.length;
			
			for (var i:int = 0; i < rectList.length; i++)
			{
				rectArraySort[i] = rectList[i].clone();
			}
			
			rectArraySort.sortOn(["height" , "width"] , Array.NUMERIC | Array.DESCENDING);
			rectArray = Vector.<FloorPlaneRectangle>(rectArraySort);
			rectArraySort = null;
			
			if (gap)
			{
				for each (var rect:Rectangle in rectArray)
				{
					rect.width += gap;
					rect.height += gap;
				}
			}
			
			floorplane(maxWidth);
			
			if (gap)
			{
				for each (rect in rectArray)
				{
					rect.width -= gap;
					rect.height -= gap;
				}
			}
			return rectArray;
		}
		
		private function countMaxH(heightArray:Vector.<int>, width:int , i:int):int
		{
			var len:int = i + width;
			var maxH:int = heightArray[i];
			i++;
			
			for (; i < len; i++)
			{
				if (maxH < heightArray[i])
				{
					maxH = heightArray[i];
				}
			}
			return maxH;
		}
		
		private function findMinHRight(heightArray:Vector.<int>, width:int):PostionXH
		{
			var len : int = heightArray.length - width;
			var pxh : PostionXH = new PostionXH();
			pxh.startHeight = 99999999;
			
			for (var i:int = len-1; i >=0; i--)
			{
				var h:int = countMaxH(heightArray, width, i);
				
				if (h < pxh.startHeight)
				{
					pxh.startX = i;
					pxh.startHeight = h;
				}
			}
			return pxh;
		}
		
		private function findMinHLeft(heightArray:Vector.<int>, width:int):PostionXH
		{
			var len:int = heightArray.length - width;
			var pxh:PostionXH = new PostionXH();
			pxh.startHeight = 99999999;
			
			for (var i:int = 0; i < len; i++)
			{
				var h:int = countMaxH(heightArray, width, i);
				if (h < pxh.startHeight)
				{
					pxh.startX = i;
					pxh.startHeight = h;
				}
			}
			return pxh;
		}
		
		private var heightArray:Vector.<int>;// = new Vector.<int>();
		private var startX:int
		private var isLeftAglin:Boolean ;
		private var widthLineSum:int;
		private var modeSwitch:int ;
		
		private function floorplane(maxWidth:int, start:int = 0, end:int = -1):void
		{
			
			var total:int = rectArray.length;
			var mode1:int = 1;
			
			if (end == -1)
				end = total;
			
			if (start == 0)
			{	
				heightArray = new Vector.<int>();
				heightArray.length = maxWidth;
				startX = 0;
				isLeftAglin = true;
				widthLineSum = 0;
				modeSwitch = Math.log(maxWidth) /  Math.log(2);
			}
			
			for (var bi:int = start; bi < end;)
			{
				var rect:Rectangle = rectArray[bi];
				var h:int = rect.height;
				if (widthLineSum + rect.width > maxWidth)
				{
					var restSpace:int = maxWidth - widthLineSum;
					for (var bi2:int = bi + 1; bi2 < total; bi2++)
					{
						if (rectArray[bi2].width <= restSpace)
						{
							//trace(rectArray[bi] ,rect.width , restSpace );
							var rect2:Rectangle = rectArray[bi2];
							//trace("BBBBB"+rect2);
							rectArray.splice(bi2, 1);
							rectArray.splice(bi, 0, rect2);
							//trace("AAAA"+rectArray[bi] , restSpace );
							break;
						}
					}
					
					if (rect != rectArray[bi])
						continue;
					else
					{
						isLeftAglin = !isLeftAglin;
						widthLineSum = 0;
						startX = isLeftAglin ? 0 : maxWidth;
						continue;
					}
				}
				else
				{
					bi++ ;
					widthLineSum += rect.width;
					var pxh:PostionXH ;
					
					if (total - bi <  modeSwitch)
						mode1 = 0;
					
					if (mode1)
					{
						if (!pxh)
						{
							pxh = new PostionXH();
						}
						
						if (isLeftAglin)
						{
							pxh.startHeight = countMaxH(heightArray, rect.width, startX);
							pxh.startX = startX;
							startX += rect.width;
						}
						else
						{
							pxh.startHeight = countMaxH(heightArray, rect.width, startX - rect.width);
							pxh.startX = startX - rect.width;
							startX -= rect.width;
						}
					}
					else
					{
						if (isLeftAglin)
						{
							pxh = findMinHLeft(heightArray, rect.width);
						}
						else
						{
							pxh = findMinHRight(heightArray, rect.width);
						}
					}
					
					rect.x = pxh.startX;
					rect.y = pxh.startHeight;
					var xMax:int = pxh.startX + rect.width;
					var hMax:int = pxh.startHeight + rect.height;
					
					for (var i:int = pxh.startX; i < xMax; i++)
					{
						heightArray[i] = hMax;
					}
				}
				
			}
		}
		
	}
	
}

class PostionXH
{
	public var startX:int = -1;
	public var startHeight : int;
}