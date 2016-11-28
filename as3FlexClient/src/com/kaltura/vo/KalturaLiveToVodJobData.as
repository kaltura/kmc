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
	import com.kaltura.vo.KalturaJobData;

	[Bindable]
	public dynamic class KalturaLiveToVodJobData extends KalturaJobData
	{
		/**
		* $vod Entry Id
		**/
		public var vodEntryId : String = null;

		/**
		* live Entry Id
		**/
		public var liveEntryId : String = null;

		/**
		* total VOD Duration
		**/
		public var totalVodDuration : Number = Number.NEGATIVE_INFINITY;

		/**
		* last Segment Duration
		**/
		public var lastSegmentDuration : Number = Number.NEGATIVE_INFINITY;

		/**
		* amf Array File Path
		**/
		public var amfArray : String = null;

		/**
		* last live to vod sync time
		**/
		public var lastCuePointSyncTime : int = int.MIN_VALUE;

		/**
		* last segment drift
		**/
		public var lastSegmentDrift : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('vodEntryId');
			arr.push('liveEntryId');
			arr.push('totalVodDuration');
			arr.push('lastSegmentDuration');
			arr.push('amfArray');
			arr.push('lastCuePointSyncTime');
			arr.push('lastSegmentDrift');
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
