package com.riaoo.ui
{
	import com.riaoo.events.KeyComboEvent;
	import com.riaoo.utils.ArrayUtil;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	[Event(name="keyDown", type="flash.events.KeyboardEvent")]
	[Event(name="keyUp", type="flash.events.KeyboardEvent")]
	[Event(name="down", type="com.riaoo.events.KeyComboEvent")]
	[Event(name="release", type="com.riaoo.events.KeyComboEvent")]
	[Event(name="sequence", type="com.riaoo.events.KeyComboEvent")]
	
	/**
	 * Key 类用于实现组合键的功能。例如拳皇那类连招的按键方式。
	 * @author Y.Boy | riaoo.com
	 */	
	public class Key extends EventDispatcher
	{
		private var stage:Stage; // 舞台的引用
		private var idle:uint; // 连续按键之间所需的相隔时间
		
		private var keysDown:Dictionary; // 当前被按住的键
		private var keysTyped:Vector.<uint>; // 已经被按下的键
		private var combosDown:Vector.<KeyCombo>; // 已经被按下的组合键
		private var combos:Vector.<KeyCombo>; // 组合键
		private var maxComboLength:uint; // 最长的组合键长度
		private var getTime:uint; // 上一次的 getTimer() 值
		
		/**
		 * 是否支持按着键。即按住一个键时，是否连续调度 KEY_DOWN 事件。
		 */		
		public var supportDownKey:Boolean;
		
		/**
		 * 构造函数。
		 * @param stage Stage 对象。
		 * @param idle 连续按键之间所需的相隔时间（毫秒）。用户必须在此时间间隔内连续按键才产生“连招”。
		 * <br />当值为 0 时，表示连续按键间所需的时间要求为无限大（即无时间限制）。
		 * @param supportDownKey 是否支持按着键。即按住一个键时，是否连续调度 KEY_DOWN 事件。
		 */		
		public function Key(stage:Stage, idle:uint = 0, supportDownKey:Boolean = false)
		{
			this.supportDownKey = supportDownKey;
			this.idle = idle;
			this.stage = stage;
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.stage.addEventListener(Event.DEACTIVATE, onDeactivate);
			
			this.keysDown = new Dictionary(true);
			this.keysTyped = new Vector.<uint>();
			this.combosDown = new Vector.<KeyCombo>();
			this.combos = new Vector.<KeyCombo>();
			this.maxComboLength = 0;
		}
		
		/**
		 * 判断某键是否被按住。
		 * @param keyCode 键的代码值。
		 * @return 如果键被按住，返回 true ；否则返回 false 。
		 */		
		public function isDown(keyCode:uint):Boolean
		{
			return this.keysDown[keyCode];
		}
		
		/**
		 * 添加一个组合键。
		 * @param keyCombo 组合键。
		 */		
		public function addKeyCombo(keyCombo:KeyCombo):void
		{
			var l:uint = this.combos.length;
			while (l--)
			{
				if (this.combos[l].equals(keyCombo))
				{
					return;
				}
			}
			
			this.maxComboLength = Math.max(this.maxComboLength, keyCombo.length);
			this.combos.push(keyCombo);
		}
		
		/**
		 * 移除指定的组合键。
		 * @param keyCombo 组合键。
		 */		
		public function removeKeyCombo(keyCombo:KeyCombo):void
		{
			var i:int = -1;
			var l:uint = this.combos.length;
			while (l--)
			{
				if (this.combos[l].equals(keyCombo))
				{
					i = l; // 找到组合键所有索引
					break;
				}
			}
			
			if (i == -1) // 不存在此组合键
			{
				return;
			}
			
			this.combos.splice(i, 1);
			
			if (this.maxComboLength == keyCombo.length)
			{
				// 重新寻找最大长度
				this.maxComboLength = 0;
				l = this.combos.length;
				while (l--)
				{
					this.maxComboLength = Math.max(this.maxComboLength, this.combos[l].length);
				}
			}
		}
		
		/**
		 * 销毁。
		 */		
		public function destroy():void
		{
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.stage.removeEventListener(Event.DEACTIVATE, onDeactivate);
			this.stage = null;
			
			this.keysDown = null;
			
			this.keysTyped.length = 0;
			this.keysTyped = null;
			
			this.combosDown.length = 0;
			this.combosDown = null;
			
			this.combos.length = 0;
			this.combos = null;
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var keyCode:uint = event.keyCode;
			var alreadyDown:Boolean = this.keysDown[keyCode];
			if (alreadyDown && !this.supportDownKey)
			{
				return;
			}
			
			this.keysDown[keyCode] = true;
			var l:uint = this.combos.length;
			
			if (this.idle && getTimer() - this.getTime > this.idle) // 按键间隔时间超出 idle 值
			{
				this.keysTyped.length = 0;
				this.keysTyped.push(keyCode);
				
				// 检测组合键
				while (l--)
				{
					checkDownKeys(this.combos[l]);
				}
			}
			else
			{
				this.keysTyped.push(keyCode);
				
				// 已按下的键数是否超出最长组合键的长度
				if (!this.idle && this.keysTyped.length > this.maxComboLength)
				{
					this.keysTyped.shift();
				}
				
				// 检测组合键
				while (l--)
				{
					checkTypedKeys(this.combos[l]);
					checkDownKeys(this.combos[l]);
				}
			}
			
			this.getTime = getTimer();
			
			dispatchEvent(event);
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			var keyCode:uint = event.keyCode;
			
			// 删除已按住的键
			delete this.keysDown[keyCode];
			
			// 调度释放组合键事件
			var l:uint = this.combosDown.length;
			while (l--)
			{
				if (this.combosDown[l].hasKey(keyCode))
				{
					var e:KeyComboEvent = new KeyComboEvent(KeyComboEvent.RELEASE);
					e.keyCombo = this.combosDown.splice(l, 1)[0];
					dispatchEvent(e);
				}
			}
			
			dispatchEvent(event);
		}
		
		// 系统失去焦点。
		private function onDeactivate(event:Event):void
		{
			var l:uint = this.combosDown.length;
			while (l--)
			{
				var e:KeyComboEvent = new KeyComboEvent(KeyComboEvent.RELEASE);
				e.keyCombo = this.combosDown[l];
				dispatchEvent(e);
			}
			
			this.keysDown = new Dictionary(true);
			this.combosDown = new Vector.<KeyCombo>();
			this.keysTyped.length = 0;
		}
		
		// 检测当前已按住的键。
		private function checkTypedKeys(keyCombo:KeyCombo):void
		{
			var typedKey:Vector.<uint> = this.keysTyped.slice(-keyCombo.length);
			if (ArrayUtil.equals(keyCombo.keyCodes, typedKey))
			{
				var e:KeyComboEvent = new KeyComboEvent(KeyComboEvent.SEQUENCE);
				e.keyCombo = keyCombo;
				dispatchEvent(e);
			}
		}
		
		// 检测已按下的键（在 idle 时间限制内）。
		private function checkDownKeys(keyCombo:KeyCombo):void
		{
			var keyCodes:Vector.<uint> = keyCombo.keyCodes;
			var l:uint = keyCodes.length;
			while (l--)
			{
				if (!isDown(keyCodes[l]))
				{
					return;
				}
			}
			
			l = this.combosDown.length;
			var aleadyDown:Boolean = false;
			while (l--)
			{
				if (this.combosDown[l] === keyCombo) // 已经存在已按下的组合键
				{
					aleadyDown = true;
					break;
				}
			}
			if (!aleadyDown)
			{
				this.combosDown.push(keyCombo);
			}
			
			var e:KeyComboEvent = new KeyComboEvent(KeyComboEvent.DOWN);
			e.keyCombo = keyCombo;
			dispatchEvent(e);
		}
		
		
	}
}