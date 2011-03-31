package kov.fms
{
	public interface IStateMachine
	{
		/**
		 * 更新。
		 */		
		function update():void;
		
		/**
		 * 改变状态。
		 * @param state 要改变的状态。
		 */		
		function changeState(state:IState):void;
		
		/**
		 * 受影响。
		 * @param data 受影响的数据。
		 */		
		function affected(data:*):void;
		
		/**
		 * 当前状态。
		 */		
		function get currentState():IState;
	}
}