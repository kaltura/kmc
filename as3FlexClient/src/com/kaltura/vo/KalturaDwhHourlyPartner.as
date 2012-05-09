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
// Copyright (C) 2006-2011  Kaltura Inc.
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
	public dynamic class KalturaDwhHourlyPartner extends BaseFlexVo
	{
		/** 
		* 		* */ 
		public var partnerId : int = int.MIN_VALUE;

		/** 
		* Events aggregation time as Unix timestamp (In seconds) represent one hour
	 		* */ 
		public var aggregatedTime : int = int.MIN_VALUE;

		/** 
		* Summary of all entries play time (in seconds)
	 		* */ 
		public var sumTimeViewed : Number = Number.NEGATIVE_INFINITY;

		/** 
		* Average of all entries play time (in seconds)
	 		* */ 
		public var averageTimeViewed : Number = Number.NEGATIVE_INFINITY;

		/** 
		* Number of all played entries
	 		* */ 
		public var countPlays : int = int.MIN_VALUE;

		/** 
		* Number of all loaded entry players
	 		* */ 
		public var countLoads : int = int.MIN_VALUE;

		/** 
		* Number of plays that reached 25%
	 		* */ 
		public var countPlays25 : int = int.MIN_VALUE;

		/** 
		* Number of plays that reached 50%
	 		* */ 
		public var countPlays50 : int = int.MIN_VALUE;

		/** 
		* Number of plays that reached 75%
	 		* */ 
		public var countPlays75 : int = int.MIN_VALUE;

		/** 
		* Number of plays that reached 100%
	 		* */ 
		public var countPlays100 : int = int.MIN_VALUE;

		/** 
		* Number of times that editor opened
	 		* */ 
		public var countEdit : int = int.MIN_VALUE;

		/** 
		* Number of times that share button clicked
	 		* */ 
		public var countShares : int = int.MIN_VALUE;

		/** 
		* Number of times that download button clicked
	 		* */ 
		public var countDownload : int = int.MIN_VALUE;

		/** 
		* Number of times that report abuse button clicked
	 		* */ 
		public var countReportAbuse : int = int.MIN_VALUE;

		/** 
		* Count of new created media entries
	 		* */ 
		public var countMediaEntries : int = int.MIN_VALUE;

		/** 
		* Count of new created video entries
	 		* */ 
		public var countVideoEntries : int = int.MIN_VALUE;

		/** 
		* Count of new created image entries
	 		* */ 
		public var countImageEntries : int = int.MIN_VALUE;

		/** 
		* Count of new created audio entries
	 		* */ 
		public var countAudioEntries : int = int.MIN_VALUE;

		/** 
		* Count of new created mix entries
	 		* */ 
		public var countMixEntries : int = int.MIN_VALUE;

		/** 
		* Count of new created playlists
	 		* */ 
		public var countPlaylists : int = int.MIN_VALUE;

		/** 
		* Is bigint - in KB, aggregated daily in the first hour of every day
	 		* */ 
		public var countBandwidth : String = null;

		/** 
		* Is bigint - in MB, aggregated daily in the first hour of every day
	 		* */ 
		public var countStorage : String = null;

		/** 
		* Count of new created users
	 		* */ 
		public var countUsers : int = int.MIN_VALUE;

		/** 
		* Count of new created widgets
	 		* */ 
		public var countWidgets : int = int.MIN_VALUE;

		/** 
		* Is bigint - in MB, aggregated daily in the first hour of every day
	 		* */ 
		public var aggregatedStorage : String = null;

		/** 
		* Is bigint - in KB, aggregated daily in the first hour of every day
	 		* */ 
		public var aggregatedBandwidth : String = null;

		/** 
		* Count of times that player entered buffering state
	 		* */ 
		public var countBufferStart : int = int.MIN_VALUE;

		/** 
		* Count of times that player left buffering state
	 		* */ 
		public var countBufferEnd : int = int.MIN_VALUE;

		/** 
		* Count of times that player fullscreen state opened
	 		* */ 
		public var countOpenFullScreen : int = int.MIN_VALUE;

		/** 
		* Count of times that player fullscreen state closed
	 		* */ 
		public var countCloseFullScreen : int = int.MIN_VALUE;

		/** 
		* Count of times that replay button clicked
	 		* */ 
		public var countReplay : int = int.MIN_VALUE;

		/** 
		* Count of times that seek option used
	 		* */ 
		public var countSeek : int = int.MIN_VALUE;

		/** 
		* Count of times that upload dialog opened in the editor
	 		* */ 
		public var countOpenUpload : int = int.MIN_VALUE;

		/** 
		* Count of times that save and publish button clicked in the editor
	 		* */ 
		public var countSavePublish : int = int.MIN_VALUE;

		/** 
		* Count of times that the editor closed
	 		* */ 
		public var countCloseEditor : int = int.MIN_VALUE;

		/** 
		* Count of times that pre-bumper entry played
	 		* */ 
		public var countPreBumperPlayed : int = int.MIN_VALUE;

		/** 
		* Count of times that post-bumper entry played
	 		* */ 
		public var countPostBumperPlayed : int = int.MIN_VALUE;

		/** 
		* Count of times that bumper entry clicked
	 		* */ 
		public var countBumperClicked : int = int.MIN_VALUE;

		/** 
		* Count of times that pre-roll ad started
	 		* */ 
		public var countPrerollStarted : int = int.MIN_VALUE;

		/** 
		* Count of times that mid-roll ad started
	 		* */ 
		public var countMidrollStarted : int = int.MIN_VALUE;

		/** 
		* Count of times that post-roll ad started
	 		* */ 
		public var countPostrollStarted : int = int.MIN_VALUE;

		/** 
		* Count of times that overlay ad started
	 		* */ 
		public var countOverlayStarted : int = int.MIN_VALUE;

		/** 
		* Count of times that pre-roll ad clicked
	 		* */ 
		public var countPrerollClicked : int = int.MIN_VALUE;

		/** 
		* Count of times that mid-roll ad clicked
	 		* */ 
		public var countMidrollClicked : int = int.MIN_VALUE;

		/** 
		* Count of times that post-roll ad clicked
	 		* */ 
		public var countPostrollClicked : int = int.MIN_VALUE;

		/** 
		* Count of times that overlay ad clicked
	 		* */ 
		public var countOverlayClicked : int = int.MIN_VALUE;

		/** 
		* Count of pre-roll ad plays that reached 25%
	 		* */ 
		public var countPreroll25 : int = int.MIN_VALUE;

		/** 
		* Count of pre-roll ad plays that reached 50%
	 		* */ 
		public var countPreroll50 : int = int.MIN_VALUE;

		/** 
		* Count of pre-roll ad plays that reached 75%
	 		* */ 
		public var countPreroll75 : int = int.MIN_VALUE;

		/** 
		* Count of mid-roll ad plays that reached 25%
	 		* */ 
		public var countMidroll25 : int = int.MIN_VALUE;

		/** 
		* Count of mid-roll ad plays that reached 50%
	 		* */ 
		public var countMidroll50 : int = int.MIN_VALUE;

		/** 
		* Count of mid-roll ad plays that reached 75%
	 		* */ 
		public var countMidroll75 : int = int.MIN_VALUE;

		/** 
		* Count of post-roll ad plays that reached 25%
	 		* */ 
		public var countPostroll25 : int = int.MIN_VALUE;

		/** 
		* Count of post-roll ad plays that reached 50%
	 		* */ 
		public var countPostroll50 : int = int.MIN_VALUE;

		/** 
		* Count of post-roll ad plays that reached 75%
	 		* */ 
		public var countPostroll75 : int = int.MIN_VALUE;

		/** 
		* Is bigint - in KB, aggregated daily in the first hour of every day
	 		* */ 
		public var countLiveStreamingBandwidth : String = null;

		/** 
		* Is bigint - in MB, aggregated daily in the first hour of every day
	 		* */ 
		public var aggregatedLiveStreamingBandwidth : String = null;

		/** 
		* a list of attributes which may be updated on this object 
		* */ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}

		/** 
		* a list of attributes which may only be inserted when initializing this object 
		* */ 
		public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}

	}
}
