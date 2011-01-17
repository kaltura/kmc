package com.kaltura.utils
{
	import com.kaltura.controls.SM_TimeEntry;
	
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.resources.ResourceManager;

	/**
	 * This class holds a few methods to handle dateField+TimeEntry start time and end time logic 
	 * @author Michal
	 * 
	 */	
	public class DateFieldWithTimeStepperLogic
	{
		private var _startDateField:DateField;
		private var _endDateField:DateField;
		private var _oldStartDate:Date;
		private var _oldEndDate:Date;
		private var _startDateHour:SM_TimeEntry;
		private var _endDateHour:SM_TimeEntry;
		
		/**
		 * Constructs a new DateFieldWithTimeStepperLogic 
		 * @param startDateField start date dateField
		 * @param endDateField end date dateField
		 * @param startDateHour startDate hour
		 * @param endDateHour endDate hour
		 * 
		 */		
		public function DateFieldWithTimeStepperLogic(startDateField:DateField, endDateField:DateField, 
													  startDateHour:SM_TimeEntry, endDateHour:SM_TimeEntry)
		{
			_startDateField = startDateField;
			_endDateField = endDateField;
			_startDateHour = startDateHour;
			_endDateHour = endDateHour;
		}
		
		/**
		 * validates the start and end values, if values are valid, saves
		 * the values in "oldStartDate" and "oldEndDate" 
		 * 
		 */		
		public function validateTimes():void {
			
			var sDate:Date = _startDateField.selectedDate;
			var eDate:Date = _endDateField.selectedDate;
			
			if ((sDate == null) || (eDate == null)) {
				return;
			}
			
			if (eDate.time < sDate.time) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'startToEndDateAlert'));
				_endDateField.selectedDate = _oldEndDate;
				_startDateField.selectedDate = _oldStartDate;
				_endDateField.validateNow();
				checkTime();
			}
			else if (eDate.time == sDate.time) {
				checkTime();
			}
			else {
				_oldStartDate = new Date(sDate.time);
				_oldEndDate = new Date(eDate.time);
			}
		}
		
		private function checkTime():void {
			var sTimeObj:Object = _startDateHour.timeValue;
			var sTime:Number = calculateTime(sTimeObj, _startDateHour.am_pm);
			var eTimeObj:Object = _endDateHour.timeValue;
			var eTime:Number = calculateTime(eTimeObj, _endDateHour.am_pm);
			
			if (eTime <= sTime) {
				_endDateHour.hour = _startDateHour.hour;
				_endDateHour.minute = _startDateHour.minute;
				_endDateHour.am_pm = _startDateHour.am_pm;
			}
		}
		
		/**
		 * returns the time of the given timeObj 
		 * @param timeObj the object to calculate the time from
		 * @param am_pmIndicator indicates if its am or pm
		 * @return the time of the given timeObj 
		 * 
		 */		
		public function calculateTime(timeObj:Object, am_pmIndicator:String):Number {
			var isPM:Boolean = am_pmIndicator == 'pm';
			var dayHour:Number = isPM ? timeObj.hour : (timeObj.hour % 12);
			var hours:Number = dayHour * 60 * 60;
			var minute:Number = timeObj.minute * 60;
			var seconds:Number = timeObj.second;
			var addition:Number = isPM && (timeObj.hour != 12) ? (12 * 60 * 60) : 0;
			
			var totalTime:Number = hours + minute + seconds + addition;
			
			return totalTime;
		}
		
		/**
		 * Sets the given values as the time in the given timeEntry. sets AM/PM accordingly 
		 * @param timeEntry the timeEntry to set
		 * @param hours the given hours
		 * @param minutes the given minutes
		 * 
		 */		
		public function setTime(timeEntry:SM_TimeEntry, hours:int, minutes:int):void {
			timeEntry.minute = minutes;
			timeEntry.am_pm = hours >= 12 ? 'pm' : 'am'
			timeEntry.hour = hours % 12;
			if (timeEntry.hour == 0) {
				timeEntry.hour = 12;
			}
		}

	}
}