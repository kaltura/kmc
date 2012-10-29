package com.kaltura.kmc.modules.analytics.business {
	import com.kaltura.kmc.modules.analytics.utils.TimeConsts;
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	
	import mx.controls.ComboBox;
	import mx.events.ListEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ArrayUtil;

	public class LongTermRangeManager implements IDateRangeManager {

		private static const SECOND_IN_MILI:Number = 1000;

		private var _dateRange:Array;
		private var _latestToDate:Date;
		private var _latestFromDate:Date;
		private var _latestSelected:String;




		public function LongTermRangeManager() {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var today:Date = new Date();
			var todaysHourInMiliSeconds:Number = (((today.hoursUTC) * 60 + today.minutesUTC) * 60 + today.secondsUTC) * 1000 + today.millisecondsUTC;
			var todayStart:Number = today.time - todaysHourInMiliSeconds;
			
			_latestSelected = resourceManager.getString('analytics', 'curYear');
			_latestFromDate = new Date(today.fullYear, 0, 1);
			_latestToDate = new Date((todayStart - TimeConsts.DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + TimeConsts.DAY);
			
			_dateRange = [resourceManager.getString('analytics', 'curYear'),	//Current year (default)
				resourceManager.getString('analytics', 'curMonth'),				//Current month
				resourceManager.getString('analytics', 'curPrevMonth'),			//Current and previous month
				resourceManager.getString('analytics', 'prevMonth'),			//Previous month
				resourceManager.getString('analytics', 'curQtr'),				//Current quarter
				resourceManager.getString('analytics', 'curPrevQtr'),			//Current and previous quarter
				resourceManager.getString('analytics', 'prevQtr'),				//Previous quarter
				resourceManager.getString('analytics', 'curPrevYear'),			//Current and previous year
				resourceManager.getString('analytics', 'prevYear'),				//Previous year
				resourceManager.getString('analytics', 'custom')];				//Custom
		}
		
		public function get latestSelected():String {
			return _latestSelected;
		}
		
		
		public function set latestSelected(value:String):void {
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

			latestSelected = (event.target as ComboBox).selectedItem.toString();

			switch ((event.target as ComboBox).selectedItem.toString()) {
				case resourceManager.getString('analytics', 'curYear'):
					// actually gives from the 1/1 of current year to yesterday
					filterVo.fromDate = new Date(today.fullYear, 0, 1);
					filterVo.toDate = new Date((todayStart - TimeConsts.DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + TimeConsts.DAY);
					break;

				case resourceManager.getString('analytics', 'curMonth'):
					// actually gives first day of the month until yesterday
					filterVo.fromDate = new Date(today.fullYear, today.month, 1);
					if (today.date == 1) {
						filterVo.toDate = new Date(filterVo.fromDate.time);
					}
					else {
						filterVo.toDate = new Date((todayStart - TimeConsts.DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + TimeConsts.DAY);
					}
					break;

				case resourceManager.getString('analytics', 'curPrevMonth'):
					if (today.month == 0) {
						// wer'e in january, get last december 
						filterVo.fromDate = new Date(today.fullYear - 1, 11, 1);
					}
					else {
						// first of last month
						filterVo.fromDate = new Date(today.fullYear, today.month - 1, 1);
					}

					if (today.date == 1) {
						filterVo.toDate = new Date(filterVo.fromDate.time);
					}
					else {
						filterVo.toDate = new Date((todayStart - TimeConsts.DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + TimeConsts.DAY);
					}
					break;

				case resourceManager.getString('analytics', 'prevMonth'):
					if (today.month == 0) {
						// wer'e in january, get last december 
						filterVo.fromDate = new Date(today.fullYear - 1, 11, 1);
					}
					else {
						// first of last month
						filterVo.fromDate = new Date(today.fullYear, today.month - 1, 1);
					}

					filterVo.toDate = new Date(today.fullYear, today.month, 1);
					break;

				case resourceManager.getString('analytics', 'curQtr'):
					filterVo.fromDate = new Date(today.fullYear, getFirstMonthOfQtr(today.month), 1);

					if (today.date == 1) {
						filterVo.toDate = new Date(filterVo.fromDate.time);
					}
					else {
						filterVo.toDate = new Date((todayStart - TimeConsts.DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + TimeConsts.DAY);
					}
					break;

				case resourceManager.getString('analytics', 'curPrevQtr'):
					if (today.month < 3) {
						// 4th qtr of last year
						filterVo.fromDate = new Date(today.fullYear - 1, 9, 1);
					}
					else if (today.month < 6) {
						// 1st qtr
						filterVo.fromDate = new Date(today.fullYear, 0, 1);
					}
					else if (today.month < 9) {
						// 2nd qtr
						filterVo.fromDate = new Date(today.fullYear, 3, 1);
					}
					else {
						// 3rd qtr
						filterVo.fromDate = new Date(today.fullYear, 6, 1);
					}



					if (today.date == 1) {
						filterVo.toDate = new Date(filterVo.fromDate.time);
					}
					else {
						filterVo.toDate = new Date((todayStart - TimeConsts.DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + TimeConsts.DAY);
					}
					break;

				case resourceManager.getString('analytics', 'prevQtr'):
					if (today.month < 3) {
						// 4th qtr of last year
						filterVo.fromDate = new Date(today.fullYear - 1, 9, 1); // (last) oct 1
						filterVo.toDate = new Date(today.fullYear - 1, 11, 31); // (last) dec 31
					}
					else if (today.month < 6) {
						// 1st qtr
						filterVo.fromDate = new Date(today.fullYear, 0, 1); // jan 1
						filterVo.toDate = new Date(today.fullYear, 2, 31); // mar 31
					}
					else if (today.month < 9) {
						// 2nd qtr
						filterVo.fromDate = new Date(today.fullYear, 3, 1); // apr 1
						filterVo.toDate = new Date(today.fullYear, 5, 30); // jun 30
					}
					else {
						// 3rd qtr
						filterVo.fromDate = new Date(today.fullYear, 6, 1); // jul 1
						filterVo.toDate = new Date(today.fullYear, 8, 30); // sep 30
					}

					break;

				case resourceManager.getString('analytics', 'curPrevYear'):
					// actually gives from the 1/1 of last year to yesterday
					filterVo.fromDate = new Date(today.fullYear - 1, 0, 1);
					filterVo.toDate = new Date((todayStart - TimeConsts.DAY + today.timezoneOffset * 60000 - SECOND_IN_MILI) + TimeConsts.DAY);
					break;

				case resourceManager.getString('analytics', 'prevYear'):
					filterVo.fromDate = new Date(today.fullYear - 1, 0, 1);
					filterVo.toDate = new Date(today.fullYear - 1, 11, 1);
					break;

				default:
					break;
			}

			latestFromDate = filterVo.fromDate;
			latestToDate = filterVo.toDate;
		}


		public function changeRangeByDate(filterVo:FilterVo):int {
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var curDate:Date = new Date();
			var todaysHourInMiliSeconds:Number = (((curDate.hoursUTC) * 60 + curDate.minutesUTC) * 60 + curDate.secondsUTC) * 1000 + curDate.millisecondsUTC;
			var today:Date = new Date(Number(curDate.time - todaysHourInMiliSeconds - TimeConsts.DAY));
			var result:String = ''; // the required string

			if (filterVo.fromDate.fullYear == today.fullYear && filterVo.fromDate.month == 0 && filterVo.fromDate.date == 1 && filterVo.toDate.fullYear == today.fullYear && filterVo.toDate.month == today.month && filterVo.toDate.date == today.date) {

				result = resourceManager.getString('analytics', 'curYear');
			}
			else if (filterVo.fromDate.fullYear == today.fullYear && filterVo.fromDate.month == today.month && filterVo.fromDate.date == 1 && filterVo.toDate.fullYear == today.fullYear && filterVo.toDate.month == today.month && filterVo.toDate.date == today.date) {

				result = resourceManager.getString('analytics', 'curMonth');
			}
			else if (filterVo.fromDate.fullYear == today.fullYear && filterVo.fromDate.month == today.month - 1 && filterVo.fromDate.date == 1 && filterVo.toDate.fullYear == today.fullYear && filterVo.toDate.month == today.month && filterVo.toDate.date == today.date) {

				result = resourceManager.getString('analytics', 'curPrevMonth');
			}
			else if (filterVo.fromDate.fullYear == today.fullYear && filterVo.fromDate.month == today.month - 1 && filterVo.fromDate.date == 1 && filterVo.toDate.fullYear == today.fullYear && filterVo.toDate.month == today.month - 1 && filterVo.toDate.date == getLastDayOfMonth(today.month - 1)) {

				result = resourceManager.getString('analytics', 'prevMonth');
			}
			else if (filterVo.fromDate.fullYear == today.fullYear && filterVo.fromDate.month == getFirstMonthOfQtr(today.month) && filterVo.fromDate.date == 1 && filterVo.toDate.fullYear == today.fullYear && filterVo.toDate.month == today.month && filterVo.toDate.date == today.date) {
				result = resourceManager.getString('analytics', 'curQtr');
			}
			else if (filterVo.fromDate.fullYear == today.fullYear && filterVo.fromDate.month == getFirstMonthOfQtr(today.month - 3) && filterVo.fromDate.date == 1 && filterVo.toDate.fullYear == today.fullYear && filterVo.toDate.month == today.month && filterVo.toDate.date == today.date) {

				result = resourceManager.getString('analytics', 'curPrevQtr');
			}
			else if (filterVo.fromDate.fullYear == today.fullYear && filterVo.fromDate.month == getFirstMonthOfQtr(today.month - 3) && filterVo.fromDate.date == 1 && filterVo.toDate.fullYear == today.fullYear && filterVo.toDate.month == getLastMonthOfQtr(today.month - 3) && filterVo.toDate.date == getLastDayOfMonth(filterVo.toDate.month)) {

				result = resourceManager.getString('analytics', 'prevQtr');
			}
			else if (filterVo.fromDate.fullYear == today.fullYear - 1 && filterVo.fromDate.month == 0 && filterVo.fromDate.date == 1 && filterVo.toDate.fullYear == today.fullYear && filterVo.toDate.month == today.month && filterVo.toDate.date == today.date) {

				result = resourceManager.getString('analytics', 'curPrevYear');
			}
			else if (filterVo.fromDate.fullYear == today.fullYear - 1 && filterVo.fromDate.month == 0 && filterVo.fromDate.date == 1 && filterVo.toDate.fullYear == today.fullYear - 1 && filterVo.toDate.month == 11 && filterVo.toDate.date == 31) {
				result = resourceManager.getString('analytics', 'prevYear')
			}
			else {
				result = resourceManager.getString('analytics', 'custom');
			}

			latestSelected = result;

			return ArrayUtil.getItemIndex(result, _dateRange);
		}


		/**
		 * get the last date of the month (28, 30, 31)
		 * @param monthIndex (0-11)
		 * @return 0-based last day of the given month
		 */
		private function getLastDayOfMonth(monthIndex:int):int {
			switch (monthIndex) {
				case 0: // jan
				case 2: // mar
				case 4: // may
				case 6: // jul
				case 7: // aug
				case 9: // oct
				case 11: // dec
					return 31;
					break;
				case 1: // feb
					return 28;
					break;
				case 3: // apr
				case 5: // jun
				case 8: // sep
				case 10: // nov
					return 30;
					break;
				default:
					return -1;
			}
		}


		/**
		 *
		 * @param monthIndex (0-11)
		 * @return 0-based first month of qtr containing given month
		 */
		private function getFirstMonthOfQtr(monthIndex:int):int {
			if (monthIndex < 3) {
				// 1st qtr
				return 0;
			}
			else if (monthIndex < 6) {
				// 2nd qtr
				return 3;
			}
			else if (monthIndex < 9) {
				// 3rd qtr
				return 6;
			}

			// else, 4th qtr
			return 9;

		}


		/**
		 *
		 * @param monthIndex (0-11)
		 * @return 0-based last month of qtr containing given month
		 */
		private function getLastMonthOfQtr(monthIndex:int):int {
			if (monthIndex < 3) {
				// 1st qtr
				return 2;
			}
			else if (monthIndex < 6) {
				// 2nd qtr
				return 5;
			}
			else if (monthIndex < 9) {
				// 3rd qtr
				return 8;
			}

			// else, 4th qtr
			return 11;

		}
	}
}
