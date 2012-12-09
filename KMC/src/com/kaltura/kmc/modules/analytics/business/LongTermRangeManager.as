package com.kaltura.kmc.modules.analytics.business {
	import com.kaltura.kmc.modules.analytics.utils.TimeConsts;
	import com.kaltura.kmc.modules.analytics.vo.FilterVo;
	
	import mx.controls.ComboBox;
	import mx.events.ListEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.ArrayUtil;
	import com.kaltura.kmc.vo.LocalizedVo;

	public class LongTermRangeManager implements IDateRangeManager {

		private static const SECOND_IN_MILI:Number = 1000;

		private var _dateRange:Array;
		private var _latestToDate:Date;
		private var _latestFromDate:Date;
		private var _latestSelected:Object;




		public function LongTermRangeManager() {
			_dateRange = [
				new LocalizedVo('curYear', 'curYear', 'analytics'),
				new LocalizedVo('curMonth', 'curMonth', 'analytics'),
				new LocalizedVo('curPrevMonth', 'curPrevMonth', 'analytics'),
				new LocalizedVo('prevMonth', 'prevMonth', 'analytics'),
				new LocalizedVo('curQtr', 'curQtr', 'analytics'),
				new LocalizedVo('curPrevQtr', 'curPrevQtr', 'analytics'),
				new LocalizedVo('prevQtr', 'prevQtr', 'analytics'),
				new LocalizedVo('curPrevYear', 'curPrevYear', 'analytics'),
				new LocalizedVo('prevYear', 'prevYear', 'analytics'),
				new LocalizedVo('custom', 'custom', 'analytics'),
				];
				/*resourceManager.getString('analytics', 'curYear'),	//Current year (default)
				resourceManager.getString('analytics', 'curMonth'),				//Current month
				resourceManager.getString('analytics', 'curPrevMonth'),			//Current and previous month
				resourceManager.getString('analytics', 'prevMonth'),			//Previous month
				resourceManager.getString('analytics', 'curQtr'),				//Current quarter
				resourceManager.getString('analytics', 'curPrevQtr'),			//Current and previous quarter
				resourceManager.getString('analytics', 'prevQtr'),				//Previous quarter
				resourceManager.getString('analytics', 'curPrevYear'),			//Current and previous year
				resourceManager.getString('analytics', 'prevYear'),				//Previous year
				resourceManager.getString('analytics', 'custom')				//Custom
			];*/
			var today:Date = new Date();
			
			_latestSelected = _dateRange[1];
			_latestFromDate = new Date(today.fullYear, today.month, 1);
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

		public function get dateRange():Array {
			return _dateRange;
		}


		public function set dateRange(value:Array):void {
			_dateRange = value;
		}


		public function changeDateByRange(event:ListEvent, filterVo:FilterVo):void {
			
			var today:Date = new Date();
			var todaysHourInMiliSeconds:Number = (((today.hoursUTC) * 60 + today.minutesUTC) * 60 + today.secondsUTC) * 1000 + today.millisecondsUTC;
			var todayStart:Number = today.time - todaysHourInMiliSeconds;

			latestSelected = (event.target as ComboBox).selectedItem;

			switch ((event.target as ComboBox).selectedItem.value) {
				case 'curYear':
					// actually gives from the 1/1 of current year to today
					filterVo.fromDate = new Date(today.fullYear, 0, 1);
					filterVo.toDate = today;
					break;

				case 'curMonth':
					// actually gives first day of the month until today
					filterVo.fromDate = new Date(today.fullYear, today.month, 1);
					filterVo.toDate = today;
					
					break;

				case 'curPrevMonth':
					if (today.month == 0) {
						// wer'e in january, get last december 
						filterVo.fromDate = new Date(today.fullYear - 1, 11, 1);
					}
					else {
						// first of last month
						filterVo.fromDate = new Date(today.fullYear, today.month - 1, 1);
					}

					filterVo.toDate = today;
					break;

				case 'prevMonth':
					if (today.month == 0) {
						// wer'e in january, get last december 
						filterVo.fromDate = new Date(today.fullYear - 1, 11, 1);
						filterVo.toDate = new Date(today.fullYear - 1, 11, 31);
					}
					else {
						// first of last month
						filterVo.fromDate = new Date(today.fullYear, today.month - 1, 1);
						filterVo.toDate = new Date(today.fullYear, today.month - 1, getLastDayOfMonth(today.month - 1));
					}
					break;

				case 'curQtr':
					filterVo.fromDate = new Date(today.fullYear, getFirstMonthOfQtr(today.month), 1);
					filterVo.toDate = today;
					break;

				case 'curPrevQtr':
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

					filterVo.toDate = today;
					break;

				case 'prevQtr':
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

				case 'curPrevYear':
					// actually gives from the 1/1 of last year to yesterday
					filterVo.fromDate = new Date(today.fullYear - 1, 0, 1);
					filterVo.toDate = today;
					break;

				case 'prevYear':
					filterVo.fromDate = new Date(today.fullYear - 1, 0, 1);
					filterVo.toDate = new Date(today.fullYear - 1, 11, 31);
					break;

				default:
					break;
			}

			latestFromDate = filterVo.fromDate;
			latestToDate = filterVo.toDate;
		}


		public function changeRangeByDate(filterVo:FilterVo):int {
			var today:Date = new Date();
			
			var fromDate:Date = filterVo.fromDate;
			var toDate:Date = filterVo.toDate;
			
			var result:String = ''; // the required string

			if (fromDate.fullYear == today.fullYear && fromDate.month == 0 && fromDate.date == 1
				&& toDate.fullYear == today.fullYear && toDate.month == today.month && toDate.date == today.date) {

				result = 'curYear';
			}
			else if (fromDate.fullYear == today.fullYear && fromDate.month == today.month 
				&& fromDate.date == 1 && toDate.fullYear == today.fullYear && toDate.month == today.month && toDate.date == today.date) {

				result = 'curMonth';
			}
			else if (fromDate.fullYear == today.fullYear && fromDate.month == today.month - 1 
				&& fromDate.date == 1 && toDate.fullYear == today.fullYear && toDate.month == today.month && toDate.date == today.date) {

				result = 'curPrevMonth';
			}
			else if (fromDate.fullYear == today.fullYear && fromDate.month == today.month - 1 
				&& fromDate.date == 1 && toDate.fullYear == today.fullYear && toDate.month == today.month - 1 
				&& toDate.date == getLastDayOfMonth(today.month - 1)) {

				result = 'prevMonth';
			}
			else if (fromDate.fullYear == today.fullYear && fromDate.month == getFirstMonthOfQtr(today.month) 
				&& fromDate.date == 1 && toDate.fullYear == today.fullYear && toDate.month == today.month && toDate.date == today.date) {
				result = 'curQtr';
			}
			else if (fromDate.fullYear == today.fullYear && fromDate.month == getFirstMonthOfQtr(today.month - 3)
				&& fromDate.date == 1 && toDate.fullYear == today.fullYear && toDate.month == today.month && toDate.date == today.date) {

				result = 'curPrevQtr';
			}
			else if (fromDate.fullYear == today.fullYear && fromDate.month == getFirstMonthOfQtr(today.month - 3) 
				&& fromDate.date == 1 && toDate.fullYear == today.fullYear && toDate.month == getLastMonthOfQtr(today.month - 3) 
				&& toDate.date == getLastDayOfMonth(toDate.month)) {

				result = 'prevQtr';
			}
			else if (fromDate.fullYear == today.fullYear - 1 && fromDate.month == 0 && fromDate.date == 1 
				&& toDate.fullYear == today.fullYear && toDate.month == today.month && toDate.date == today.date) {

				result = 'curPrevYear';
			}
			else if (fromDate.fullYear == today.fullYear - 1 && fromDate.month == 0 && fromDate.date == 1 
				&& toDate.fullYear == today.fullYear - 1 && toDate.month == 11 && toDate.date == 31) {
				result = 'prevYear';
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
