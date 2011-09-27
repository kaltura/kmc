package com.kaltura.kmc.modules.content.commands.bulk {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.bulkUpload.BulkUploadList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBulkUpload;
	import com.kaltura.vo.KalturaBulkUploadListResponse;
	import com.kaltura.vo.KalturaBulkUploadResult;
	
	import mx.collections.ArrayCollection;
	import com.kaltura.edw.control.commands.KalturaCommand;

	public class ListBulkUploadCommand extends KalturaCommand {
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();

			var getListBulkUpload:BulkUploadList = new BulkUploadList(_model.bulkUploadModel.bulkUploadFilterPager);
			getListBulkUpload.addEventListener(KalturaEvent.COMPLETE, result);
			getListBulkUpload.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(getListBulkUpload);

		}


		override public function result(data:Object):void {
			super.result(data);
			var kbr:KalturaBulkUploadResult;
			_model.bulkUploadModel.bulkUploadTotalCount = data.data.totalCount;

			_model.bulkUploadModel.bulkUploads = new ArrayCollection((data.data as KalturaBulkUploadListResponse).objects);
			_model.decreaseLoadCounter();
		}

	}
}