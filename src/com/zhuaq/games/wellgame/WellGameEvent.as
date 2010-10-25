package com.zhuaq.games.wellgame
{
	import flash.events.Event;
	
	/**
	 * “井字过三关”事件类。
	 * @author Y.Boy
	 * 
	 */	
	public class WellGameEvent extends Event
	{
		public static const WIN:String        = "win";
		public static const DRAWN_GAME:String = "drawnGame";
		public static const GO:String         = "go";
		
		/**
		 * 玩家。由 Well.PLAYER_1 或 Well.PLAYER_2 指示。
		 * <br />
		 * <ul>
		 *   <li>当调度 WIN 事件时，此属性代表赢家。</li>
		 *   <li>当调度 GO 事件时，此属性代表当前行棋的玩家。</li>
		 * </ul>
		 */		
		public var player:int;
		
		/**
		 * 棋子路径。例如：第一行的路径为 "012" 。
		 * <br />
		 * 当调度 WIN 事件时，此属性代表胜利时的棋子路径。
		 */		
		public var path:String;
		
		/**
		 * 棋子位置。
		 * <br />
		 * 当调度 GO 事件时，此属性代表该步棋的棋子位置。
		 */		
		public var position:int;
		
		/**
		 * 构造函数。
		 * @param type
		 * 
		 */		
		public function WellGameEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			var e:WellGameEvent = new WellGameEvent(this.type);
			e.player = this.player;
			e.path = this.path;
			e.position = this.position;
			return e;
		}
		
	}
}