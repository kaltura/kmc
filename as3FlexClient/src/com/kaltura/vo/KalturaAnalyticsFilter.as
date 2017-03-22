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
	public dynamic class KalturaAnalyticsFilter extends BaseFlexVo
	{
		/**
		* Query start time (in local time) MM/dd/yyyy HH:mi
		**/
		public var from_time : String = null;

		/**
		* Query end time (in local time) MM/dd/yyyy HH:mi
		**/
		public var to_time : String = null;

		/**
		* Comma separated metrics list
		**/
		public var metrics : String = null;

		/**
		* Timezone offset from UTC (in minutes)
		**/
		public var utcOffset : Number = Number.NEGATIVE_INFINITY;

		/**
		* Comma separated dimensions list
		**/
		public var dimensions : String = null;

		/**
		* Array of filters
		**/
		public var filters : Array = null;

		/**
		* Query order by metric/dimension
		**/
		public var orderBy : String = null;

		/** 
		* a list of attributes which may be updated on this object 
		**/ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('from_time');
			arr.push('to_time');
			arr.push('metrics');
			arr.push('utcOffset');
			arr.push('dimensions');
			arr.push('filters');
			arr.push('orderBy');
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
				case 'filters':
					result = 'KalturaReportFilter';
					break;
			}
			return result;
		}
	}
}
