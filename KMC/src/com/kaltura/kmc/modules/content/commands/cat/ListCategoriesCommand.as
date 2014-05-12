package com.kaltura.kmc.modules.content.commands.cat {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryCount;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.business.KedJSGate;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaMediaEntryFilter;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class ListCategoriesCommand extends KalturaCommand {
		
		private var _filterModel:FilterModel;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			// reset selected categories
			_model.categoriesModel.selectedCategories = [];
			
			if (event.data) {
				_model.categoriesModel.filter = event.data[0] as KalturaCategoryFilter;
				_model.categoriesModel.pager = event.data[1] as KalturaFilterPager;
				if (event.data.length > 2) {
					if (event.data[2]) {
						// reload categories for tree
						if (_model.filterModel.catTreeDataManager) {
							_model.filterModel.catTreeDataManager.resetData();
						}
					}
				}
			}
			
			var listCategories:CategoryList = new CategoryList(_model.categoriesModel.filter, _model.categoriesModel.pager);

			listCategories.addEventListener(KalturaEvent.COMPLETE, result);
			listCategories.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(listCategories);
		}


		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			if (!checkError(data)) {		
//			var er:KalturaError = (data as KalturaEvent).error;
//			if (er) { 
//				Alert.show(getErrorText(er), ResourceManager.getInstance().getString('cms', 'error'));
//				return;
//			}
				_model.categoriesModel.categoriesList = new ArrayCollection((data.data as KalturaCategoryListResponse).objects);
				_model.categoriesModel.totalCategories = (data.data as KalturaCategoryListResponse).totalCount;
			}
		}
		
		
		


	}
}