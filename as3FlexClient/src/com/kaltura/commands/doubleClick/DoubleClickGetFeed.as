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
package com.kaltura.commands.doubleClick
{
	import com.kaltura.delegates.doubleClick.DoubleClickGetFeedDelegate;
	import com.kaltura.net.KalturaCall;

	/**
	**/
	public class DoubleClickGetFeed extends KalturaCall
	{
		public var filterFields : String;
		
		/**
		* @param distributionProfileId int
		* @param hash String
		* @param page int
		* @param period int
		* @param state String
		* @param ignoreScheduling Boolean
		**/
		public function DoubleClickGetFeed( distributionProfileId : int,hash : String,page : int=1,period : int=-1,state : String='',ignoreScheduling : Boolean=false )
		{
			service= 'doubleclickdistribution_doubleclick';
			action= 'getFeed';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('distributionProfileId');
			valueArr.push(distributionProfileId);
			keyArr.push('hash');
			valueArr.push(hash);
			keyArr.push('page');
			valueArr.push(page);
			keyArr.push('period');
			valueArr.push(period);
			keyArr.push('state');
			valueArr.push(state);
			keyArr.push('ignoreScheduling');
			valueArr.push(ignoreScheduling);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new DoubleClickGetFeedDelegate( this , config );
		}
	}
}
