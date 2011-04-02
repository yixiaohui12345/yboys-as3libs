package kov.fsm
{
	public interface IState
	{
		/**
		 * 执行。
		 * @param stateMachine 拥有此状态的状态机。
		 */		
		function update(stateMachine:IStateMachine):void;
		
		/**
		 * 进入状态时执行的函数。
		 * @param stateMachine
		 */		
		function enter(stateMachine:IStateMachine):void;
		
		/**
		 * 退出状态时执行的函数。
		 * @param stateMachine
		 */		
		function exit(stateMachine:IStateMachine):void;
	}
}