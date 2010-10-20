package com.kaltura.utils.externalInterface
{
	/**
	 * value object used to describe a javascript hook for a widget.
	 * @author Zohar Babin
	 *
	 */
	public class JsBlock
	{
		public function JsBlock (block_id:String, js_handler:String, js_function:String, ...args)
		{
			blockId = block_id;
			jsHandler = js_handler;
			jsFunction = js_function;
			parameters = args;
		}

		/**
		 *the id of the js block in the uiConf.
		 */
		public var blockId:String = "";
		/**
		 *the name of the handler function to call when the event is dispatched or command finished.
		 */
		public var jsHandler:String = "";
		/**
		 *a function to run (this will be injected to the page) when the event is dispatched or command finished.
		 */
		public var jsFunction:String = "";
		/**
		 *array of parameters to pass to the external interface (container).
		 */
		public var parameters:Array = [];
	}
}