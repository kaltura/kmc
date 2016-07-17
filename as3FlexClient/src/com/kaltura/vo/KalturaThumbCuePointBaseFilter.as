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
	import com.kaltura.vo.KalturaCuePointFilter;

	[Bindable]
	public dynamic class KalturaThumbCuePointBaseFilter extends KalturaCuePointFilter
	{
		/**
		**/
		public var descriptionLike : String = null;

		/**
		**/
		public var descriptionMultiLikeOr : String = null;

		/**
		**/
		public var descriptionMultiLikeAnd : String = null;

		/**
		**/
		public var titleLike : String = null;

		/**
		**/
		public var titleMultiLikeOr : String = null;

		/**
		**/
		public var titleMultiLikeAnd : String = null;

		/**
		* @see com.kaltura.types.KalturaThumbCuePointSubType
		**/
		public var subTypeEqual : int = int.MIN_VALUE;

		/**
		**/
		public var subTypeIn : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('descriptionLike');
			arr.push('descriptionMultiLikeOr');
			arr.push('descriptionMultiLikeAnd');
			arr.push('titleLike');
			arr.push('titleMultiLikeOr');
			arr.push('titleMultiLikeAnd');
			arr.push('subTypeEqual');
			arr.push('subTypeIn');
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
