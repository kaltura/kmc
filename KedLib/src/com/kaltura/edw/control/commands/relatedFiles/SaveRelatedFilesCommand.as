package com.kaltura.edw.control.commands.relatedFiles
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.attachmentAsset.AttachmentAssetAdd;
	import com.kaltura.commands.attachmentAsset.AttachmentAssetDelete;
	import com.kaltura.commands.attachmentAsset.AttachmentAssetSetContent;
	import com.kaltura.commands.attachmentAsset.AttachmentAssetUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	import com.kaltura.edw.control.events.RelatedFileEvent;
	import com.kaltura.edw.vo.RelatedFileVO;
	import com.kaltura.vo.KalturaUploadedFileTokenResource;
	
	public class SaveRelatedFilesCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			var evt:RelatedFileEvent = event as RelatedFileEvent;

			var mr:MultiRequest = new MultiRequest();
			var requestIndex:int = 1;
			//add assets
			if (evt.relatedToAdd) {
				for each (var relatedFile:RelatedFileVO in evt.relatedToAdd) {
					//add asset
					var addFile:AttachmentAssetAdd = new AttachmentAssetAdd(_model.entryDetailsModel.selectedEntry.id, relatedFile.file);
					mr.addAction(addFile);
					requestIndex++;
					//set its content
					var resource:KalturaUploadedFileTokenResource = new KalturaUploadedFileTokenResource();
					resource.token = relatedFile.uploadTokenId;
					var addContent:AttachmentAssetSetContent = new AttachmentAssetSetContent('0', resource);
					mr.mapMultiRequestParam(requestIndex-1, "id", requestIndex, "id");
					mr.addAction(addContent);
					requestIndex++;	
				}
			}
			//update assets
			if (evt.relatedToUpdate) {
				for each (var updateRelated:RelatedFileVO in evt.relatedToUpdate) {
					updateRelated.file.setUpdatedFieldsOnly(true);
					var updateAsset:AttachmentAssetUpdate = new AttachmentAssetUpdate(updateRelated.file.id, updateRelated.file);
					mr.addAction(updateAsset);
					requestIndex++;
				}
			}
			if (evt.relatedToDelete) {
				for each (var deleteRelated:RelatedFileVO in evt.relatedToDelete) {
					var deleteAsset:AttachmentAssetDelete = new AttachmentAssetDelete(deleteRelated.file.id);
					mr.addAction(deleteAsset);
					requestIndex++;
				}
			}
			
			if (requestIndex > 1) {
				_model.increaseLoadCounter();
				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				
				_model.context.kc.post(mr);
			}
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
		}
	}
}