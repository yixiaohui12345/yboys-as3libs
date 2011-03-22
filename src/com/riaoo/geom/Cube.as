package com.riaoo.geom
{
	import flash.geom.Vector3D;

	/**
	 * 三维空间。类似 flash.geom.Rectangle ，但此类是立体的。
	 * @author Y.Boy
	 */	
	public class Cube
	{
		/**
		 * 立方体原点的 x 坐标。
		 */		
		public var x:Number;
		
		/**
		 * 立方体原点的 y 坐标。
		 */		
		public var y:Number;
		
		/**
		 * 立方体原点的 z 坐标。
		 */		
		public var z:Number;
		
		/**
		 * width 立方体的宽度。
		 */		
		public var width:Number;
		
		/**
		 * height 立方体的高度。
		 */		
		public var height:Number;
		
		/**
		 * depth 立方体的深度。
		 */		
		public var depth:Number;
		
		/**
		 * 构造函数。
		 * @param x 立方体原点的 x 坐标。
		 * @param y 立方体原点的 y 坐标。
		 * @param z 立方体原点的 z 坐标。
		 * @param width 立方体的宽度。
		 * @param height 立方体的高度。
		 * @param depth 立方体的深度。
		 */		
		public function Cube(x:Number = 0, y:Number = 0, z:Number = 0, width:Number = 0, height:Number = 0, depth:Number = 0)
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.width = width;
			this.height = height;
			this.depth = depth;
		}
		
		/**
		 * 右边界。x 和 width 的和。
		 */		
		public function get right():Number
		{
			return this.x + this.width;
		}
		
		/**
		 * 下边界（底部）。y 和 height 的和。
		 */		
		public function get bottom():Number
		{
			return this.y + this.height;
		}
		
		/**
		 * 前。z 和 depth 的和。
		 */		
		public function get front():Number
		{
			return this.z + this.depth;
		}
		
		/**
		 * 确定此空间内是否包含指定点。
		 * @param x 点的 x 坐标。
		 * @param y 点的 y 坐标。
		 * @param z 点的 z 坐标。
		 * @return 如果包含指定点，则返回 true ；否则返回 false 。
		 */		
		public function contains(x:Number, y:Number, z:Number):Boolean
		{
			if (x < this.x || x > this.right)
			{
				return false;
			}
			
			if (y < this.y || y > this.bottom)
			{
				return false;
			}
			
			if (z < this.z || z > this.front)
			{
				return false;
			}
			
			return true;
		}
		
		/**
		 * 确定此空间内是否包含指定点。
		 * @param vector3D 要检查的点。
		 * @return 如果包含指定点，则返回 true ；否则返回 false 。
		 */		
		public function containsPoint(vector3D:Vector3D):Boolean
		{
			return contains(vector3D.x, vector3D.y, vector3D.z);
		}
		
		/**
		 * 确定此空间内是否包含参数 cube 指定的空间。
		 * @param cube 要检查的 cube 对象。
		 * @return 如果包含指定空间，则返回 true ；否则返回 false 。
		 */		
		public function containsCube(cube:Cube):Boolean
		{
			return ( contains(cube.x, cube.y, cube.z) && contains(cube.right, cube.bottom, cube.front) );
		}
		
		/**
		 * 确定此空间与参数指定的空间是否相等。
		 * @param toCompare 要检查的 Cube 对象。
		 * @return 如果两空间相等，则返回 trur ；否则返回 false 。
		 */		
		public function equals(toCompare:Cube):Boolean
		{
			return ( (this.x == toCompare.x) && (this.y == toCompare.y) && (this.z == toCompare.z)
				&& (this.width == toCompare.width) && (this.height == toCompare.height) && (this.depth == toCompare.depth) );
		}
		
		/**
		 * 确定此空间是否为空。
		 * @return 只要 width、height 和 depth 其中之一等于零，则返回 true ；否则返回 false 。
		 */		
		public function isEmpty():Boolean
		{
			return ( (this.width <= 0) || (this.height <= 0) || (this.depth <= 0) );
		}
		
		/**
		 * 将此对象所有属性设为零。
		 */		
		public function setEmpty():void
		{
			this.x = 0;
			this.y = 0;
			this.z = 0;
			this.width = 0;
			this.height = 0;
			this.depth = 0;
		}
		
		/**
		 * 确定此对象与参数指定的 cube 对象是否相交。包含也是相交的一种。
		 * @param toIntersect
		 * @return 如果两个 cube 对象相交，则返回 true ；否则返回 false 。
		 */		
		public function intersectsCube(toIntersect:Cube):Boolean
		{
			// 左右
			if (toIntersect.right < this.x || toIntersect.x > this.right)
			{
				return false;
			}
			
			// 上下
			if (toIntersect.bottom < this.y || toIntersect.y > this.bottom)
			{
				return false;
			}
			
			// 前后
			if (toIntersect.front < this.z || toIntersect.z > this.front)
			{
				return false;
			}
			
			return true;
		}
		
		/**
		 * 返回此对象的副本。
		 * @return 一个 Cube 对象。
		 */		
		public function clone():Cube
		{
			return new Cube(this.x, this.y, this.z, this.width, this.height, this.depth);
		}
		
		/**
		 * 生成描述此对象信息的字符串。形如：(x=1, y=2, z=3, w=4, h=5, d=6) 。
		 * @return 
		 */		
		public function toString():String
		{
			return "(x=" + this.x + ", y=" + this.y + ", z=" + this.z +
					", w=" + this.width + ", h=" + this.height + ", d=" + this.depth + ")";
		}
		
	}
}