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
	import com.kaltura.vo.KalturaConfigurableDistributionProfile;

	[Bindable]
	public dynamic class KalturaPushToNewsDistributionProfile extends KalturaConfigurableDistributionProfile
	{
		/**
		* @see com.kaltura.types.KalturaDistributionProtocol
		**/
		public var protocol : int = int.MIN_VALUE;

		/**
		**/
		public var host : String = null;

		/**
		**/
		public var ips : String = null;

		/**
		**/
		public var port : int = int.MIN_VALUE;

		/**
		**/
		public var basePath : String = null;

		/**
		**/
		public var username : String = null;

		/**
		**/
		public var password : String = null;

		/**
		**/
		public var certificateKey : String = null;

		/**
		**/
		public var bodyXslt : String = null;

		/**
		**/
		public var recentNewsTimeInterval : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('host');
			arr.push('ips');
			arr.push('port');
			arr.push('basePath');
			arr.push('username');
			arr.push('password');
			arr.push('certificateKey');
			arr.push('bodyXslt');
			arr.push('recentNewsTimeInterval');
			return arr;
		}

		override public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = super.getInsertableParamKeys();
			arr.push('protocol');
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
