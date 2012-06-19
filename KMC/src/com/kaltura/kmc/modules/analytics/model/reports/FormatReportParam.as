package com.kaltura.kmc.modules.analytics.model.reports
{
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.utils.KTimeUtil;
	
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	import mx.resources.ResourceManager;
	
	public class FormatReportParam
	{
		private static var _numberFormatter : NumberFormatter = new NumberFormatter();
		private static var _dateFormatter : DateFormatter = new DateFormatter();
		
		public static function format( param : String , value : String) : String
		{
			var date : Date;
			var year : String;
			var month : String;
			
			switch(param)
			{

				case "count_plays":
				case 'count_plays_25':
				case 'count_plays_50': 
				case 'count_plays_75':
				case 'count_plays_100':
				case "distinct_plays":
				case 'count_total':
				case 'count_ugc':
				case 'count_admin':
				case 'count_video':
				case 'count_audio':
				case 'count_download':
				case 'count_report':
				case 'count_viral':
				case 'count_edit':
				case 'count_image':
				case 'count_mix':
				case "count_loads": return _numberFormatter.format(int(value)) ; break;
				
				case 'avg_view_drop_off':
				case 'play_through_ratio':
				case "load_play_ratio": return (Number(value) * 100).toFixed(2) + "%"; break;
				
				case "sum_time_viewed": return _numberFormatter.format( Number(value).toFixed(2)); break; //Math.round(Number(value))
				case "avg_time_viewed": return KTimeUtil.formatTime( Number(value)*60 , true ); break;
				case "event_date_id": return new Date(Number(value)*1000).toDateString(); break;
				
				case "country": 
					var result:String = ResourceManager.getInstance().getString('map',value);
					if (!result) {
						result = value;
					}
					return result; 
					break;
				case "date_id":
					year = String(value).substring(0,4);
					month = String(value).substring(4,6);
					var day : String = String(value).substring(6,8);
					
					// There was a deduction of the month number, but it was removed as it was found unnecessary.
					date = new Date( Number(year) , Number(month) - 1 , Number(day) );
					_dateFormatter.formatString = ResourceManager.getInstance().getString("analytics", "dailyDateMask");
					return _dateFormatter.format(date) ; 
					break;
				case "month_id":
					year = String(value).substring(0,4);
					month = String(value).substring(4,6);
					date = new Date( Number(year) , Number(month) , 0);
					_dateFormatter.formatString = ResourceManager.getInstance().getString("analytics", "monthlyDateMask");
					return _dateFormatter.format(date) ;
					break;
				case "bandwidth_consumption":
				case "storage_used":
				case "used_storage":
				case "combined_bandwidth_storage":
				case "added_storage_mb":
				case "total_storage_mb":
					return Math.ceil(parseFloat(value)).toString();
					break;
				case "added_msecs":
				case "total_msecs":
					var numValue:Number = Math.abs(Number(value));
					var wholeMinutes:Number = Math.floor(numValue / 60000);
					var wholeSeconds:Number = Math.floor((numValue - (wholeMinutes * 60000)) / 1000);
					var secondsText:String = wholeSeconds < 10 ? "0" + wholeSeconds.toString() : wholeSeconds.toString(); 
					var formattedTime:String = wholeMinutes.toString() + ":" + secondsText;
					
					if (Number(value) < 0){
						formattedTime = "-" + formattedTime;
					}
					
					return formattedTime;
			}
			return value;			
		}
	}
}