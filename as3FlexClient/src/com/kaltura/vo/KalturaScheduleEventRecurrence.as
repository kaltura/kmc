// ===================================================================================================
//                           _  __     _ _
//                          | |/ /__ _| | |_ _  _ _ _ __ _
//                          | ' </ _` | |  _| || | '_/ _` |
//                          |_|\_\__,_|_|\__|\_,_|_| \__,_|
//
// This file is part of the Kaltura Collaborative Media Suite which allows users
// to do with audio, video, and animation what Wiki platfroms allow them to do with
// text.
//
// Copyright (C) 2006-2016  Kaltura Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// @ignore
// ===================================================================================================
package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;

	[Bindable]
	public dynamic class KalturaScheduleEventRecurrence extends BaseFlexVo
	{
		/**
		**/
		public var name : String = null;

		/**
		* @see com.kaltura.types.KalturaScheduleEventRecurrenceFrequency
		**/
		public var frequency : String = null;

		/**
		**/
		public var until : int = int.MIN_VALUE;

		/**
		* TimeZone String
		**/
		public var timeZone : String = null;

		/**
		**/
		public var count : int = int.MIN_VALUE;

		/**
		**/
		public var interval : int = int.MIN_VALUE;

		/**
		* Comma separated numbers between 0 to 59
		**/
		public var bySecond : String = null;

		/**
		* Comma separated numbers between 0 to 59
		**/
		public var byMinute : String = null;

		/**
		* Comma separated numbers between 0 to 23
		**/
		public var byHour : String = null;

		/**
		* Comma separated of KalturaScheduleEventRecurrenceDay
		* Each byDay value can also be preceded by a positive (+n) or negative (-n) integer.
		* If present, this indicates the nth occurrence of the specific day within the MONTHLY or YEARLY RRULE.
		* For example, within a MONTHLY rule, +1MO (or simply 1MO) represents the first Monday within the month, whereas -1MO represents the last Monday of the month.
		* If an integer modifier is not present, it means all days of this type within the specified frequency.
		* For example, within a MONTHLY rule, MO represents all Mondays within the month.
		**/
		public var byDay : String = null;

		/**
		* Comma separated of numbers between -31 to 31, excluding 0.
		* For example, -10 represents the tenth to the last day of the month.
		**/
		public var byMonthDay : String = null;

		/**
		* Comma separated of numbers between -366 to 366, excluding 0.
		* For example, -1 represents the last day of the year (December 31st) and -306 represents the 306th to the last day of the year (March 1st).
		**/
		public var byYearDay : String = null;

		/**
		* Comma separated of numbers between -53 to 53, excluding 0.
		* This corresponds to weeks according to week numbering.
		* A week is defined as a seven day period, starting on the day of the week defined to be the week start.
		* Week number one of the calendar year is the first week which contains at least four (4) days in that calendar year.
		* This rule part is only valid for YEARLY frequency.
		* For example, 3 represents the third week of the year.
		**/
		public var byWeekNumber : String = null;

		/**
		* Comma separated numbers between 1 to 12
		**/
		public var byMonth : String = null;

		/**
		* Comma separated of numbers between -366 to 366, excluding 0.
		* Corresponds to the nth occurrence within the set of events specified by the rule.
		* It must only be used in conjunction with another byrule part.
		* For example "the last work day of the month" could be represented as: frequency=MONTHLY;byDay=MO,TU,WE,TH,FR;byOffset=-1
		* Each byOffset value can include a positive (+n) or negative (-n) integer.
		* If present, this indicates the nth occurrence of the specific occurrence within the set of events specified by the rule.
		**/
		public var byOffset : String = null;

		/**
		* @see com.kaltura.types.KalturaScheduleEventRecurrenceDay
		**/
		public var weekStartDay : String = null;

		/** 
		* a list of attributes which may be updated on this object 
		**/ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('name');
			arr.push('frequency');
			arr.push('until');
			arr.push('timeZone');
			arr.push('count');
			arr.push('interval');
			arr.push('bySecond');
			arr.push('byMinute');
			arr.push('byHour');
			arr.push('byDay');
			arr.push('byMonthDay');
			arr.push('byYearDay');
			arr.push('byWeekNumber');
			arr.push('byMonth');
			arr.push('byOffset');
			arr.push('weekStartDay');
			return arr;
		}

		/** 
		* a list of attributes which may only be inserted when initializing this object 
		**/ 
		public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}

		/** 
		* get the expected type of array elements 
		* @param arrayName 	 name of an attribute of type array of the current object 
		* @return 	 un-qualified class name 
		**/ 
		public function getElementType(arrayName:String):String
		{
			var result:String = '';
			switch (arrayName) {
			}
			return result;
		}
	}
}
