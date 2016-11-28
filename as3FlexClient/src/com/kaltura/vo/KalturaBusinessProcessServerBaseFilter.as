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

	[Bindable]
	public dynamic class KalturaBusinessProcessServerBaseFilter extends KalturaFilter
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

		/**
		**/
		public var partnerIdEqual : int = int.MIN_VALUE;

		/**
		**/
		public var partnerIdIn : String = null;

		/**
		* @see com.kaltura.types.KalturaBusinessProcessServerStatus
		**/
		public var statusEqual : String = null;

		/**
		* @see com.kaltura.types.KalturaBusinessProcessServerStatus
		**/
		public var statusNotEqual : String = null;

		/**
		**/
		public var statusIn : String = null;

		/**
		**/
		public var statusNotIn : String = null;

		/**
		* @see com.kaltura.types.KalturaBusinessProcessProvider
		**/
		public var typeEqual : String = null;

		/**
		**/
		public var typeIn : String = null;

		/**
		**/
		public var dcEqual : int = int.MIN_VALUE;

		/**
		**/
		public var dcEqOrNull : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('idEqual');
			arr.push('idIn');
			arr.push('idNotIn');
			arr.push('createdAtGreaterThanOrEqual');
			arr.push('createdAtLessThanOrEqual');
			arr.push('updatedAtGreaterThanOrEqual');
			arr.push('updatedAtLessThanOrEqual');
			arr.push('partnerIdEqual');
			arr.push('partnerIdIn');
			arr.push('statusEqual');
			arr.push('statusNotEqual');
			arr.push('statusIn');
			arr.push('statusNotIn');
			arr.push('typeEqual');
			arr.push('typeIn');
			arr.push('dcEqual');
			arr.push('dcEqOrNull');
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
