package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.attachmentAsset.AttachmentAssetList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.view.window.entrydetails.EntryDetailsWin;
	import com.kaltura.kmc.modules.content.view.window.entrydetails.renderers.relatedFiles.RelatedFileActionRenderer;
	import com.kaltura.kmc.modules.content.vo.RelatedFileVO;
	import com.kaltura.vo.KalturaAsset;
	import com.kaltura.vo.KalturaAssetFilter;
	import com.kaltura.vo.KalturaAttachmentAsset;
	import com.kaltura.vo.KalturaAttachmentAssetListResponse;
	
	import mx.collections.ArrayCollection;

	public class ListRelatedFilesCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var filter:KalturaAssetFilter = new KalturaAssetFilter();
			filter.entryIdEqual = _model.entryDetailsModel.selectedEntry.id;
			var list:AttachmentAssetList = new AttachmentAssetList(filter);
			list.addEventListener(KalturaEvent.COMPLETE, result);
			list.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(list);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			var listResult:KalturaAttachmentAssetListResponse = data.data as KalturaAttachmentAssetListResponse;
			if (listResult) {
				var relatedAC:ArrayCollection = new ArrayCollection();
				for each (var asset:KalturaAttachmentAsset in listResult.objects) {
					var relatedVo:RelatedFileVO = new RelatedFileVO();
					relatedVo.file = asset;
					relatedVo.serveUrl = _model.context.kc.protocol + _model.context.kc.domain + RelatedFileVO.serveURL + "/ks/" + _model.context.kc.ks + "/attachmentAssetId/" + asset.id;
					relatedAC.addItem(relatedVo);
				}
				_model.entryDetailsModel.relatedFilesAC = relatedAC;
			}
			
			_model.decreaseLoadCounter();
		}
	}
}