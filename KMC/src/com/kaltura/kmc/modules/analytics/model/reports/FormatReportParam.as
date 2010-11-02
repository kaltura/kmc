package com.kaltura.kmc.modules.analytics.model.reports
{
	import com.kaltura.kmc.modules.analytics.model.KMCModelLocator;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.utils.KTimeUtil;
	
	import mx.formatters.NumberFormatter;
	import mx.resources.ResourceManager;
	
	public class FormatReportParam
	{
		private static var _numberFormatter : NumberFormatter = new NumberFormatter();
		
		public static function format( param : String , value : String) : String
		{
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
				
				case "country": return ResourceManager.getInstance().getString('map',value); break;
			}
			return value;			
		}
	}
}