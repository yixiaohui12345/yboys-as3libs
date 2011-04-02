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
		 * 输入数据。这是外部影响状态机的输入动作。
		 * @param data 外部影响状态机的输入数据。
		 */		
		function input(data:*):void;
		
		/**
		 * 当前状态。
		 */		
		function get currentState():IState;
	}
}