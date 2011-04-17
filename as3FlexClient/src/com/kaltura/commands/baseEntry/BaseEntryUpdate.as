package com.kaltura.commands.baseEntry
{
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaResource;
	import com.kaltura.delegates.baseEntry.BaseEntryUpdateDelegate;
	import com.kaltura.net.KalturaCall;

	public class BaseEntryUpdate extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param entryId String
		 * @param baseEntry KalturaBaseEntry
		 * @param resource KalturaResource
		 **/
		public function BaseEntryUpdate( entryId : String,baseEntry : KalturaBaseEntry=null,resource : KalturaResource=null )
		{
			service= 'baseentry';
			action= 'update';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('entryId');
			valueArr.push(entryId);
 			if (baseEntry) { 
 			keyValArr = kalturaObject2Arrays(baseEntry, 'baseEntry');
			keyArr = keyArr.concat(keyValArr[0]);
			valueArr = valueArr.concat(keyValArr[1]);
 			} 
 			if (resource) { 
 			keyValArr = kalturaObject2Arrays(resource, 'resource');
			keyArr = keyArr.concat(keyValArr[0]);
			valueArr = valueArr.concat(keyValArr[1]);
 			} 
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new BaseEntryUpdateDelegate( this , config );
		}
	}
}
