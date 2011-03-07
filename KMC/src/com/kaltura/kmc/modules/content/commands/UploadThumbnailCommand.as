package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.UploadEntryEvent;
	import com.kaltura.commands.baseEntry.BaseEntryUpdateThumbnailImage;
	import com.kaltura.events.KalturaEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	
	public class UploadThumbnailCommand extends KalturaCommand implements ICommand,IResponder
	{
		override public function execute(event:CairngormEvent):void
		{
			var uploadImage:BaseEntryUpdateThumbnailImage = new BaseEntryUpdateThumbnailImage((event as UploadEntryEvent).entryId , (event as UploadEntryEvent).fileReferance);
            uploadImage.addEventListener(KalturaEvent.COMPLETE,result);
            uploadImage.addEventListener(KalturaEvent.FAILED,fault);
            uploadImage.queued = false;
            _model.context.kc.post(uploadImage); 
		}
		
		override public function result(data:Object):void
		{	
			_model.entryDetailsModel.selectedEntry.thumbnailUrl = data.data.thumbnailUrl;
			Alert.show(ResourceManager.getInstance().getString("cms" ,"updateThumbnailSuccessMessage"),ResourceManager.getInstance().getString("cms" ,"updateThumbnailSuccess"),4,null,onClose);
		}
		
		/**
		 * triggered when user closes the success message 
		 * @param event
		 */		
		public function onClose(event:CloseEvent = null):void
		{
			// Atar: probaly some sort of unused hook which allows overriding 
			// this function externally - cool idea.
		}

	}
}