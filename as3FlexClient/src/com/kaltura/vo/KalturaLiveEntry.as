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
	import com.kaltura.vo.KalturaLiveEntryRecordingOptions;

	import com.kaltura.vo.KalturaMediaEntry;

	[Bindable]
	public dynamic class KalturaLiveEntry extends KalturaMediaEntry
	{
		/**
		* The message to be presented when the stream is offline
		**/
		public var offlineMessage : String = null;

		/**
		* Recording Status Enabled/Disabled
		* @see com.kaltura.types.KalturaRecordStatus
		**/
		public var recordStatus : int = int.MIN_VALUE;

		/**
		* DVR Status Enabled/Disabled
		* @see com.kaltura.types.KalturaDVRStatus
		**/
		public var dvrStatus : int = int.MIN_VALUE;

		/**
		* Window of time which the DVR allows for backwards scrubbing (in minutes)
		**/
		public var dvrWindow : int = int.MIN_VALUE;

		/**
		* Elapsed recording time (in msec) up to the point where the live stream was last stopped (unpublished).
		**/
		public var lastElapsedRecordingTime : int = int.MIN_VALUE;

		/**
		* Array of key value protocol->live stream url objects
		**/
		public var liveStreamConfigurations : Array = null;

		/**
		* Recorded entry id
		**/
		public var recordedEntryId : String = null;

		/**
		* Flag denoting whether entry should be published by the media server
		* @see com.kaltura.types.KalturaLivePublishStatus
		**/
		public var pushPublishEnabled : int = int.MIN_VALUE;

		/**
		* Array of publish configurations
		**/
		public var publishConfigurations : Array = null;

		/**
		* The first time in which the entry was broadcast
		**/
		public var firstBroadcast : int = int.MIN_VALUE;

		/**
		* The Last time in which the entry was broadcast
		**/
		public var lastBroadcast : int = int.MIN_VALUE;

		/**
		* The time (unix timestamp in milliseconds) in which the entry broadcast started or 0 when the entry is off the air
		**/
		public var currentBroadcastStartTime : Number = Number.NEGATIVE_INFINITY;

		/**
		**/
		public var recordingOptions : KalturaLiveEntryRecordingOptions;

		/**
		* the status of the entry of type EntryServerNodeStatus
		* @see com.kaltura.types.KalturaEntryServerNodeStatus
		**/
		public var liveStatus : int = int.MIN_VALUE;

		/**
		* The chunk duration value in milliseconds
		**/
		public var segmentDuration : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('offlineMessage');
			arr.push('recordStatus');
			arr.push('dvrStatus');
			arr.push('dvrWindow');
			arr.push('lastElapsedRecordingTime');
			arr.push('liveStreamConfigurations');
			arr.push('recordedEntryId');
			arr.push('pushPublishEnabled');
			arr.push('publishConfigurations');
			arr.push('currentBroadcastStartTime');
			arr.push('recordingOptions');
			arr.push('segmentDuration');
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
				case 'liveStreamConfigurations':
					result = 'KalturaLiveStreamConfiguration';
					break;
				case 'publishConfigurations':
					result = 'KalturaLiveStreamPushPublishConfiguration';
					break;
				case 'recordingOptions':
					result = '';
					break;
				default:
					result = super.getElementType(arrayName);
					break;
			}
			return result;
		}
	}
}
