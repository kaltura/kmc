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
	import com.kaltura.vo.KalturaObjectTask;

	[Bindable]
	public dynamic class KalturaMailNotificationObjectTask extends KalturaObjectTask
	{
		/**
		* The mail to send the notification to
		**/
		public var mailTo : String = null;

		/**
		* The sender in the mail
		**/
		public var sender : String = null;

		/**
		* The subject of the entry
		**/
		public var subject : String = null;

		/**
		* The message to send in the notification mail
		**/
		public var message : String = null;

		/**
		* The footer of the message to send in the notification mail
		**/
		public var footer : String = null;

		/**
		* The basic link for the KMC site
		**/
		public var link : String = null;

		/**
		* Send the mail to each user
		* @see com.kaltura.types.kalturaBoolean
		**/
		public var sendToUsers : Boolean;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('mailTo');
			arr.push('sender');
			arr.push('subject');
			arr.push('message');
			arr.push('footer');
			arr.push('link');
			arr.push('sendToUsers');
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
