package com.kaltura.kmc.modules.content.commands.captions
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.captionAsset.CaptionAssetAdd;
	import com.kaltura.commands.captionAsset.CaptionAssetDelete;
	import com.kaltura.commands.captionAsset.CaptionAssetSetAsDefault;
	import com.kaltura.commands.captionAsset.CaptionAssetSetContent;
	import com.kaltura.commands.captionAsset.CaptionAssetUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.edw.control.events.CaptionsEvent;
	import com.kaltura.edw.vo.EntryCaptionVO;
	import com.kaltura.types.KalturaNullableBoolean;
	import com.kaltura.vo.KalturaContentResource;
	import com.kaltura.vo.KalturaUploadedFileTokenResource;
	import com.kaltura.vo.KalturaUrlResource;
	
	public class SaveCaptionsCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			var evt:CaptionsEvent = event as CaptionsEvent;	
			var mr:MultiRequest = new MultiRequest();
			var requestIndex:int = 1;
			//set as default
			if (evt.defaultCaption && evt.defaultCaption.caption.isDefault!=KalturaNullableBoolean.TRUE_VALUE) {
				var setDefault:CaptionAssetSetAsDefault = new CaptionAssetSetAsDefault(evt.defaultCaption.caption.id);
				mr.addAction(setDefault);
				requestIndex++;
			}
			if (evt.captionsToSave) {
				for each (var caption:EntryCaptionVO in evt.captionsToSave) {
					//handle resource
					var resource:KalturaContentResource; 
					if (caption.uploadTokenId) {
						resource = new KalturaUploadedFileTokenResource();
						resource.token = caption.uploadTokenId;
					}
					else if (caption.resourceUrl && (!caption.downloadUrl || (caption.resourceUrl!=caption.downloadUrl))) {
						resource = new KalturaUrlResource();
						resource.url = caption.resourceUrl;
					}
					//new caption
					if (!caption.caption.id) {		
						var addCaption:CaptionAssetAdd = new CaptionAssetAdd(_model.entryDetailsModel.selectedEntry.id, caption.caption);
						mr.addAction(addCaption);
						requestIndex++;
						if (resource) {
							var addContent:CaptionAssetSetContent = new CaptionAssetSetContent('0', resource);
							mr.mapMultiRequestParam(requestIndex-1, "id", requestIndex, "id");
							mr.addAction(addContent);
							requestIndex++;
						}
					}
						//update existing one
					else {
						caption.caption.setUpdatedFieldsOnly(true);
						var update:CaptionAssetUpdate = new CaptionAssetUpdate(caption.caption.id, caption.caption);
						mr.addAction(update);
						requestIndex++;
						if (resource) {
							var updateContent:CaptionAssetSetContent = new CaptionAssetSetContent(caption.caption.id, resource);
							mr.addAction(updateContent);
							requestIndex++;
						}
					}
				}
			}
			//delete captions
			if (evt.captionsToRemove) {
				for each (var delCap:EntryCaptionVO in evt.captionsToRemove) {
					var deleteAsset:CaptionAssetDelete = new CaptionAssetDelete(delCap.caption.id);
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