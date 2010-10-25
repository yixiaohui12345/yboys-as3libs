package com.zhuaq.games.wellgame
{
	import flash.events.EventDispatcher;

	/**
	 * 游戏胜利。
	 */	
	[Event(type="wellgame.WellGameEvent", name="win")]
	
	/**
	 * 游戏和局。
	 */	
	[Event(type="wellgame.WellGameEvent", name="drawnGame")]
	
	/**
	 * 游戏走了一步棋。
	 */	
	[Event(type="wellgame.WellGameEvent", name="go")]
	
	/**
	 * “井字过三关”游戏类。
	 * @author Y.Boy
	 * 
	 */	
	public class WellGame extends EventDispatcher
	{
		//------------------------------
		// 静态常量
		//------------------------------
		/* 棋盘位置 */
		public static const TOP_LEFT:int     = 0;
		public static const TOP:int          = 1;
		public static const TOP_RIGHT:int    = 2;
		public static const LEFT:int         = 3;
		public static const CENTER:int       = 4;
		public static const RIGHT:int        = 5;
		public static const BOTTOM_LEFT:int  = 6;
		public static const BOTTOM:int       = 7;
		public static const BOTTOM_RIGHT:int = 8;
		
		/* 玩家 */
		public static const PLAYER_1:int     = 1;
		public static const PLAYER_2:int     = 2;
		
		/* 难度 */
		public static const EASY:int         = 1;
		public static const HARD:int         = 2;
		
		//------------------------------
		// 变量
		//------------------------------
		private var _chessboard:Vector.<int>; // 棋盘数据
		
		/**
		 * 棋盘数据。
		 */		
		public function get chessboard():Vector.<int>
		{
			return _chessboard.concat();
		}
		
		/**
		 * 构造函数。
		 * 
		 */		
		public function WellGame()
		{
			init();
		}
		
		// 初始化。
		private function init():void
		{
			_chessboard = new Vector.<int>(9, true);
		}
		
		// 判断参数指定的路径是否胜利了。胜利的条件：三个位置的棋子都相同。
		private function isWin(p1:int, p2:int, p3:int):Boolean
		{
			var value1:int = _chessboard[p1];
			var value2:int = _chessboard[p2];
			var value3:int = _chessboard[p3];
			
			if (value1 && value2 && value3)
			{
				return (value1 == value2
					&& value1 == value3
					&& value2 == value3);
			}
			
			return false;
		}
		
		// 判断参数指定的路径是否将要胜利了。将要胜利的条件：其中两个位置的棋子相同，第三个为空。
		// 结果：
		// 0 - 都没有胜利；
		// 1 - 玩家1将要胜利的路径；
		// 2 - 玩家2将要胜利的路径；
		private function isWillWin(p1:int, p2:int, p3:int):int
		{
			var value1:int = _chessboard[p1];
			var value2:int = _chessboard[p2];
			var value3:int = _chessboard[p3];
			
			if (value1 + value2 + value3 == 0)
			{
				return 0;
			}
			
			if (value1 == value2 && value3 == 0)
			{
				return value1;
			}
			
			if (value1 == value3 && value2 == 0)
			{
				return value1;
			}
			
			if (value3 == value2 && value1 == 0)
			{
				return value2;
			}
			
			return 0;
		}
		
		// 判断棋盘是否满了。
		private function isFull():Boolean
		{
			for each (var i:int in _chessboard)
			{
				if (!i)
				{
					return false;
				}
			}
			
			return true;
		}
		
		// 获取胜利的路径。例如：第一行的路径为 "012" 。如果暂无胜利的路径，则返回空字符串。
		private function getWinPath():String
		{
			var result:String;
			switch (true)
			{
				case isWin(0, 1, 2):
				{
					result = "012";
					break;
				}
				case isWin(3, 4, 5):
				{
					result = "345";
					break;
				}
				case isWin(6, 7, 8):
				{
					result = "678";
					break;
				}
				case isWin(0, 3, 6):
				{
					result = "036";
					break;
				}
				case isWin(1, 4, 7):
				{
					result = "147";
					break;
				}
				case isWin(2, 5, 8):
				{
					result = "258";
					break;
				}
				case isWin(0, 4, 8):
				{
					result = "048";
					break;
				}
				case isWin(2, 4, 6):
				{
					result = "246";
					break;
				}
				default:
				{
					
				}
			}
			
			return result;
		}
		
		// 获取将要胜利的路径。结果是一个包含两个元素的数组，第一个是玩家1的，第二个是玩家2的。
		// 如果两个玩家都没有将要胜利的路径，则返回包含两个空字符串的数组。
		private function getWillWinPaths():Array
		{
			var result:Array = [];
			var player:int = 0;
			
			player = isWillWin(0, 1, 2);
			if(player)
			{
				player == WellGame.PLAYER_1 ? result[0] = "012": result[1] = "012";
			}
			
			player = isWillWin(3, 4, 5);
			if(player)
			{
				player == WellGame.PLAYER_1 ? result[0] = "345": result[1] = "345";
			}
			
			player = isWillWin(6, 7, 8);
			if(player)
			{
				player == WellGame.PLAYER_1 ? result[0] = "678": result[1] = "678";
			}
			
			player = isWillWin(0, 3, 6);
			if(player)
			{
				player == WellGame.PLAYER_1 ? result[0] = "036": result[1] = "036";
			}
			
			player = isWillWin(1, 4, 7);
			if(player)
			{
				player == WellGame.PLAYER_1 ? result[0] = "147": result[1] = "147";
			}
			
			player = isWillWin(2, 5, 8);
			if(player)
			{
				player == WellGame.PLAYER_1 ? result[0] = "258": result[1] = "258";
			}
			
			player = isWillWin(0, 4, 8);
			if(player)
			{
				player == WellGame.PLAYER_1 ? result[0] = "048": result[1] = "048";
			}
			
			player = isWillWin(2, 4, 6);
			if(player)
			{
				player == WellGame.PLAYER_1 ? result[0] = "246": result[1] = "246";
			}
			
			return result;
		}
		
		// 从将要胜利的路径（如："012"）中找出还没有下棋子的位置。
		private function getEmptyPositionFromWillWinPath(willWinPath:String):int
		{
			var position:int;
			for (var i:int = 0 ; i < 3; i++)
			{
				position = int(willWinPath.charAt(i));
				if (_chessboard[position] == 0)
				{
					break;
				}
			}
			
			return position;
		}
		
		/**
		 * 行下一步棋。
		 * @param player 指定本步棋是玩家1还是玩家2。由常量 Well.PLAYER_1 和 Well.PLAYER_2 指示。
		 * @param position 本步棋的位置。由 Well 的常量 TOP_LEFT...等等 指示。
		 * @return 如果执行成功，返回 true ；否则返回 false 。返回 false 则表示：要么该位置已下棋，要么游戏结束了（胜利或失败）。
		 * 
		 */		
		public function go(player:int, position:int):Boolean
		{
			if (isGo(position))
			{
				return false;
			}
			
			_chessboard[position] = player;
			
			var e:WellGameEvent;
			
			e = new WellGameEvent(WellGameEvent.GO);
			e.player = player;
			e.position = position;
			dispatchEvent(e);
			
			var winPath:String = getWinPath();
			if (winPath) // 有胜利路径
			{
				e = new WellGameEvent(WellGameEvent.WIN);
				e.player = player;
				e.path = winPath;
				dispatchEvent(e);
				return false;
			}
			else if (isFull()) // 棋盘满了，和局
			{
				e = new WellGameEvent(WellGameEvent.DRAWN_GAME);
				dispatchEvent(e);
				return false;
			}
			
			return true;
		}
		
		/**
		 * 判断棋盘上指定位置是否已经行过。
		 * @param position 棋盘上的位置。
		 * @return 如果该位置已经行过，则返回 true ，否则返回 false 。
		 * 
		 */		
		public function isGo(position:int):Boolean
		{
			return Boolean(_chessboard[position]);
		}
		
		/**
		 * 重新开始游戏。调用此方法会清除棋盘上的数据。
		 * 
		 */		
		public function replay():void
		{
			for (var i:String in _chessboard)
			{
				_chessboard[i] = 0;
			}
		}
		
		/**
		 * 让程序自动走下一步棋。
		 * @param player 指定本步棋是玩家1还是玩家2。由常量 Well.PLAYER_1 和 Well.PLAYER_2 指示。
		 * @param level 难度级别。由 WellGame.EASY 或 WellGame.HARD 指示。
		 * 
		 */		
		public function autoGo(player:int, level:int = 1):void
		{
			var position:int = getWillWinPosition(player);
			
			if (position > -1)
			{
				go(player, position);
				return;
			}
			
			if (WellGame.EASY == level)
			{
				autoGoEasy(player);
			}
			else
			{
				autoGoHard(player);
			}
		}
		
		// 按难度 WellGame.EASY 让程序自动走下一步棋。
		private function autoGoEasy(player:int):void
		{
			var position:int
			
			while (true)
			{
				position = Math.random() * 9;
				if ( go(player, position) )
				{
					return;
				}
			}
		}
		
		// 按难度 WellGame.HARD 让程序自动走下一步棋。
		private function autoGoHard(player:int):void
		{
			var position:int   = 0; // 权值最大的位置
			var power:int      = 0; // 权值 = 有效的路径数目。power 值越大越好
			var power_temp:int = 0; // 计算时的临时值
			var value:int      = 0; // 当前位置的值
			
			/* 0 */
			value = _chessboard[0];
			if (value == 0)
			{
				power_temp = isValid(player, 1, 2) + isValid(player, 3, 6) + isValid(player, 4, 8);
				if (power < power_temp)
				{
					power = power_temp;
					position = 0;
				}
			}
			
			/* 1 */
			value = _chessboard[1];
			if (value == 0)
			{
				power_temp = isValid(player, 0, 2) + isValid(player, 4, 7);
				if (power < power_temp)
				{
					power = power_temp;
					position = 1;
				}
				else if (power == power_temp && Math.random() > 0.45) // 有一定概率换个同权的位置
				{
					position = 1;
				}
			}
			
			/* 2 */
			value = _chessboard[2];
			if (value == 0)
			{
				power_temp = isValid(player, 0, 1) + isValid(player, 4, 6) + isValid(player, 5, 8);
				if (power < power_temp)
				{
					power = power_temp;
					position = 2;
				}
				else if (power == power_temp && Math.random() > 0.45)
				{
					position = 2;
				}
			}
			
			/* 3 */
			value = _chessboard[3];
			if (value == 0)
			{
				power_temp = isValid(player, 0, 6) + isValid(player, 4, 5);
				if (power < power_temp)
				{
					power = power_temp;
					position = 3;
				}
				else if (power == power_temp && Math.random() > 0.45)
				{
					position = 3;
				}
			}
			
			/* 4 */
			value = _chessboard[4];
			if (value == 0)
			{
				power_temp = isValid(player, 1, 7) + isValid(player, 3, 5) + isValid(player, 0, 8) + isValid(player, 2, 6);
				if (power < power_temp)
				{
					power = power_temp;
					position = 4;
				}
				else if (power == power_temp && Math.random() > 0.45)
				{
					position = 4;
				}
			}
			
			/* 5 */
			value = _chessboard[5];
			if (value == 0)
			{
				power_temp = isValid(player, 3, 4) + isValid(player, 2, 8);
				if (power < power_temp)
				{
					power = power_temp;
					position = 5;
				}
				else if (power == power_temp && Math.random() > 0.45)
				{
					position = 5;
				}
			}
			
			/* 6 */
			value = _chessboard[6];
			if (value == 0)
			{
				power_temp = isValid(player, 0, 3) + isValid(player, 7, 8);
				if (power < power_temp)
				{
					power = power_temp;
					position = 6;
				}
				else if (power == power_temp && Math.random() > 0.45)
				{
					position = 6;
				}
			}
			
			/* 7 */
			value = _chessboard[7];
			if (value == 0)
			{
				power_temp = isValid(player, 1, 4) + isValid(player, 6, 8);
				if (power < power_temp)
				{
					power = power_temp;
					position = 7;
				}
				else if (power == power_temp && Math.random() > 0.45)
				{
					position = 7;
				}
			}
			
			/* 8 */
			value = _chessboard[8];
			if (value == 0)
			{
				power_temp = isValid(player, 2, 5) + isValid(player, 6, 7) + isValid(player, 0, 4);
				if (power < power_temp)
				{
					power = power_temp;
					position = 8;
				}
				else if (power == power_temp && Math.random() > 0.45)
				{
					position = 8;
				}
			}
			
			go(player, position);
		}
		
		// 判断该路径是否有效。当该路径上存在对手的棋子即为无效路径。
		// 返回 1 表示有效，0 表示无效。
		private function isValid(player:int, p1:int, p2:int):int
		{
			var result:int = 1;
			var value1:int = _chessboard[p1];
			var value2:int = _chessboard[p2];
			var otherPlayer:int = (player == WellGame.PLAYER_1) ? WellGame.PLAYER_2 : WellGame.PLAYER_1;
			if (otherPlayer == value1 || otherPlayer == value2 )
			{
				result = 0;
			}
			
			return result;
		}
		
		// 获取将要胜利的路径的空缺位置。此方法会优先返回参数 player 指定的玩家的棋子位置。
		// 如果没有将要胜利的路径，则返回 -1 。
		private function getWillWinPosition(player:int):int
		{
			var position:int = -1;
			var willWinPaths:Array = getWillWinPaths();
			var currentPlayerPath:String = willWinPaths.splice(player - 1, 1);
			var otherPlayerPath:String = willWinPaths[0];
			if (currentPlayerPath) // 当前玩家将要胜利
			{
				position = getEmptyPositionFromWillWinPath(currentPlayerPath);
			}
			else if (otherPlayerPath) // 对手将要胜利
			{
				position = getEmptyPositionFromWillWinPath(otherPlayerPath);
			}
			
			return position;
		}
		
		/**
		 * 返回棋盘形状的字符串。
		 * @return 
		 * 
		 */		
		override public function toString():String
		{
			var result:String = "";
			result += " " + _chessboard[0] + " | " + _chessboard[1] + " | " + _chessboard[2] + "\n";
			result += "---|---|---\n";
			result += " " + _chessboard[3] + " | " + _chessboard[4] + " | " + _chessboard[5] + "\n";
			result += "---|---|---\n";
			result += " " + _chessboard[6] + " | " + _chessboard[7] + " | " + _chessboard[8] + "\n";
			return result;
		}
		
	}
}