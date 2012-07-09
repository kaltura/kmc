package com.kaltura.kmc.modules.content.commands.cat {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;

	public class ListCategoriesByRefidCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();

			var f:KalturaCategoryFilter = new KalturaCategoryFilter();
			f.referenceIdEqual = (event.data as KalturaCategory).referenceId;
			
			var catList:CategoryList = new CategoryList(f);
			catList.addEventListener(KalturaEvent.COMPLETE, result);
			catList.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(catList);
		}


		override public function result(data:Object):void {
			super.result(data);
			if (!checkError(data)) {
				var recievedData:KalturaCategoryListResponse = KalturaCategoryListResponse(data.data);
				_model.categoriesModel.categoriesWSameRefidAsSelected = recievedData.objects;
			}
			_model.decreaseLoadCounter();
		}

	}
}
