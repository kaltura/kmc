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
	public dynamic class KalturaHttpNotification extends BaseFlexVo
	{
		/**
		* Object that triggered the notification
		**/
		public var object : BaseFlexVo;

		/**
		* Object type that triggered the notification
		* @see com.kaltura.types.KalturaEventNotificationEventObjectType
		**/
		public var eventObjectType : String = null;

		/**
		* ID of the batch job that execute the notification
		**/
		public var eventNotificationJobId : Number = Number.NEGATIVE_INFINITY;

		/**
		* ID of the template that triggered the notification
		**/
		public var templateId : int = int.MIN_VALUE;

		/**
		* Name of the template that triggered the notification
		**/
		public var templateName : String = null;

		/**
		* System name of the template that triggered the notification
		**/
		public var templateSystemName : String = null;

		/**
		* Ecent type that triggered the notification
		* @see com.kaltura.types.KalturaEventNotificationEventType
		**/
		public var eventType : String = null;

		/** 
		* a list of attributes which may be updated on this object 
		**/ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('object');
			arr.push('eventObjectType');
			arr.push('eventNotificationJobId');
			arr.push('templateId');
			arr.push('templateName');
			arr.push('templateSystemName');
			arr.push('eventType');
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
				case 'object':
					result = '';
					break;
			}
			return result;
		}
	}
}
