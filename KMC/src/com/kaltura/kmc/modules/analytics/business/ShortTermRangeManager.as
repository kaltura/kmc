package com.kaltura.kmc.modules.analytics.business {
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;

	import mx.controls.ComboBox;
	import mx.events.ListEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ArrayUtil;

	/**
	 * dates range manager for the short term: day to year. 
	 * @author atar.shadmi
	 * 
	 */
	public class ShortTermRangeManager implements IDateRangeManager {
		private static const ONE_DAY:Number = 1000 * 60 * 60 * 24;
		private static const SECOND_IN_MILI:Number = 1000;

		private var _dateRange:Array;


		public function ShortTermRangeManager() {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			_dateRange = [resourceManager.getString('analytics', 'yesterday'),
				resourceManager.getString('analytics', 'last7Days'),
				resourceManager.getString('analytics', 'thisWeek'),
				resourceManager.getString('analytics', 'lastWeek'),
				resourceManager.getString('analytics', 'last30Days'),
				resourceManager.getString('analytics', 'thisMonth'),
				resourceManager.getString('analytics', 'lastMonth'),
				resourceManager.getString('analytics', 'last12Months'),
				resourceManager.getString('analytics', 'thisYear'),
				resourceManager.getString('analytics', 'custom')];
		}


		[Bindable]
		/**
		 * values for the range dropdown list
		 */
		public function get dateRange():Array {
			return _dateRange;
		}


		public function set dateRange(value:Array):void {
			_dateRange = value;
		}



		public function changeDateByRange(event:ListEvent, filterVo:FilterVo):void {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var today:Date = new Date();
			var todaysHourInMiliSeconds:Number = (((today.hoursUTC) * 60 + today.minutesUTC) * 60 + today.secondsUTC) * 1000 + today.millisecondsUTC;
			var todayStart:Number = today.time - todaysHourInMiliSeconds;

			filterVo.selectedDate = (event.target as ComboBox).selectedItem.toString();

			switch ((event.target as ComboBox).selectedItem.toString()) {
				case resourceManager.getString('analytics', 'yesterday'):
					// actually gives the day before yesterday
					filterVo.fromDate = new Date((todayStart - 2 * ONE_DAY + today.timezoneOffset * 60000) + ONE_DAY);
					filterVo.toDate = new Date((todayStart - ONE_DAY - SECOND_IN_MILI + today.timezoneOffset * 60000) + ONE_DAY);
					break;
				case resourceManager.getString('analytics', 'last7Days'):
					// actually gives 7 days, starting 8 days ago and ending yesterday
					filterVo.fromDate = new Date((todayStart - 8 * ONE_DAY + today.timezoneOffset * 60000) + ONE_DAY);
					filterVo.toDate = new Date((todayStart - ONE_DAY - SECOND_IN_MILI + today.timezoneOffset * 60000) + ONE_DAY);
					break;
				case resourceManager.getString('analytics', 'thisWeek'):
					// actually gives from last sunday to yesterday
					filterVo.fromDate = new Date(todayStart - (today.day) * ONE_DAY + today.timezoneOffset * 60000);
					if (today.day == 0) {
						// there is no data for yesterday, but it doesn't twist the results
						filterVo.toDate = new Date(todayStart + today.timezoneOffset * 60000 - SECOND_IN_MILI);
					}
					else {
						filterVo.toDate = new Date((todayStart - ONE_DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + ONE_DAY);
					}
					break;
				case resourceManager.getString('analytics', 'lastWeek'):
					// actually gives 2 sundays ago to last sunday 
					filterVo.fromDate = new Date(todayStart - (today.day + 7) * ONE_DAY + today.timezoneOffset * 60000);
					filterVo.toDate = new Date(todayStart - today.day * ONE_DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI);
					break;
				case resourceManager.getString('analytics', 'last30Days'):
					// actually gives 31 days ago until yesterday
					filterVo.fromDate = new Date((todayStart - 31 * ONE_DAY + today.timezoneOffset * 60000) + ONE_DAY);
					filterVo.toDate = new Date((todayStart - ONE_DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + ONE_DAY);
					break;
				case resourceManager.getString('analytics', 'last12Months'):
					// actually gives a year ago today until yesterday
					var date:Number = today.date;
					var month:Number = today.month;
					var year:Number = today.fullYear;
					if (date == 1) {
						if (month == 1) {
							year -= 1;
						}
						else {
							month -= 1;
						}
					}
					else
						date -= 1;

					filterVo.fromDate = new Date(year - 1, month, date);
					filterVo.toDate = new Date((todayStart - ONE_DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + ONE_DAY);
					break;
				case resourceManager.getString('analytics', 'thisMonth'):
					// actually gives first day of the month until yesterday
					filterVo.fromDate = new Date(today.fullYear, today.month, 1);
					if (today.date == 1) {
						filterVo.toDate = new Date(filterVo.fromDate.time);
					}
					else {
						filterVo.toDate = new Date((todayStart - ONE_DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + ONE_DAY);
					}
					break;
				case resourceManager.getString('analytics', 'lastMonth'):
					// actually gives from the first of last month to the last of last month
					if (today.month > 0) {
						filterVo.fromDate = new Date(today.fullYear, today.month - 1, 1);
					}
					else {
						filterVo.fromDate = new Date(today.fullYear - 1, 11, 1);
					}
					filterVo.toDate = new Date(todayStart - (ONE_DAY * (today.date - 1)) + today.timezoneOffset * 60000 - SECOND_IN_MILI);
					break;
				case resourceManager.getString('analytics', 'thisYear'):
					// actually gives from the 1/1 of current year to yesterday
					filterVo.fromDate = new Date(today.fullYear, 0, 1);
					filterVo.toDate = new Date((todayStart - ONE_DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + ONE_DAY);
					break;
				default:
					return;
					break;
			}
		}


		public function changeRangeByDate(filterVo:FilterVo):int {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var curDate:Date = new Date();
			var todaysHourInMiliSeconds:Number = (((curDate.hoursUTC) * 60 + curDate.minutesUTC) * 60 + curDate.secondsUTC) * 1000 + curDate.millisecondsUTC;
			var today:Date = new Date(Number(curDate.time - todaysHourInMiliSeconds - ONE_DAY));
			var result:String = '';	// the required string

			if (today.time - filterVo.fromDate.time >= ONE_DAY 
				&& today.time - filterVo.fromDate.time < ONE_DAY * 2 
				&& today.time - filterVo.toDate.time >= 0 
				&& today.time - filterVo.toDate.time <= ONE_DAY) {
				// dateCb.selectedItem = resourceManager.getString('analytics', 'yesterday');
				result = resourceManager.getString('analytics', 'yesterday');
			}
			else if (today.time - filterVo.fromDate.time >= ONE_DAY * 6 
				&& today.time - filterVo.fromDate.time < ONE_DAY * 7 
				&& today.time - filterVo.toDate.time >= 0 
				&& today.time - filterVo.toDate.time <= ONE_DAY) {
				// dateCb.selectedItem = resourceManager.getString('analytics', 'last7Days');
				result = resourceManager.getString('analytics', 'last7Days');
			}
			else if (today.time - filterVo.fromDate.time >= ((filterVo.toDate.day) * ONE_DAY) 
				&& today.time - filterVo.fromDate.time < ((filterVo.toDate.day + 1) * ONE_DAY) 
				&& today.time - filterVo.toDate.time >= 0 
				&& today.time - filterVo.toDate.time < ONE_DAY) {
				// dateCb.selectedItem = resourceManager.getString('analytics', 'thisWeek');
				result = resourceManager.getString('analytics', 'thisWeek');
			}
			else if (today.time - filterVo.fromDate.time >= 7 * ONE_DAY 
				&& today.time - filterVo.fromDate.time < 14 * ONE_DAY 
				&& filterVo.fromDate.dayUTC == 0 
				&& filterVo.toDate.dayUTC == 6) {
				// dateCb.selectedItem = resourceManager.getString('analytics', 'lastWeek');
				result = resourceManager.getString('analytics', 'lastWeek');
			}
			else if (today.time - filterVo.fromDate.time >= ONE_DAY * 30 && today.time - filterVo.fromDate.time < ONE_DAY * 31 && today.time - filterVo.toDate.time >= 0 && today.time - filterVo.toDate.time < ONE_DAY) {
				// dateCb.selectedItem = resourceManager.getString('analytics', 'last30Days');
				result = resourceManager.getString('analytics', 'last30Days');
			}
			else if (today.time - filterVo.toDate.time >= 0 && today.time - filterVo.toDate.time < ONE_DAY && filterVo.fromDate.fullYearUTC == filterVo.toDate.fullYearUTC && filterVo.fromDate.monthUTC == filterVo.toDate.monthUTC && filterVo.fromDate.dateUTC == 1) {
				// dateCb.selectedItem = resourceManager.getString('analytics', 'thisMonth');
				result = resourceManager.getString('analytics', 'thisMonth');
			}
			else if (filterVo.toDate.monthUTC + 1 == today.monthUTC && filterVo.fromDate.dateUTC == 1 && filterVo.fromDate.monthUTC + 1 == today.monthUTC) {
				var tempDate:Date = new Date(today.time - (today.dateUTC * ONE_DAY));
				if (filterVo.toDate.dateUTC == tempDate.dateUTC) {
					// dateCb.selectedItem = resourceManager.getString('analytics', 'lastMonth');
					result = resourceManager.getString('analytics', 'lastMonth');
				}
				else {
					// dateCb.selectedItem = ResourceManager.getInstance().getString('analytics', 'custom');
					result = resourceManager.getString('analytics', 'custom');
				}
			}
			else if (filterVo.toDate.fullYearUTC == filterVo.fromDate.fullYearUTC + 1 && filterVo.toDate.monthUTC == filterVo.fromDate.monthUTC && filterVo.toDate.dateUTC == filterVo.fromDate.dateUTC - SECOND_IN_MILI && today.time - filterVo.toDate.time >= 0 && today.time - filterVo.toDate.time < ONE_DAY) {
				// dateCb.selectedItem = resourceManager.getString('analytics', 'last12Months');
				result = resourceManager.getString('analytics', 'last12Months');
			}
			else if (today.time - filterVo.toDate.time >= 0 && today.time - filterVo.toDate.time < ONE_DAY && today.fullYearUTC == filterVo.fromDate.fullYearUTC && filterVo.fromDate.monthUTC == 0 && filterVo.fromDate.dateUTC == 1) {
				// dateCb.selectedItem = resourceManager.getString('analytics', 'thisYear');
				result = resourceManager.getString('analytics', 'thisYear');
			}
			else {
				// dateCb.selectedItem = ResourceManager.getInstance().getString('analytics', 'custom');
				result = resourceManager.getString('analytics', 'custom');
			}

			filterVo.selectedDate = result;

			return ArrayUtil.getItemIndex(result, _dateRange);
		}
	}
}
