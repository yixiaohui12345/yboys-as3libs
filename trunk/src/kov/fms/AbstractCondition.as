package kov.fms
{
	/**
	 * 条件。
	 * @author Y.Boy | http://riaoo.com
	 */	
	public class AbstractCondition
	{
		/**
		 * 下一个条件计算者。
		 */		
		protected var nextCondition:AbstractCondition;
		
		public function AbstractCondition()
		{
		}
		
		/**
		 * [需要被重写] 计算条件。
		 * @param stateMachine 状态机。
		 * @param data 可能用于计算的数据。
		 * @return 返回符合条件的输出状态。
		 */		
		public function compute(stateMachine:IStateMachine, data:*=null):IState
		{
			throw new Error("Abstract function.");
			return null;
		}
		
		/**
		 * 设置下一个条件计算者。
		 * @param condition
		 */		
		public function setNextCondition(condition:AbstractCondition):void
		{
			this.nextCondition = condition;
		}
	}
}