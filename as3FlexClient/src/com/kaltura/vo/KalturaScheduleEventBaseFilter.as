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
	import com.kaltura.vo.KalturaRelatedFilter;

	[Bindable]
	public dynamic class KalturaScheduleEventBaseFilter extends KalturaRelatedFilter
	{
		/**
		**/
		public var idEqual : int = int.MIN_VALUE;

		/**
		**/
		public var idIn : String = null;

		/**
		**/
		public var idNotIn : String = null;

		/**
		**/
		public var parentIdEqual : int = int.MIN_VALUE;

		/**
		**/
		public var parentIdIn : String = null;

		/**
		**/
		public var parentIdNotIn : String = null;

		/**
		* @see com.kaltura.types.KalturaScheduleEventStatus
		**/
		public var statusEqual : int = int.MIN_VALUE;

		/**
		**/
		public var statusIn : String = null;

		/**
		**/
		public var startDateGreaterThanOrEqual : int = int.MIN_VALUE;

		/**
		**/
		public var startDateLessThanOrEqual : int = int.MIN_VALUE;

		/**
		**/
		public var endDateGreaterThanOrEqual : int = int.MIN_VALUE;

		/**
		**/
		public var endDateLessThanOrEqual : int = int.MIN_VALUE;

		/**
		**/
		public var referenceIdEqual : String = null;

		/**
		**/
		public var referenceIdIn : String = null;

		/**
		**/
		public var ownerIdEqual : String = null;

		/**
		**/
		public var ownerIdIn : String = null;

		/**
		**/
		public var priorityEqual : int = int.MIN_VALUE;

		/**
		**/
		public var priorityIn : String = null;

		/**
		**/
		public var priorityGreaterThanOrEqual : int = int.MIN_VALUE;

		/**
		**/
		public var priorityLessThanOrEqual : int = int.MIN_VALUE;

		/**
		* @see com.kaltura.types.KalturaScheduleEventRecurrenceType
		**/
		public var recurrenceTypeEqual : int = int.MIN_VALUE;

		/**
		**/
		public var recurrenceTypeIn : String = null;

		/**
		**/
		public var tagsLike : String = null;

		/**
		**/
		public var tagsMultiLikeOr : String = null;

		/**
		**/
		public var tagsMultiLikeAnd : String = null;

		/**
		**/
		public var createdAtGreaterThanOrEqual : int = int.MIN_VALUE;

		/**
		**/
		public var createdAtLessThanOrEqual : int = int.MIN_VALUE;

		/**
		**/
		public var updatedAtGreaterThanOrEqual : int = int.MIN_VALUE;

		/**
		**/
		public var updatedAtLessThanOrEqual : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('idEqual');
			arr.push('idIn');
			arr.push('idNotIn');
			arr.push('parentIdEqual');
			arr.push('parentIdIn');
			arr.push('parentIdNotIn');
			arr.push('statusEqual');
			arr.push('statusIn');
			arr.push('startDateGreaterThanOrEqual');
			arr.push('startDateLessThanOrEqual');
			arr.push('endDateGreaterThanOrEqual');
			arr.push('endDateLessThanOrEqual');
			arr.push('referenceIdEqual');
			arr.push('referenceIdIn');
			arr.push('ownerIdEqual');
			arr.push('ownerIdIn');
			arr.push('priorityEqual');
			arr.push('priorityIn');
			arr.push('priorityGreaterThanOrEqual');
			arr.push('priorityLessThanOrEqual');
			arr.push('recurrenceTypeEqual');
			arr.push('recurrenceTypeIn');
			arr.push('tagsLike');
			arr.push('tagsMultiLikeOr');
			arr.push('tagsMultiLikeAnd');
			arr.push('createdAtGreaterThanOrEqual');
			arr.push('createdAtLessThanOrEqual');
			arr.push('updatedAtGreaterThanOrEqual');
			arr.push('updatedAtLessThanOrEqual');
			return arr;
		}

		override public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = super.getInsertableParamKeys();
			return arr;
		}

		override public function getElementType(arrayName:String):String
		{
			var result:String = '';
			switch (arrayName) {
				default:
					result = super.getElementType(arrayName);
					break;
			}
			return result;
		}
	}
}
