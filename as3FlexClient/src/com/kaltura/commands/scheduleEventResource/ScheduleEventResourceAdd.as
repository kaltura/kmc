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
package com.kaltura.commands.scheduleEventResource
{
		import com.kaltura.vo.KalturaScheduleEventResource;
	import com.kaltura.delegates.scheduleEventResource.ScheduleEventResourceAddDelegate;
	import com.kaltura.net.KalturaCall;

	/**
	* Allows you to add a new KalturaScheduleEventResource object
	**/
	public class ScheduleEventResourceAdd extends KalturaCall
	{
		public var filterFields : String;
		
		/**
		* @param scheduleEventResource KalturaScheduleEventResource
		**/
		public function ScheduleEventResourceAdd( scheduleEventResource : KalturaScheduleEventResource )
		{
			service= 'schedule_scheduleeventresource';
			action= 'add';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
				keyValArr = kalturaObject2Arrays(scheduleEventResource, 'scheduleEventResource');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new ScheduleEventResourceAddDelegate( this , config );
		}
	}
}
