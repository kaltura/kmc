package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.BulkEvent;
	import com.kaltura.kmc.modules.content.view.controls.FileManager;
	import com.kaltura.commands.bulkUpload.BulkUploadAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBulkUpload;
	
	import flash.events.Event;
	import flash.net.FileReference;

	public class AddBulkUploadCommand extends KalturaCommand implements ICommand
	{
//		private var _fm : FileManager ;
		
		override public function execute(event:CairngormEvent):void
		{
			var e : BulkEvent = event as BulkEvent;
			var fr:FileReference;
			if(e.fm)
			{
				fr = e.fm.fr;
				var kbu:BulkUploadAdd = new BulkUploadAdd(_model.bulkUploadModel.defaultConversionProfileId, fr);
				kbu.addEventListener(KalturaEvent.COMPLETE, result);
				kbu.addEventListener(KalturaEvent.FAILED, fault);
				kbu.queued = false;
				_model.context.kc.post(kbu);
			}
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