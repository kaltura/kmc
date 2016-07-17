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
package com.kaltura.commands.playReadyDrm
{
	import com.kaltura.delegates.playReadyDrm.PlayReadyDrmGetLicenseDetailsDelegate;
	import com.kaltura.net.KalturaCall;

	/**
	* Get Play Ready policy and dates for license creation
	**/
	public class PlayReadyDrmGetLicenseDetails extends KalturaCall
	{
		public var filterFields : String;
		
		/**
		* @param keyId String
		* @param deviceId String
		* @param deviceType int
		* @param entryId String
		* @param referrer String
		**/
		public function PlayReadyDrmGetLicenseDetails( keyId : String,deviceId : String,deviceType : int,entryId : String = null,referrer : String = null )
		{
			service= 'playready_playreadydrm';
			action= 'getLicenseDetails';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('keyId');
			valueArr.push(keyId);
			keyArr.push('deviceId');
			valueArr.push(deviceId);
			keyArr.push('deviceType');
			valueArr.push(deviceType);
			keyArr.push('entryId');
			valueArr.push(entryId);
			keyArr.push('referrer');
			valueArr.push(referrer);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new PlayReadyDrmGetLicenseDetailsDelegate( this , config );
		}
	}
}
