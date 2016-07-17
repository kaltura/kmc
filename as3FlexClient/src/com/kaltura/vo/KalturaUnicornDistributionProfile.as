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
	import com.kaltura.vo.KalturaConfigurableDistributionProfile;

	[Bindable]
	public dynamic class KalturaUnicornDistributionProfile extends KalturaConfigurableDistributionProfile
	{
		/**
		* The email address associated with the Upload User, used to authorize the incoming request.
		**/
		public var username : String = null;

		/**
		* The password used in association with the email to determine if the Upload User is authorized the incoming request.
		**/
		public var password : String = null;

		/**
		* The name of the Domain that the Upload User should have access to, Used for authentication.
		**/
		public var domainName : String = null;

		/**
		* The Channel GUID assigned to this Publication Rule. Must be a valid Channel in the Domain that was used in authentication.
		**/
		public var channelGuid : String = null;

		/**
		* The API host URL that the Upload User should have access to, Used for HTTP content submission.
		**/
		public var apiHostUrl : String = null;

		/**
		* The GUID of the Customer Domain in the Unicorn system obtained by contacting your Unicorn representative.
		**/
		public var domainGuid : String = null;

		/**
		* The GUID for the application in which to record metrics and enforce business rules obtained through your Unicorn representative.
		**/
		public var adFreeApplicationGuid : String = null;

		/**
		* The flavor-params that will be used for the remote asset.
		**/
		public var remoteAssetParamsId : int = int.MIN_VALUE;

		/**
		* The remote storage that should be used for the remote asset.
		**/
		public var storageProfileId : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('username');
			arr.push('password');
			arr.push('domainName');
			arr.push('channelGuid');
			arr.push('apiHostUrl');
			arr.push('domainGuid');
			arr.push('adFreeApplicationGuid');
			arr.push('remoteAssetParamsId');
			arr.push('storageProfileId');
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
