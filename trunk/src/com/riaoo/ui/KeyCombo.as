package com.riaoo.ui
{
	import com.riaoo.utils.ArrayUtil;
	
	/**
	 * 组合键。
	 * @author Y.Boy | riaoo.com
	 */	
	public class KeyCombo
	{
		private var _keyCodes:Vector.<uint>; // 组合键
		
		/**
		 * 构造函数。参数顺序表示了组合键的按键顺序。
		 * @param keyCode1 第一个键。
		 * @param keyCode2 第二个键。
		 * @param params 其余的键。
		 */		
		public function KeyCombo(keyCode1:uint, keyCode2:uint, ...params)
		{
			this._keyCodes = new Vector.<uint>();
			this._keyCodes.push(keyCode1, keyCode2);
			for each (var keyCode:uint in params)
			{
				this._keyCodes.push(keyCode);
			}
			this._keyCodes.fixed = true;
		}
		
		/**
		 * 组合键的代码值。
		 */		
		public function get keyCodes():Vector.<uint>
		{
			return this._keyCodes.concat();
		}
		
		/**
		 * 组合键长度。
		 */		
		public function get length():uint
		{
			return this._keyCodes.length;
		}
		
		/**
		 * 检查此组合键是否包含参数 keyCode 指定的键。
		 * @param keyCode 键的代码值。
		 * @return 如果包含参数指定的键，则返回 true ；否则返回 false 。
		 */		
		public function hasKey(keyCode:uint):Boolean
		{
			return this._keyCodes.indexOf(keyCode) > -1;
		}
		
		/**
		 * 比较两个组合键是否相等。
		 * @param keyCombo 要进行比较的 KeyCombo 实例。
		 * @return 相等则返回 true ，否则返回 false 。
		 */		
		public function equals(keyCombo:KeyCombo):Boolean
		{
			if (keyCombo == this)
			{
				return true;
			}
			
			return ArrayUtil.equals(keyCombo.keyCodes, this._keyCodes);
		}
		
		public function toString():String
		{
			return this._keyCodes.toString();
		}
		
	}
}