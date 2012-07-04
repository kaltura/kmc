package com.kaltura.kmc.modules.analytics.utils
{
	import mx.formatters.DateFormatter;
	import mx.resources.ResourceManager;

	public class FormattingUtil
	{
		static public function formatMonthString(value:String):String{
			var year:String = String(value).substring(0,4);
			var month:String = String(value).substring(4,6);
			var date:Date = new Date( Number(year) , Number(month) , 0);
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = ResourceManager.getInstance().getString("analytics", "monthlyDateMask");
			return dateFormatter.format(date) ;
		}
		
		static public function formatFullDateString(value:String):String{
			var year:String = String(value).substring(0,4);
			var month:String = String(value).substring(4,6);
			var day : String = String(value).substring(6,8);
			
			// There was a deduction of the month number, but it was removed as it was found unnecessary.
			var date:Date = new Date( Number(year) , Number(month) - 1 , Number(day) );
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = ResourceManager.getInstance().getString("analytics", "dailyDateMask");
			return dateFormatter.format(date) ; 
		}
	}
}