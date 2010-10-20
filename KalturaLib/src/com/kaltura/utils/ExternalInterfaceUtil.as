package com.kaltura.utils
{
	import com.kaltura.utils.externalInterface.JsBlock;

	import flash.external.ExternalInterface;

	public class ExternalInterfaceUtil
	{
		static public const commentPattern:RegExp = /(\/\*([^*]|[\r\n]|(\*+([^*\/]|[\r\n])))*\*+\/)|((^|[^:\/])(\/\/.*))/g;

		/**
		 * builds a javascript function that can be run through eval() using externalInterface.
		 * @param js_function_name		the name of the main javascript function to run.
		 * @param js_function			the javascript function to run.
		 * @param params					extra parameters to be passed to the javascript function, order of parameters is mandatory.
		 * @return 						a javascript function that can be run using eval with the parameters given.
		 */
		static public function injectJavascript (js_function_name:String, js_function:String, params:Array):Object
		{
			var functionCall:String = "";
			var functionParams:String = "";
			// insert paraneters values
			if (params && params.length > 0)
				functionParams = params.join(",");
			// check if need to write a function call or not
			if (js_function_name)
				functionCall = js_function_name+"("+functionParams+");"
			functionCall = js_function + " " + functionCall;
			functionCall = functionCall.replace(commentPattern, "");
			//TODO: replace all single quotes with double quotes - Needs to come up with better
			//regexp to keep single quotes within text as it is and only replace the one used in statements.
			return ExternalInterfaceUtil.callExternalInterface (functionCall);
		}

		/**
		 *calls external interface with a given javascript code and eval.
		 * @param js_code		the code to inject to the external interface.
		 * @param eval			if true will use eval to run the code, if false will call the js_code as a function handler.
		 * @param params		array of values to pass to the js code, order of parameters is mandatory.
		 * @return 				the object returned from the external inteface function.
		 */
		static public function callExternalInterface(js_code:String, eval:Boolean = true, params:* = null):Object
		{
			try {
				if (ExternalInterface.available)
				{
					if (eval)
					{
						return ExternalInterface.call ("eval", js_code);
					} else {
						if (params)
							return ExternalInterface.call (js_code, params);
						else
							return ExternalInterface.call (js_code);
					}
				} else {
					return null;
				}
			} catch (error:Error) {
				return false;
			}
			return null;
		}

		/**
		 * run a jsBlock.
		 * @param jsBlock			the jsBlock to build and run.
		 * @param parameters		array of values to pass to the function parameters, order of parameters is mandatory.
		 * @return 					the object returned from the external inteface function.
		 * @see com.kaltura.utils.externalInterface.JsBlock
		 */
		static public function runJsBlock (jsBlock:JsBlock, parameters:* = null):Object
		{
			if (jsBlock.jsFunction === null || jsBlock.jsFunction == "")
			{
				if (jsBlock.jsHandler != "")
					return ExternalInterfaceUtil.callExternalInterface(jsBlock.jsHandler, false, parameters);
			} else {
				return ExternalInterfaceUtil.injectJavascript(jsBlock.jsHandler, jsBlock.jsFunction, parameters);
			}
			return null;
		}
	}
}