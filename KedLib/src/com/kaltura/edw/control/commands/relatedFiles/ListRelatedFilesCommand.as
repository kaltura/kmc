package com.kaltura.edw.control.commands.relatedFiles
{
	import com.kaltura.commands.attachmentAsset.AttachmentAssetList;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.model.datapacks.RelatedFilesDataPack;
	import com.kaltura.edw.vo.RelatedFileVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaAssetFilter;
	import com.kaltura.vo.KalturaAttachmentAsset;
	import com.kaltura.vo.KalturaAttachmentAssetListResponse;
	
	import mx.collections.ArrayCollection;

	public class ListRelatedFilesCommand extends KedCommand
	{
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			var filter:KalturaAssetFilter = new KalturaAssetFilter();
			filter.entryIdEqual = (_model.getDataPack(EntryDataPack) as EntryDataPack).selectedEntry.id;
			var list:AttachmentAssetList = new AttachmentAssetList(filter);
			list.addEventListener(KalturaEvent.COMPLETE, result);
			list.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(list);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			var listResult:KalturaAttachmentAssetListResponse = data.data as KalturaAttachmentAssetListResponse;
			if (listResult) {
				var relatedAC:ArrayCollection = new ArrayCollection();
				for each (var asset:KalturaAttachmentAsset in listResult.objects) {
					var relatedVo:RelatedFileVO = new RelatedFileVO();
					relatedVo.file = asset;
					relatedVo.serveUrl = _client.protocol + _client.domain + RelatedFileVO.serveURL + "/ks/" + _client.ks + "/attachmentAssetId/" + asset.id;
					relatedAC.addItem(relatedVo);
				}
				(_model.getDataPack(RelatedFilesDataPack) as RelatedFilesDataPack).relatedFilesAC = relatedAC;
			}
			
			_model.decreaseLoadCounter();
		}
	}
}