package com.kaltura.utils
{
	import mx.formatters.DateFormatter;
	
	public class KTimeUtil
	{
		public static const DAY_TIME_FORMAT : String = "JJ:NN:SS" 
		public static const HOUR_TIME_FORMAT : String = "NN:SS";
		
		private static var dateFormatter : DateFormatter = new DateFormatter;
		
		/**
		 * gets the time is seconds and return the time formated in hours format
		 * */
		public static function formatTime( sec:Number , viewAll : Boolean = false ) : String 
		{
			var pT:Number = sec || 0.1;
	        var pTimeMS:Date = new Date(pT * 1000);
	           
	        if(pTimeMS.hoursUTC<1 && !viewAll)
	        {
	        	dateFormatter.formatString = HOUR_TIME_FORMAT;  
	        	return dateFormatter.format(pTimeMS);
	        }
	        else
	        {
	        	dateFormatter.formatString = DAY_TIME_FORMAT;  
	        	pTimeMS.hours = pTimeMS.hoursUTC;
	            return dateFormatter.format(pTimeMS);
	        }
	    }
		
		
		/**
		 * formats a time string without using Flash's Date object
		 * @param secs
		 * @param showHours		if hours is more than 0, show it
		 * @param showSeconds	show seconds (even if 0)
		 * @param forceHours	show hours even if 0 
		 * @return given value, formatted as {HH}:MM:{SS }
		 * 
		 */
		public static function formatTime2(secs:Number, showHours:Boolean = true, showSeconds:Boolean = true, forceHours:Boolean = false):String {
			secs = Math.floor(secs);
			var h:Number = Math.floor(secs / 3600); // 60 * 60 = 3600
			var sh:Number = h * 3600;	// hours in seconds
			var m:Number = Math.floor((secs - sh) / 60);
			var sm:Number = m * 60;	// minutes in seconds
			var s:Number = secs - sh - sm;
			
			var result:String = '';
			if ((showHours && h>0) || forceHours) {
				result += addZero(h) + ':'; 
			}
			result += addZero(m);
			if (showSeconds) {
				result += ':' + addZero(s);
			}
			return result;
		}
		
		private static function addZero(n:int):String {
			return (n<10 ? '0' : '') + n;
		}

	}
}