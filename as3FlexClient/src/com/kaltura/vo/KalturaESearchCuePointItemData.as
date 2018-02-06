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
// Copyright (C) 2006-2017  Kaltura Inc.
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
	import com.kaltura.vo.KalturaESearchItemData;

	[Bindable]
	public dynamic class KalturaESearchCuePointItemData extends KalturaESearchItemData
	{
		/**
		**/
		public var cuePointType : String = null;

		/**
		**/
		public var id : String = null;

		/**
		**/
		public var name : String = null;

		/**
		**/
		public var text : String = null;

		/**
		**/
		public var tags : Array = null;

		/**
		**/
		public var startTime : String = null;

		/**
		**/
		public var endTime : String = null;

		/**
		**/
		public var subType : String = null;

		/**
		**/
		public var question : String = null;

		/**
		**/
		public var answers : Array = null;

		/**
		**/
		public var hint : String = null;

		/**
		**/
		public var explanation : String = null;

		/**
		**/
		public var assetId : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('cuePointType');
			arr.push('id');
			arr.push('name');
			arr.push('text');
			arr.push('tags');
			arr.push('startTime');
			arr.push('endTime');
			arr.push('subType');
			arr.push('question');
			arr.push('answers');
			arr.push('hint');
			arr.push('explanation');
			arr.push('assetId');
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
				case 'tags':
					result = 'KalturaString';
					break;
				case 'answers':
					result = 'KalturaString';
					break;
				default:
					result = super.getElementType(arrayName);
					break;
			}
			return result;
		}
	}
}
