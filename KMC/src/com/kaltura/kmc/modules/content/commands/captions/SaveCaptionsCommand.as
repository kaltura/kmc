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
	import com.kaltura.kmc.modules.content.events.CaptionsEvent;
	import com.kaltura.kmc.modules.content.vo.EntryCaptionVO;
	import com.kaltura.types.KalturaNullableBoolean;
	import com.kaltura.vo.KalturaUploadedFileTokenResource;
	
	public class SaveCaptionsCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			var evt:CaptionsEvent = event as CaptionsEvent;
			_model.increaseLoadCounter();
			var mr:MultiRequest = new MultiRequest();
			var requestIndex:int = 1;
			if (evt.captionsToSave) {
				for each (var caption:EntryCaptionVO in evt.captionsToSave) {
					var resource:KalturaUploadedFileTokenResource = new KalturaUploadedFileTokenResource();
					if (caption.uploadTokenId) {
						resource.token = caption.uploadTokenId;
					}
					//new caption
					if (!caption.caption.id) {		
						var addCaption:CaptionAssetAdd = new CaptionAssetAdd(_model.entryDetailsModel.selectedEntry.id, caption.caption);
						mr.addAction(addCaption);
						requestIndex++;
						if (resource.token) {
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
						if (resource.token) {
							var updateContent:CaptionAssetSetContent = new CaptionAssetSetContent(caption.caption.id, resource);
							mr.addAction(updateContent);
							requestIndex++;
						}
					}
				}
			}
			//delete captions
			if (evt.captionToRemove) {
				for each (var delCap:EntryCaptionVO in evt.captionToRemove) {
					var deleteAsset:CaptionAssetDelete = new CaptionAssetDelete(delCap.caption.id);
					mr.addAction(deleteAsset);
					requestIndex++;
				}
			}
			//set as default
			if (evt.defaultCaption) {
				var setDefault:CaptionAssetSetAsDefault = new CaptionAssetSetAsDefault(evt.defaultCaption.caption.id);
				mr.addAction(setDefault);
				requestIndex++;
			}
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(mr);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
		}
	}
}