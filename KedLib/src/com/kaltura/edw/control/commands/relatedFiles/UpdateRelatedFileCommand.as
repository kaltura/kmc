package com.kaltura.edw.control.commands.relatedFiles
{
	import com.kaltura.commands.attachmentAsset.AttachmentAssetUpdate;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.RelatedFileEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaAttachmentAsset;
	
	public class UpdateRelatedFileCommand extends KedCommand
	{
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var file:KalturaAttachmentAsset = (event as RelatedFileEvent).attachmentAsset;
			file.setUpdatedFieldsOnly(true);
			
			var updateAsset:AttachmentAssetUpdate = new AttachmentAssetUpdate(file.id, file);
			updateAsset.addEventListener(KalturaEvent.COMPLETE, result);
			updateAsset.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(updateAsset);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			
			_model.decreaseLoadCounter();
		}
	}
}