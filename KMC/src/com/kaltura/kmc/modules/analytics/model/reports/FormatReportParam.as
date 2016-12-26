package com.kaltura.kmc.modules.analytics.model.reports {
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.kmc.modules.analytics.model.types.ScreenTypes;
	import com.kaltura.kmc.modules.analytics.utils.FormattingUtil;
	import com.kaltura.utils.KTimeUtil;
	
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberBaseRoundType;
	import mx.formatters.NumberFormatter;
	import mx.resources.ResourceManager;

	public class FormatReportParam {
		private static var _numberFormatter:NumberFormatter = new NumberFormatter();
		private static var _dateFormatter:DateFormatter = new DateFormatter();


		public static function format(param:String, value:String):String {
			var date:Date;
			var year:String;
			var month:String;

			switch (param) {

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
				case "count_loads":
					// format as number
					_numberFormatter.precision = 0;
					return _numberFormatter.format(int(value));
					break;

				case 'avg_view_drop_off':
				case 'play_through_ratio':
				case "load_play_ratio":
					// format as percents
					_numberFormatter.precision = 2;
					return ResourceManager.getInstance().getString('analytics', 'percents_format', [_numberFormatter.format(Number(value) * 100)]);
					break;

				case "sum_time_viewed":
				case "avg_time_viewed":
					// format as HH:MM:SS
					return KTimeUtil.formatTime2(Number(value) * 60);
					break;
				case "event_date_id":
					return new Date(Number(value) * 1000).toDateString();
					break;
				
				case "entry_media_source_name":
					return getLocalised('sourceTypes', value);
					break;

				case "country":
					return getLocalised('map', value);
					break;
				case "date_id":
					return FormattingUtil.formatFullDateString(value);
					break;
				case "month_id":
					return FormattingUtil.formatMonthString(value);
					break;
				case "bandwidth_consumption":
				case "storage_used":
				case "used_storage":
				case "combined_bandwidth_storage":
				case "added_storage_mb":
				case "deleted_storage_mb":
				case "total_storage_mb":
				case "average_storage":
				case "peak_storage":
				case "added_storage":
				case "deleted_storage":
				case "transcoding_consumption":
				case "aggregated_monthly_avg_storage":
				case "combined_bandwidth_aggregated_storage":
					var fmtr:NumberFormatter = new NumberFormatter();
					fmtr.rounding = NumberBaseRoundType.NEAREST;
					fmtr.precision = 0;
					var currValue:Number = parseFloat(value);
					return isNaN(currValue) ? ResourceManager.getInstance().getString('analytics', 'n_a') : fmtr.format(currValue);
					break;
				case "added_msecs":
				case "deleted_msecs":
				case "total_msecs":
					var numValue:Number = Math.abs(Number(value));
					var wholeMinutes:Number = Math.floor(numValue / 60000);
					var wholeSeconds:Number = Math.floor((numValue - (wholeMinutes * 60000)) / 1000);
					var secondsText:String = wholeSeconds < 10 ? "0" + wholeSeconds.toString() : wholeSeconds.toString();
					var formattedTime:String = wholeMinutes.toString() + ":" + secondsText;

					if (Number(value) < 0) {
						formattedTime = "-" + formattedTime;
					}

					return formattedTime;
					break;
				case "device":
				case "os":
				case "browser":
					// replace "_" with space
					return value.replace("_", " ");
					break;

			}
			return value;
		}
		
		
		private static function getLocalised(bundleName:String, resourceName:String):String {
			var result:String = ResourceManager.getInstance().getString(bundleName, resourceName);
			if (!result) {
				result = resourceName;
			}
			return result;
		}
	}
}
