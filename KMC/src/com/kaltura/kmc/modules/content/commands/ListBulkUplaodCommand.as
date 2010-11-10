package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.model.CmsModelLocator;
	import com.kaltura.kmc.modules.content.vo.FilterVO;
	import com.kaltura.commands.bulkUpload.BulkUploadList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBulkUpload;
	import com.kaltura.vo.KalturaBulkUploadListResponse;
	import com.kaltura.vo.KalturaBulkUploadResult;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class ListBulkUplaodCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
				
			var filter:KalturaFilterPager = _model.bulkUploadModel.bulkUploadFilterPager;
			
			var getListBulkUpload:BulkUploadList = new BulkUploadList(filter);
		 	getListBulkUpload.addEventListener(KalturaEvent.COMPLETE, result);
			getListBulkUpload.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getListBulkUpload);	
			
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			var re:KalturaBulkUploadListResponse;
			var kbr:KalturaBulkUploadResult;
			_model.decreaseLoadCounter();
			_model.bulkUploadModel.bulkUploadTotalCount = data.data.totalCount;
			var bulkUploadData:ArrayCollection = new ArrayCollection();
			for each(var kbu:KalturaBulkUpload in data.data.objects)
			{
				bulkUploadData.addItem(kbu);
			}
		
			_model.bulkUploadModel.ps3BulkUploadData = bulkUploadData;
		}
		
	}
}