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
	import com.kaltura.vo.KalturaConfigurableDistributionJobProviderData;

	[Bindable]
	public dynamic class KalturaUnicornDistributionJobProviderData extends KalturaConfigurableDistributionJobProviderData
	{
		/**
		* The Catalog GUID the video is in or will be ingested into.
		**/
		public var catalogGuid : String = null;

		/**
		* The Title assigned to the video. The Foreign Key will be used if no title is provided.
		**/
		public var title : String = null;

		/**
		* Indicates that the media content changed and therefore the job should wait for HTTP callback notification to be closed.
		* @see com.kaltura.types.kalturaBoolean
		**/
		public var mediaChanged : Boolean;

		/**
		* Flavor asset version.
		**/
		public var flavorAssetVersion : String = null;

		/**
		* The schema and host name to the Kaltura server, e.g. http://www.kaltura.com
		**/
		public var notificationBaseUrl : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('catalogGuid');
			arr.push('title');
			arr.push('mediaChanged');
			arr.push('flavorAssetVersion');
			arr.push('notificationBaseUrl');
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
