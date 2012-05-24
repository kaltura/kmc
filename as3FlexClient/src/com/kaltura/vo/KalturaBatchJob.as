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
// Copyright (C) 2006-2011  Kaltura Inc.
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
	import com.kaltura.vo.KalturaJobData;

	import com.kaltura.vo.KalturaBaseJob;

	[Bindable]
	public dynamic class KalturaBatchJob extends KalturaBaseJob
	{
		/**
		 **/
		public var entryId : String = null;

		/**
		 **/
		public var entryName : String = null;

		/**
		 * @see com.kaltura.types.KalturaBatchJobType
		 **/
		public var jobType : String = null;

		/**
		 **/
		public var jobSubType : int = int.MIN_VALUE;

		/**
		 **/
		public var onStressDivertTo : int = int.MIN_VALUE;

		/**
		 **/
		public var data : KalturaJobData;

		/**
		 * @see com.kaltura.types.KalturaBatchJobStatus
		 **/
		public var status : int = int.MIN_VALUE;

		/**
		 **/
		public var abort : int = int.MIN_VALUE;

		/**
		 **/
		public var checkAgainTimeout : int = int.MIN_VALUE;

		/**
		 **/
		public var progress : int = int.MIN_VALUE;

		/**
		 **/
		public var message : String = null;

		/**
		 **/
		public var description : String = null;

		/**
		 **/
		public var updatesCount : int = int.MIN_VALUE;

		/**
		 **/
		public var priority : int = int.MIN_VALUE;

		/**
		 * The id of identical job
		 * 
		 **/
		public var twinJobId : int = int.MIN_VALUE;

		/**
		 * The id of the bulk upload job that initiated this job
		 * 
		 **/
		public var bulkJobId : int = int.MIN_VALUE;

		/**
		 * When one job creates another - the parent should set this parentJobId to be its own id.
		 * 
		 **/
		public var parentJobId : int = int.MIN_VALUE;

		/**
		 * The id of the root parent job
		 * 
		 **/
		public var rootJobId : int = int.MIN_VALUE;

		/**
		 * The time that the job was pulled from the queue
		 * 
		 **/
		public var queueTime : int = int.MIN_VALUE;

		/**
		 * The time that the job was finished or closed as failed
		 * 
		 **/
		public var finishTime : int = int.MIN_VALUE;

		/**
		 * @see com.kaltura.types.KalturaBatchJobErrorTypes
		 **/
		public var errType : int = int.MIN_VALUE;

		/**
		 **/
		public var errNumber : int = int.MIN_VALUE;

		/**
		 **/
		public var fileSize : int = int.MIN_VALUE;

		/**
		 * @see com.kaltura.types.kalturaBoolean
		 **/
		public var lastWorkerRemote : Boolean;

		/**
		 **/
		public var schedulerId : int = int.MIN_VALUE;

		/**
		 **/
		public var workerId : int = int.MIN_VALUE;

		/**
		 **/
		public var batchIndex : int = int.MIN_VALUE;

		/**
		 **/
		public var lastSchedulerId : int = int.MIN_VALUE;

		/**
		 **/
		public var lastWorkerId : int = int.MIN_VALUE;

		/**
		 **/
		public var dc : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('entryId');
			arr.push('entryName');
			arr.push('jobSubType');
			arr.push('onStressDivertTo');
			arr.push('data');
			arr.push('status');
			arr.push('abort');
			arr.push('checkAgainTimeout');
			arr.push('progress');
			arr.push('message');
			arr.push('description');
			arr.push('updatesCount');
			arr.push('priority');
			arr.push('twinJobId');
			arr.push('bulkJobId');
			arr.push('parentJobId');
			arr.push('rootJobId');
			arr.push('queueTime');
			arr.push('finishTime');
			arr.push('errType');
			arr.push('errNumber');
			arr.push('fileSize');
			arr.push('lastWorkerRemote');
			arr.push('schedulerId');
			arr.push('workerId');
			arr.push('batchIndex');
			arr.push('lastSchedulerId');
			arr.push('lastWorkerId');
			arr.push('dc');
			return arr;
		}

		override public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = super.getInsertableParamKeys();
			return arr;
		}
	}
}
