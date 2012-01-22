package com.kaltura.kmc.modules.account.business
{
	public class CustomDataStringUtil {
		
		/**
		 * replace occurances of "&" with "&amp;" without damaging existing replacements
		 * @param value		the string to escape
		 * @return escaped string
		 * */
		public static function escapeAmps(value:String):String {
			var result:String = '';
			var ar1:Array = value.split("&amp;"); // each cell holds a string that doesn't include &amp;
			var ar2:Array;
			var l:int = ar1.length;
			for (var i:int = 0; i<l; i++) {
				ar2 = ar1[i].split("&");	// each cell holds a string that doesn't include &
				for (var j:int = 0; j<ar2.length; j++) {
					result += ar2[j] + "&amp;";
				}
			}
			// remove the final "&amp;"
			result = result.substring(0, result.length - 5);
			
			return result;
		}
	}
}