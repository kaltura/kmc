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
		import com.kaltura.vo.KalturaBulkUploadResult;
	import com.kaltura.delegates.batch.BatchAddBulkUploadResultDelegate;
	import com.kaltura.net.KalturaCall;

	/**
	* batch addBulkUploadResultAction action adds KalturaBulkUploadResult to the DB
	**/
	public class BatchAddBulkUploadResult extends KalturaCall
	{
		public var filterFields : String;
		
		/**
		* @param bulkUploadResult KalturaBulkUploadResult
		* @param pluginDataArray Array
		**/
		public function BatchAddBulkUploadResult( bulkUploadResult : KalturaBulkUploadResult,pluginDataArray : Array=null )
		{
			service= 'batch';
			action= 'addBulkUploadResult';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
				keyValArr = kalturaObject2Arrays(bulkUploadResult, 'bulkUploadResult');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			if (pluginDataArray) { 
				keyValArr = extractArray(pluginDataArray,'pluginDataArray');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			} 
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new BatchAddBulkUploadResultDelegate( this , config );
		}
	}
}
