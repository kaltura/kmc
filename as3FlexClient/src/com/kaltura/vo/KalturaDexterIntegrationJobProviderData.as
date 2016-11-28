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
	import com.kaltura.vo.KalturaIntegrationJobProviderData;

	[Bindable]
	public dynamic class KalturaDexterIntegrationJobProviderData extends KalturaIntegrationJobProviderData
	{
		/**
		* ID of the metadata profile for the extracted term metadata
		**/
		public var metadataProfileId : int = int.MIN_VALUE;

		/**
		* ID of the transcript asset
		**/
		public var transcriptAssetId : String = null;

		/**
		* ID of the entry
		**/
		public var entryId : String = null;

		/**
		* Voicebase API key to fetch transcript tokens
		**/
		public var voicebaseApiKey : String = null;

		/**
		* Voicebase API password to fetch transcript tokens
		**/
		public var voicebaseApiPassword : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('metadataProfileId');
			arr.push('transcriptAssetId');
			arr.push('entryId');
			arr.push('voicebaseApiKey');
			arr.push('voicebaseApiPassword');
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
