package kov.fsm
{
	/**
	 * 状态控制器抽象类。
	 * <br/>
	 * 
	 * @author Y.Boy | http://riaoo.com
	 */	
	public class AbstractStateControl
	{
		/**
		 * 下一个状态控制器。
		 */		
		protected var nextStateControl:AbstractStateControl;
		
		/**
		 * 不应该实例化抽象类。
		 */		
		public function AbstractStateControl()
		{
			throw new Error("Abstract constructor.");
		}
		
		/**
		 * [需要重写] 执行。调用此方法，计算出目标状态。
		 * <br/>
		 * 此类使用了职责链模式，从链条里找出符合条件的状态并返回。
		 * @param stateMachine 状态机。
		 * @param data 可能用于计算的数据。
		 * @return 返回符合条件的输出状态。
		 */		
		public function execute(stateMachine:IStateMachine, data:*=null):IState
		{
			throw new Error("Abstract function.");
			return null;
		}
		
		/**
		 * 设置下一个条件计算者。
		 * @param condition
		 */		
		public function setNextControl(value:AbstractStateControl):void
		{
			this.nextStateControl = value;
		}
	}
}