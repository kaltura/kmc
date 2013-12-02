package com.kaltura.kmc.modules.analytics.business {
	import com.kaltura.kmc.modules.analytics.utils.TimeConsts;
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	
	import mx.controls.ComboBox;
	import mx.events.ListEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ArrayUtil;
	import com.kaltura.edw.vo.LocalizedVo;

	/**
	 * dates range manager for the short term: day to year.
	 * @author atar.shadmi
	 *
	 */
	public class ShortTermRangeManager implements IDateRangeManager {
		private static const SECOND_IN_MILI:Number = 1000;

		private var _dateRange:Array;
		private var _latestToDate:Date;
		private var _latestFromDate:Date;
		private var _latestSelected:Object;
		


		public function ShortTermRangeManager() {
			
			_dateRange = [new LocalizedVo('yesterday', 'yesterday', 'analytics'),
				new LocalizedVo('last7Days', 'last7Days', 'analytics'),
				new LocalizedVo('thisWeek', 'thisWeek', 'analytics'),
				new LocalizedVo('lastWeek', 'lastWeek', 'analytics'),
				new LocalizedVo('last30Days', 'last30Days', 'analytics'),
				new LocalizedVo('thisMonth', 'thisMonth', 'analytics'),
				new LocalizedVo('lastMonth', 'lastMonth', 'analytics'),
				new LocalizedVo('last12Months', 'last12Months', 'analytics'),
				new LocalizedVo('thisYear', 'thisYear', 'analytics'),
				new LocalizedVo('custom', 'custom', 'analytics')
				];
			
			var today:Date = new Date();
			_latestSelected = _dateRange[4];
			_latestFromDate = new Date(today.time - 30 * TimeConsts.DAY + today.timezoneOffset * 60000);
			_latestToDate = today;
		}


		
		public function get latestSelected():Object {
			return _latestSelected;
		}
		
		
		public function set latestSelected(value:Object):void {
			_latestSelected = value;
		}


		public function get latestFromDate():Date {
			return _latestFromDate;
		}


		public function set latestFromDate(value:Date):void {
			_latestFromDate = value;
		}


		public function get latestToDate():Date {
			return _latestToDate;
		}


		public function set latestToDate(value:Date):void {
			_latestToDate = value;
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
			var now:Date = new Date();
			var nowTime:Number = now.time;	// current UTC time in MS
			var tzOffsetMs:Number = now.timezoneOffset * 60000;	// current timezone offset in MS (original value in minutes)
			
			latestSelected = (event.target as ComboBox).selectedItem;

			switch ((event.target as ComboBox).selectedItem.value) {
				case 'yesterday':
					filterVo.fromDate = new Date(nowTime - TimeConsts.DAY + tzOffsetMs);
					filterVo.toDate = now;
					break;
				case 'last7Days':
					filterVo.fromDate = new Date(nowTime - 7 * TimeConsts.DAY + tzOffsetMs);
					filterVo.toDate = now;
					break;
				case 'thisWeek':
					// last sunday to today
					filterVo.fromDate = new Date(nowTime - now.day * TimeConsts.DAY + tzOffsetMs);
					filterVo.toDate = now;
					break;
				case 'lastWeek':
					// 2 sundays ago to last saturday 
					filterVo.fromDate = new Date(nowTime - (now.day + 7) * TimeConsts.DAY + tzOffsetMs);
					filterVo.toDate = new Date(nowTime - (now.day + 1) * TimeConsts.DAY + tzOffsetMs);
					break;
				case 'last30Days':
					// 30 days ago until today
					filterVo.fromDate = new Date(nowTime - 30 * TimeConsts.DAY + tzOffsetMs);
					filterVo.toDate = now;
					break;
				case 'last12Months':
					// actually gives a year ago today until today
					filterVo.fromDate = new Date(now.fullYear - 1, now.month, now.date);
					filterVo.toDate = now;
					break;
				case 'thisMonth':
					// actually gives first day of the month until today
					filterVo.fromDate = new Date(now.fullYear, now.month, 1);
					filterVo.toDate = now;
					break;
				case 'lastMonth':
					// actually gives from the first of last month to the last of last month
					if (now.month > 0) {
						filterVo.fromDate = new Date(now.fullYear, now.month - 1, 1);
					}
					else {
						filterVo.fromDate = new Date(now.fullYear - 1, 11, 1);
					}
					filterVo.toDate = new Date(nowTime - TimeConsts.DAY * now.date + tzOffsetMs);
					break;
				case 'thisYear':
					// actually gives from the 1/1 of current year to today
					filterVo.fromDate = new Date(now.fullYear, 0, 1);
					filterVo.toDate = now;
					break;
				default:
					break;
			}
			
			latestFromDate = filterVo.fromDate;
			latestToDate = filterVo.toDate;
		}

		/**
		 * checks if alDate date is last sunday before today
		 * @param alDate alleged last sunday
		 * @param today
		 * @return true if condition is met
		 */
		protected function isLastSunday(alDate:Date, today:Date):Boolean {
			var sunday:Date = new Date(today.time - today.day * TimeConsts.DAY + today.timezoneOffset * 60000);
			return sunday.date == alDate.date && alDate.month == sunday.month && alDate.fullYear == sunday.fullYear;
		}
			

		public function changeRangeByDate(filterVo:FilterVo):int {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var now:Date = new Date();
			var date:int = now.date;
			var month:int = now.month;
			var year:int = now.fullYear;
			
			var fromDate:Date = filterVo.fromDate;
			var toDate:Date = filterVo.toDate;
			
			var result:String = ''; // the required string (key in locale, item value)

			if (fromDate.date == date - 1 && fromDate.month == month && fromDate.fullYear == year
				&& toDate.date == date && toDate.month == month && toDate.fullYear == year) {
				result = 'yesterday';
			}
			else if (fromDate.date == date - 7 && fromDate.month == month && fromDate.fullYear == year
				&& toDate.date == date && toDate.month == month && toDate.fullYear == year) {
				//TODO handle first 6 days of month
				result = 'last7Days';
			}
			else if (isLastSunday(fromDate, now)
				&& toDate.date == date && toDate.month == month && toDate.fullYear == year) {
				// last sunday to today
				result = 'thisWeek';
			}
			else if (now.time - fromDate.time >= 7 * TimeConsts.DAY && now.time - fromDate.time < 14 * TimeConsts.DAY 
				&& fromDate.day == 0 && toDate.day == 6 && now.time > toDate.time) {
				// 2 sundays ago to last saturday
				result = 'lastWeek';
			}
			else if (now.time - fromDate.time >= TimeConsts.DAY * 30 && now.time - fromDate.time < TimeConsts.DAY * 31 
				&& now.time - toDate.time >= 0 && now.time - toDate.time < TimeConsts.DAY) {
				result = 'last30Days';
			}
			else if (now.time - toDate.time >= 0 && now.time - toDate.time < TimeConsts.DAY 
				&& fromDate.fullYear == toDate.fullYear && fromDate.month == toDate.month && fromDate.date == 1) {
				result = 'thisMonth';
			}
			else if (toDate.month + 1 == now.month && fromDate.date == 1 && fromDate.month + 1 == now.month) {
				var tempDate:Date = new Date(now.time - now.date * TimeConsts.DAY);
				if (toDate.date == tempDate.date) {
					result = 'lastMonth';
				}
				else {
					result = 'custom';
				}
			}
			else if (toDate.fullYear == fromDate.fullYear + 1 && toDate.month == fromDate.month && toDate.date == fromDate.date 
				&& now.time - toDate.time >= 0 && now.time - toDate.time < TimeConsts.DAY) {
				result = 'last12Months';
			}
			else if (now.time - toDate.time >= 0 && now.time - toDate.time < TimeConsts.DAY 
				&& now.fullYear == fromDate.fullYear && fromDate.month == 0 && fromDate.date == 1) {
				result = 'thisYear';
			}
			else {
				result = 'custom';
			}
			
			var i:int;
			for (i = _dateRange.length - 1; i>=0; i--) {
				if (_dateRange[i].value == result) {
					latestSelected = _dateRange[i];
					break;
				}
			}
			return i;
		}
	}
}
