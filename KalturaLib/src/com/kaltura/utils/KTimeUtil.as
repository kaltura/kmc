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

	}
}