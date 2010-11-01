package com.riaoo.javascript
{
	import flash.external.ExternalInterface;

	/**
	 * 把参数 code 转为 JS 代码并执行。就像 JS 的 eval() 方法。
	 * @param code JS 代码。
	 * @return 返回 code 执行后的返回值（如何有的话）。
	 */		
	public function JSEval(code:String):*
	{
		return ExternalInterface.call("eval", code);
	}
}