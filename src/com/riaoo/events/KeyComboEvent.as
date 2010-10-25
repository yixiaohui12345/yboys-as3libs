package com.riaoo.events
{
	import com.riaoo.ui.KeyCombo;
	
	import flash.events.Event;
	
	public class KeyComboEvent extends Event
	{
		/**
		 * 当组合键全部被按下时调度 down 事件。
		 */		
		public static const DOWN:String = "down";
		
		/**
		 * 当组合键被释放时调度 release 事件。
		 */		
		public static const RELEASE:String = "release";
		
		/**
		 * 当组合键按顺序被按下时调度 sequence 事件。
		 */		
		public static const SEQUENCE:String = "sequence";
		
		
		
		/**
		 * 组合键。
		 */		
		public var keyCombo:KeyCombo;
		
		/**
		 * 构造函数。
		 * @param type
		 */		
		public function KeyComboEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			var e:KeyComboEvent = new KeyComboEvent(this.type);
			e.keyCombo = this.keyCombo;
			return e;
		}
		
	}
}