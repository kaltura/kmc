package com.kaltura.kmc.modules.content.utils
{
	public class StringUtil {
		
		/**
		 * Check if a string is longer than 512.
		 * if it is it will cut it and add '...'.
		 * @param str	the string to be truncated
		 * @return 	truncated string
		 */
		public static function cutTo512Chars(str:String):String {
			if (!str) {
				str = "";
			}
			else if (str.length >= 509) {
				str = str.substr(0, 509);
				var words:Array = str.split(" ");
				// remove the last (possibly incomplete) word
				words.pop();
				str = words.join(" ");
				str = str + "...";
			}
			return str;
		}
	}
}