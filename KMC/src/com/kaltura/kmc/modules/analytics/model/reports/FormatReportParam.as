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
			var newDate : Date;
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
					var date : String = String(value).substring(6,8);	
					newDate = new Date( Number(year) , Number(month)-1 , Number(date) );
					_dateFormatter.formatString = ResourceManager.getInstance().getString("analytics", "dailyDateMask");
					return _dateFormatter.format(newDate) ; 
					break;
				case "month_id":
					year = String(value).substring(0,4);
					month = String(value).substring(4,6);
					newDate = new Date( Number(year) , Number(month)-1 , 0);
					_dateFormatter.formatString = ResourceManager.getInstance().getString("analytics", "monthlyDateMask");
					return _dateFormatter.format(newDate) ; 
				case "bandwidth_consumption":
				case "storage_used":
				case "used_storage":
				case "combined_bandwidth_storage":
					return Math.ceil(parseFloat(value)).toString() + " MB";
			}
			return value;			
		}
	}
}