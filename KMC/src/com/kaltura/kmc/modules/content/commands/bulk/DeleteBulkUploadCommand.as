package com.kaltura.kmc.modules.content.commands.bulk
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.bulkUpload.BulkUploadAbort;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.BulkEvent;
	import com.kaltura.vo.KalturaBulkUpload;
	
	public class DeleteBulkUploadCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			var kbu:BulkUploadAbort = new BulkUploadAbort(event.data);
			kbu.addEventListener(KalturaEvent.COMPLETE, result);
			kbu.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(kbu);
		}
		
		override public function result( data : Object ) : void
		{
			super.result(data);
			var temp:KalturaBulkUpload;
			var bulkEvent : BulkEvent = new BulkEvent( BulkEvent.LIST_BULK_UPLOAD );
			bulkEvent.dispatch();
		}
	}
}