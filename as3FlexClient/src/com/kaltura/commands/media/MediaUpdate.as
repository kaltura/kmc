package com.kaltura.commands.media
{
	import com.kaltura.vo.KalturaMediaEntry;
	import com.kaltura.vo.KalturaResource;
	import com.kaltura.delegates.media.MediaUpdateDelegate;
	import com.kaltura.net.KalturaCall;

	public class MediaUpdate extends KalturaCall
	{
		public var filterFields : String;
		/**
		 * @param entryId String
		 * @param mediaEntry KalturaMediaEntry
		 * @param resource KalturaResource
		 **/
		public function MediaUpdate( entryId : String,mediaEntry : KalturaMediaEntry=null,resource : KalturaResource=null )
		{
			service= 'media';
			action= 'update';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('entryId');
			valueArr.push(entryId);
 			if (mediaEntry) { 
 			keyValArr = kalturaObject2Arrays(mediaEntry, 'mediaEntry');
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
			delegate = new MediaUpdateDelegate( this , config );
		}
	}
}
