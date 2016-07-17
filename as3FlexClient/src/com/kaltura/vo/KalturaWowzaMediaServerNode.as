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
	import com.kaltura.vo.KalturaMediaServerNode;

	[Bindable]
	public dynamic class KalturaWowzaMediaServerNode extends KalturaMediaServerNode
	{
		/**
		* Wowza Media server app prefix
		**/
		public var appPrefix : String = null;

		/**
		* Wowza Media server transcoder configuration overide
		**/
		public var transcoder : String = null;

		/**
		* Wowza Media server GPU index id
		**/
		public var GPUID : int = int.MIN_VALUE;

		/**
		* Live service port
		**/
		public var liveServicePort : int = int.MIN_VALUE;

		/**
		* Live service protocol
		**/
		public var liveServiceProtocol : String = null;

		/**
		* Wowza media server live service internal domain
		**/
		public var liveServiceInternalDomain : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('appPrefix');
			arr.push('transcoder');
			arr.push('GPUID');
			arr.push('liveServicePort');
			arr.push('liveServiceProtocol');
			arr.push('liveServiceInternalDomain');
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
