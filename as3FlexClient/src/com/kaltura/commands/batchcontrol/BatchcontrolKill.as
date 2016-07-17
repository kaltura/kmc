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
package com.kaltura.commands.batchcontrol
{
	import com.kaltura.delegates.batchcontrol.BatchcontrolKillDelegate;
	import com.kaltura.net.KalturaCall;

	/**
	* batch kill action forces stop og a batch on a remote scheduler
	**/
	public class BatchcontrolKill extends KalturaCall
	{
		public var filterFields : String;
		
		/**
		* @param workerId int
		* @param batchIndex int
		* @param adminId int
		* @param cause String
		**/
		public function BatchcontrolKill( workerId : int,batchIndex : int,adminId : int,cause : String )
		{
			service= 'batchcontrol';
			action= 'kill';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('workerId');
			valueArr.push(workerId);
			keyArr.push('batchIndex');
			valueArr.push(batchIndex);
			keyArr.push('adminId');
			valueArr.push(adminId);
			keyArr.push('cause');
			valueArr.push(cause);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new BatchcontrolKillDelegate( this , config );
		}
	}
}
