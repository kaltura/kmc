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
	import com.kaltura.vo.KalturaFilter;

	import com.kaltura.vo.BaseFlexVo;

	[Bindable]
	public dynamic class KalturaScheduledTaskProfile extends BaseFlexVo
	{
		/**
		**/
		public var id : int = int.MIN_VALUE;

		/**
		**/
		public var partnerId : int = int.MIN_VALUE;

		/**
		**/
		public var name : String = null;

		/**
		**/
		public var systemName : String = null;

		/**
		**/
		public var description : String = null;

		/**
		* @see com.kaltura.types.KalturaScheduledTaskProfileStatus
		**/
		public var status : int = int.MIN_VALUE;

		/**
		* The type of engine to use to list objects using the given "objectFilter"
		* @see com.kaltura.types.KalturaObjectFilterEngineType
		**/
		public var objectFilterEngineType : String = null;

		/**
		* A filter object (inherits KalturaFilter) that is used to list objects for scheduled tasks
		**/
		public var objectFilter : KalturaFilter;

		/**
		* A list of tasks to execute on the founded objects
		**/
		public var objectTasks : Array = null;

		/**
		**/
		public var createdAt : int = int.MIN_VALUE;

		/**
		**/
		public var updatedAt : int = int.MIN_VALUE;

		/**
		**/
		public var lastExecutionStartedAt : int = int.MIN_VALUE;

		/**
		* The maximum number of result count allowed to be processed by this profile per execution
		**/
		public var maxTotalCountAllowed : int = int.MIN_VALUE;

		/** 
		* a list of attributes which may be updated on this object 
		**/ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('name');
			arr.push('systemName');
			arr.push('description');
			arr.push('status');
			arr.push('objectFilterEngineType');
			arr.push('objectFilter');
			arr.push('objectTasks');
			arr.push('lastExecutionStartedAt');
			arr.push('maxTotalCountAllowed');
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
				case 'objectFilter':
					result = '';
					break;
				case 'objectTasks':
					result = 'KalturaObjectTask';
					break;
			}
			return result;
		}
	}
}
