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
	import com.kaltura.vo.KalturaScheduleEventRecurrence;

	import com.kaltura.vo.BaseFlexVo;

	[Bindable]
	public dynamic class KalturaScheduleEvent extends BaseFlexVo
	{
		/**
		* Auto-generated unique identifier
		**/
		public var id : int = int.MIN_VALUE;

		/**
		**/
		public var partnerId : int = int.MIN_VALUE;

		/**
		**/
		public var parentId : int = int.MIN_VALUE;

		/**
		* Defines a short summary or subject for the event
		**/
		public var summary : String = null;

		/**
		**/
		public var description : String = null;

		/**
		* @see com.kaltura.types.KalturaScheduleEventStatus
		**/
		public var status : int = int.MIN_VALUE;

		/**
		**/
		public var startDate : int = int.MIN_VALUE;

		/**
		**/
		public var endDate : int = int.MIN_VALUE;

		/**
		**/
		public var referenceId : String = null;

		/**
		* @see com.kaltura.types.KalturaScheduleEventClassificationType
		**/
		public var classificationType : int = int.MIN_VALUE;

		/**
		* Specifies the global position for the activity
		**/
		public var geoLatitude : Number = Number.NEGATIVE_INFINITY;

		/**
		* Specifies the global position for the activity
		**/
		public var geoLongitude : Number = Number.NEGATIVE_INFINITY;

		/**
		* Defines the intended venue for the activity
		**/
		public var location : String = null;

		/**
		**/
		public var organizer : String = null;

		/**
		**/
		public var ownerId : String = null;

		/**
		* The value for the priority field.
		**/
		public var priority : int = int.MIN_VALUE;

		/**
		* Defines the revision sequence number.
		**/
		public var sequence : int = int.MIN_VALUE;

		/**
		* @see com.kaltura.types.KalturaScheduleEventRecurrenceType
		**/
		public var recurrenceType : int = int.MIN_VALUE;

		/**
		* Duration in seconds
		**/
		public var duration : int = int.MIN_VALUE;

		/**
		* Used to represent contact information or alternately a reference to contact information.
		**/
		public var contact : String = null;

		/**
		* Specifies non-processing information intended to provide a comment to the calendar user.
		**/
		public var comment : String = null;

		/**
		**/
		public var tags : String = null;

		/**
		* Creation date as Unix timestamp (In seconds)
		**/
		public var createdAt : int = int.MIN_VALUE;

		/**
		* Last update as Unix timestamp (In seconds)
		**/
		public var updatedAt : int = int.MIN_VALUE;

		/**
		**/
		public var recurrence : KalturaScheduleEventRecurrence;

		/** 
		* a list of attributes which may be updated on this object 
		**/ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('summary');
			arr.push('description');
			arr.push('startDate');
			arr.push('endDate');
			arr.push('referenceId');
			arr.push('classificationType');
			arr.push('geoLatitude');
			arr.push('geoLongitude');
			arr.push('location');
			arr.push('organizer');
			arr.push('ownerId');
			arr.push('priority');
			arr.push('sequence');
			arr.push('recurrenceType');
			arr.push('duration');
			arr.push('contact');
			arr.push('comment');
			arr.push('tags');
			arr.push('recurrence');
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
				case 'recurrence':
					result = '';
					break;
			}
			return result;
		}
	}
}
