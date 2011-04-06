package kov.ui
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	
	import kov.events.KeyEvent;
	
	[Event(type="kov.events.KeyEvent", name="work")]
	
	/**
	 * 用于处理组合键的类。
	 * @author Y.Boy
	 */	
	public class Key extends EventDispatcher
	{
		private static var currentKeyComboID:uint = 0; // 每添加一个 keyCombo 时，给 keyCombo.id 赋值用的
		
		private var stage:Stage;
		private var idle:int;
		private var keyComboList:Vector.<KeyCombo>; // 组合键列表，按组合键长度进行排序，升序
		
		private var keyDownHash:Object; // 按住的键
		private var keyTypedList:Vector.<uint>; // idle 时间内已输入的键
		
		private var prevGetTimer:int; // 上次按键时间
		private var maxKeyComboLength:uint; // 最长的组合键长度
		
		/**
		 * 构造函数。
		 * @param stage 舞台，用于监听键盘事件。
		 * @param idle 连续按键之间所需的相隔时间（单位：毫秒，默认为 200 毫秒）。用户必须在此时间间隔内连续按键才产生“连招”。
		 * <br />可以传递一个足够大的值来表示无时间限制，例如：Number.MAX_VALUE 。
		 */		
		public function Key(stage:Stage, idle:int = 200)
		{
			this.keyComboList = new Vector.<KeyCombo>();
			this.keyDownHash = {};
			this.keyTypedList = new Vector.<uint>();
			
			this.idle = idle;
			this.stage = stage;
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.stage.addEventListener(Event.DEACTIVATE, onDeactivate);
		}
		
		/**
		 * 组合键的数目。
		 */		
		public function get length():uint
		{
			return this.keyComboList.length;
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var keyCode:uint = event.keyCode;
			var alreadyDown:Boolean = this.keyDownHash[keyCode];
			if (alreadyDown) // 防止按住键不放时的连续事件
			{
				return;
			}
			
			var now:int = getTimer();
			if (now - this.prevGetTimer > this.idle) // 两次按键时间超出 idle 值
			{
				this.keyTypedList.length = 0;
			}
			else if (this.keyTypedList.length == this.maxKeyComboLength) // 已输入键数目将超出最大的组合键长度
			{
				this.keyTypedList.shift();
			}
			
			this.prevGetTimer = now;
			this.keyDownHash[keyCode] = true;
			this.keyTypedList.push(keyCode);
			
			// 检测每一个组合键
			var i:int = this.keyComboList.length;
			while (i--)
			{
				var keyCombo:KeyCombo = this.keyComboList[i];
				if (keyCombo.check(this.keyTypedList, this.keyDownHash)) // 对应的组合键生效了
				{
					var e:KeyEvent = new KeyEvent(KeyEvent.WORK);
					e.keyComboID = keyCombo.id;
					dispatchEvent(e);
					return;
				}
			}
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			delete this.keyDownHash[event.keyCode];
		}
		
		private function onDeactivate(event:Event):void
		{
			this.keyDownHash = {};
			this.keyTypedList.length = 0;
		}
		
		/**
		 * 添加组合键。
		 * @param keyCombo
		 * @return keyCombo 的唯一 ID 。
		 */		
		public function addKeyCombo(newKeyCombo:KeyCombo):uint
		{
			// 按 keyCombo.length 进行排序，升序
			var toCompare:uint = newKeyCombo.length;
			var l:int = this.keyComboList.length;
			var i:int = 0; // 待添加到 keyComboList 的索引
			var oldKeyCombo:KeyCombo;
			while (l--)
			{
				oldKeyCombo = this.keyComboList[l];
				if (newKeyCombo.equals(oldKeyCombo)) // 注：一定要遍历所有项
				{
					return oldKeyCombo._id;
				}
				else if (i == 0 && toCompare >= oldKeyCombo.length) // 找到该放的位置
				{
					i = l + 1;
				}
			}
			this.keyComboList.splice(i, 0, newKeyCombo);
			this.maxKeyComboLength = this.keyComboList[this.keyComboList.length-1].length;
			newKeyCombo._id = Key.currentKeyComboID++; // 赋值 id ，并递增，等待下一次赋值
			return newKeyCombo._id;
		}
		
		/**
		 * 检查指定键是否按下。
		 * @param keyCode 键控代码值。
		 * @return 如果指定键已经按下，则返回 true ；否则返回 false 。
		 */		
		public function isDown(keyCode:uint):Boolean
		{
			return this.keyDownHash[keyCode];
		}
		
		override public function toString():String
		{
			return '[Key length="' + this.length + '"]';
		}
		
	}
}