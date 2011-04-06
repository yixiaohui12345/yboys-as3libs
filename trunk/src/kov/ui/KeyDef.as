package kov.ui
{
	/**
	 * 键定义。定义一个键，有两个属性：键控代码值 和 键的状态 。
	 * @author Y.Boy
	 */	
	public class KeyDef
	{
		/**
		 * 指示键是释放状态。
		 */		
		public static const UP:int = 0;
		
		/**
		 * 指示键是按住状态。
		 */		
		public static const DOWN:int = 1;
		
		/**
		 * 指示键是按住或释放状态。
		 */		
		public static const WHATEVER:int = 2;
		
		
		
		private var _keyCode:uint;
		private var _status:int;
		
		/**
		 * 键控代码值。
		 */		
		public function get keyCode():uint
		{
			return _keyCode;
		}
		
		/**
		 * 键的状态。分别为：KeyDef.DOWN、KeyDef.UP 或 KeyDef.WHATEVER 。
		 */		
		public function get status():int
		{
			return _status;
		}
		
		
		
		/**
		 * 构造函数。
		 * @param keyCode 键控代码值。
		 * @param status 键的状态。分别为：KeyDef.DOWN、KeyDef.UP 或 KeyDef.WHATEVER 。
		 */		
		public function KeyDef(keyCode:uint, status:int = 2)
		{
			_keyCode = keyCode;
			_status = status;
		}
		
		private static var keyDefList:Vector.<KeyDef>; // 对象池，服务于 KeyDef.create() 方法。
		
		/**
		 * 创建一个 KeyDef 实例。此静态方法对实例的创建进行管理及优化，类似于“对象池”概念，以减少创建实例的数目。
		 * @param keyCode 键控代码值。
		 * @param status 键的状态。分别为：KeyDef.DOWN、KeyDef.UP 或 KeyDef.WHATEVER 。
		 * @return 一个 KeyDef 实例。
		 */		
		public static function create(keyCode:uint, status:int = 2):KeyDef
		{
			if (!KeyDef.keyDefList)
			{
				KeyDef.keyDefList = new Vector.<KeyDef>();
			}
			
			for each (var k:KeyDef in KeyDef.keyDefList)
			{
				if (k.keyCode == keyCode && k.status == status) // 已存在键定义
				{
					return k;
				}
			}
			
			// 创建新的键定义
			var keyDef:KeyDef = new KeyDef(keyCode, status);
			KeyDef.keyDefList.push(keyDef);
			return keyDef;
		}
		
		/**
		 * 判断两个 keyDef 对象是否相等。
		 * @param toCompare 要比较的 keyDef 对象。
		 * @return 如果相等，返回 true ；否则返回 false 。
		 */		
		public function equals(toCompare:KeyDef):Boolean
		{
			if (_keyCode == toCompare.keyCode && _status == toCompare.status)
			{
				return true;
			}
			
			return false;
		}
		
		/**
		 * 给定键控代码值和键的状态，检测此键是否生效。
		 * @param keyCode 键控代码值。
		 * @param isDown 是否按住。
		 * @return 生效则返回 true ；否则返回 false 。
		 */		
		internal function check(keyCode:uint, isDown:Boolean):Boolean
		{
			if (keyCode != _keyCode)
			{
				return false;
			}
			else if (_status != KeyDef.WHATEVER && _status != int(isDown))
			{
				return false;
			}
			
			return true;
		}
		
		public function toString():String
		{
			return '[KeyDef keyCode="' + this.keyCode + '" status="' + this.status + '"]';
		}
		
	}
}