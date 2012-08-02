package com.kaltura.kmc.modules.content.commands.bulk {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.bulk.BulkList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.vo.KalturaBulkUploadFilter;
	import com.kaltura.vo.KalturaBulkUploadListResponse;
	import com.kaltura.vo.KalturaBulkUploadResult;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;

	public class ListBulkUploadCommand extends KalturaCommand {
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			
			var f:KalturaBulkUploadFilter;
			var p:KalturaFilterPager;
			
			if (event.data) {
				// use given and save
				_model.bulkUploadModel.lastFilterUsed = f = event.data[0] as KalturaBulkUploadFilter;
				_model.bulkUploadModel.lastPagerUsed = p = event.data[1] as KalturaFilterPager;
			}
			else {
				// use saved
				f = _model.bulkUploadModel.lastFilterUsed;
				p = _model.bulkUploadModel.lastPagerUsed;
			}
			
			
			var listBulks:BulkList = new BulkList(f, p);
			listBulks.addEventListener(KalturaEvent.COMPLETE, result);
			listBulks.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(listBulks);

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