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
package com.kaltura.commands.batch
{
		import com.kaltura.vo.KalturaExclusiveLockKey;
		import com.kaltura.vo.KalturaBatchJobFilter;
	import com.kaltura.delegates.batch.BatchGetExclusiveJobsDelegate;
	import com.kaltura.net.KalturaCall;

	/**
	* batch getExclusiveJobsAction action allows to get a BatchJob
	**/
	public class BatchGetExclusiveJobs extends KalturaCall
	{
		public var filterFields : String;
		
		/**
		* @param lockKey KalturaExclusiveLockKey
		* @param maxExecutionTime int
		* @param numberOfJobs int
		* @param filter KalturaBatchJobFilter
		* @param jobType String
		* @param maxJobToPullForCache int
		**/
		public function BatchGetExclusiveJobs( lockKey : KalturaExclusiveLockKey,maxExecutionTime : int,numberOfJobs : int,filter : KalturaBatchJobFilter=null,jobType : String = null,maxJobToPullForCache : int=0 )
		{
			service= 'batch';
			action= 'getExclusiveJobs';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
				keyValArr = kalturaObject2Arrays(lockKey, 'lockKey');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			keyArr.push('maxExecutionTime');
			valueArr.push(maxExecutionTime);
			keyArr.push('numberOfJobs');
			valueArr.push(numberOfJobs);
			if (filter) { 
				keyValArr = kalturaObject2Arrays(filter, 'filter');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			} 
			keyArr.push('jobType');
			valueArr.push(jobType);
			keyArr.push('maxJobToPullForCache');
			valueArr.push(maxJobToPullForCache);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new BatchGetExclusiveJobsDelegate( this , config );
		}
	}
}
