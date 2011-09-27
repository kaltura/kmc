package com.kaltura.edw.control.commands.relatedFiles
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.attachmentAsset.AttachmentAssetUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	import com.kaltura.edw.control.events.RelatedFileEvent;
	import com.kaltura.vo.KalturaAttachmentAsset;
	
	public class UpdateRelatedFileCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var file:KalturaAttachmentAsset = (event as RelatedFileEvent).attachmentAsset;
			file.setUpdatedFieldsOnly(true);
			
			var updateAsset:AttachmentAssetUpdate = new AttachmentAssetUpdate(file.id, file);
			updateAsset.addEventListener(KalturaEvent.COMPLETE, result);
			updateAsset.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(updateAsset);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			
			_model.decreaseLoadCounter();
		}
	}
}