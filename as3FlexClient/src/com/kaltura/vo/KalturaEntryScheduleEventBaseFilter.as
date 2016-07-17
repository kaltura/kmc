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
	import com.kaltura.vo.KalturaScheduleEventFilter;

	[Bindable]
	public dynamic class KalturaEntryScheduleEventBaseFilter extends KalturaScheduleEventFilter
	{
		/**
		**/
		public var templateEntryIdEqual : String = null;

		/**
		**/
		public var entryIdsLike : String = null;

		/**
		**/
		public var entryIdsMultiLikeOr : String = null;

		/**
		**/
		public var entryIdsMultiLikeAnd : String = null;

		/**
		**/
		public var categoryIdsLike : String = null;

		/**
		**/
		public var categoryIdsMultiLikeOr : String = null;

		/**
		**/
		public var categoryIdsMultiLikeAnd : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('templateEntryIdEqual');
			arr.push('entryIdsLike');
			arr.push('entryIdsMultiLikeOr');
			arr.push('entryIdsMultiLikeAnd');
			arr.push('categoryIdsLike');
			arr.push('categoryIdsMultiLikeOr');
			arr.push('categoryIdsMultiLikeAnd');
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
