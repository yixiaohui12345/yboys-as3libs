package kov.events
{
	import flash.events.Event;
	
	/**
	 * 用于组合键的键盘事件。
	 * @author Y.Boy
	 */	
	public class KeyEvent extends Event
	{
		/**
		 * 当某一组合键被激活时调度 activate 事件。
		 */		
		public static const WORK:String = "work";
		
		/**
		 * keyCombo 的唯一 ID 。
		 * @see kov.ui.KeyCombo
		 */		
		public var keyComboID:uint;
		
		/**
		 * 构造函数。
		 * @param type
		 */		
		public function KeyEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			var e:KeyEvent = new KeyEvent(this.type);
			e.keyComboID = this.keyComboID;
			return e;
		}
		
	}
}