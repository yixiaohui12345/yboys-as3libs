package kov.ui
{
	/**
	 * 组合键。
	 * @author Y.Boy
	 */	
	public class KeyCombo
	{
		internal var _id:uint; // 给 Key 类修改的
		
		private var _isOrderly:Boolean;
		private var _keyDefList:Vector.<KeyDef>;
		
		/**
		 * 构造函数。
		 * @param keyDefList 组合键的键定义。
		 * @param isOrderly 指示组合键是否有按键的先后顺序。
		 * 
		 * @see KeyDef
		 * @see Key
		 */		
		public function KeyCombo(keyDefList:Vector.<KeyDef>, isOrderly:Boolean = true)
		{
			_isOrderly = isOrderly;
			_keyDefList = keyDefList;
			_keyDefList.fixed = true;
		}
		
		/**
		 * 组合键的长度。
		 */		
		public function get length():uint
		{
			return _keyDefList.length;
		}
		
		/**
		 * 唯一 ID 。此值会自动被 Key 对象赋值。
		 */		
		public function get id():uint
		{
			return _id;
		}
		
		/**
		 * 组合键的键定义的副本。
		 */		
		public function get keyDefList():Vector.<KeyDef>
		{
			return _keyDefList.concat();
		}
		
		/**
		 * 指示组合键是否有按键的先后顺序。
		 */		
		public function get isOrderly():Boolean
		{
			return _isOrderly;
		}
		
		/**
		 * 判断两个 KeyCombo 对象是否相等。
		 * @param toCompare 要比较的 KeyCombo 对象。
		 * @return 如果相等，返回 true ；否则返回 false 。
		 */		
		public function equals(toCompare:KeyCombo):Boolean
		{
			var l:int = _keyDefList.length;
			if (l != toCompare.length)
			{
				return false;
			}
			
			var toCompareKeyDefList:Vector.<KeyDef> = toCompare.keyDefList;
			while (l--)
			{
				if (!_keyDefList[l].equals(toCompareKeyDefList[l]))
				{
					return false;
				}
			}
			
			return true;
		}
		
		/**
		 * 给定已输入键数据和按住键数据，检测此组合键是否生效。
		 * @param keyTypedList 已输入键数据
		 * @param keyDownHash 按住键数据
		 * @return 组合键生效，返回 true ；否则返回 false 。
		 */		
		internal function check(keyTypedList:Vector.<uint>, keyDownHash:Object):Boolean
		{
			var i:int = _keyDefList.length;
			var j:uint = keyTypedList.length;
			if (i > j)
			{
				return false;
			}
			else if (i < j)
			{
				keyTypedList = keyTypedList.slice(-i);
			}
			
			var keyTypedHash:Object; // 当 isOrderly == false 时使用
			if (!_isOrderly) // 无序的组合键
			{
				keyTypedHash = {};
				for each (var keyCode:uint in keyTypedList)
				{
					keyTypedHash[keyCode] = true;
				}
			}
			
			var keyDef:KeyDef;
			var isDown:Boolean;
			while (i--)
			{
				keyDef = _keyDefList[i];
				isDown = keyDownHash[keyDef.keyCode];
				if ( _isOrderly && !keyDef.check(keyTypedList[i], isDown) )
				{
					// 有序组合键
					return false;
				}
				else if ( !_isOrderly && !(keyTypedHash[keyDef.keyCode] && keyDef.check(keyDef.keyCode, isDown)) )
				{
					// 无序组合键
					return false;
				}
			}
			
			return true;
		}
		
	}
}