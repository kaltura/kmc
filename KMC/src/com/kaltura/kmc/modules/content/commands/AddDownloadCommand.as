package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.DownloadEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.commands.*;
	import com.kaltura.commands.xInternal.XInternalXAddBulkDownload;
	import com.kaltura.events.KalturaEvent;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	import com.kaltura.edw.control.commands.KalturaCommand;

	public class AddDownloadCommand extends KalturaCommand
	{
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var de:DownloadEvent = event as DownloadEvent;
			
		 	var addDownload:XInternalXAddBulkDownload = new XInternalXAddBulkDownload(de.entriesIds, de.flavorParamId);
		 	addDownload.addEventListener(KalturaEvent.COMPLETE, result);
			addDownload.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(addDownload);	   
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();												// partner's email
			Alert.show( ResourceManager.getInstance().getString('cms', 'entryDownloadAlert', [data.data]) );
		}
		
		override public function fault(event:Object):void
		{
			_model.decreaseLoadCounter();
			Alert.show( ResourceManager.getInstance().getString('cms', 'entryDownloadErrorAlert') );
		}
	}
}