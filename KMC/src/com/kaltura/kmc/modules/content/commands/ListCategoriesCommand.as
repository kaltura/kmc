package com.kaltura.kmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryCount;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.model.types.APIErrorCode;
	import com.kaltura.kmc.modules.content.vo.CategoryVO;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	import com.kaltura.vo.KalturaMediaEntryFilter;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListCategoriesCommand extends KalturaCommand implements ICommand, IResponder {
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			var mr:MultiRequest = new MultiRequest();
			var filter:KalturaMediaEntryFilter = new KalturaMediaEntryFilter();

			filter.statusIn = KalturaEntryStatus.ERROR_CONVERTING + "," + KalturaEntryStatus.ERROR_IMPORTING +
				"," + KalturaEntryStatus.IMPORT + "," + KalturaEntryStatus.PRECONVERT + "," +
				KalturaEntryStatus.READY;
			filter.mediaTypeIn = KalturaMediaType.VIDEO + "," + KalturaMediaType.IMAGE + "," +
				KalturaMediaType.AUDIO + "," + "6" + "," + KalturaMediaType.LIVE_STREAM_FLASH;

			// to bypass server defaults
			filter.moderationStatusIn = '';

			var getEntryCount:BaseEntryCount = new BaseEntryCount(filter);
			mr.addAction(getEntryCount);

			var listCategories:CategoryList = new CategoryList(new KalturaCategoryFilter());
			mr.addAction(listCategories);

			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}


		override public function result(data:Object):void {
			var er:KalturaError = (data as KalturaEvent).error;
			if (er && er.errorCode == APIErrorCode.INVALID_KS) {
				// redirect to login, or whatever JS does with invalid KS.
				JSGate.expired();
			}
			var o:Object = data.data[1];
			if (o.error && o.error.code) {
				if (o.error.code == APIErrorCode.SERVICE_FORBIDDEN) {
					_model.decreaseLoadCounter();
				}
				else {
					Alert.show(o.error.code, "Error");
				}
				return;
			}
			
//			super.result(data);
			var categories:Array = (data.data[1] as KalturaCategoryListResponse).objects;
			_model.filterModel.categories = buildCategoriesHyrarchy(categories, data.data[0] as String);
			_model.decreaseLoadCounter();
		}
		
		
		private function buildCategoriesHyrarchy(array:Array, totalEntryCount:String):CategoryVO {
			var catMap:HashMap = _model.filterModel.categoriesMap;
			catMap.clear();

			var root:CategoryVO = new CategoryVO(0,
												 ResourceManager.getInstance().getString('cms',
																						 'rootCategoryName'),
												 new KalturaCategory());
			root.category.fullName = '';
			root.category.entriesCount = int(totalEntryCount);
			catMap.put(0 + '', root);

			var categories:ArrayCollection = new ArrayCollection();

			var categoryNames:ArrayCollection = new ArrayCollection();

			var category:CategoryVO;
			var catName:Object;
			for each (var kCat:KalturaCategory in array) {
				category = new CategoryVO(kCat.id, kCat.name, kCat);
				catMap.put(kCat.id + '', category);
				catName = new Object();
				catName.label = kCat.fullName;
				categoryNames.addItem(catName);
				categories.addItem(category)
			}

			_model.entryDetailsModel.categoriesFullNameList = categoryNames;

			for each (var cat:CategoryVO in categories) {
				var parentCategory:CategoryVO = catMap.getValue(cat.category.parentId + '') as CategoryVO;
				if (parentCategory != null) {
					parentCategory.children.addItem(cat);
					sortCategories(parentCategory.children);
				}
			}


			return root;
		}


		private function sortCategories(catArrCol:ArrayCollection):void {
			var dataSortField:SortField = new SortField();
			dataSortField.name = "name";
			dataSortField.caseInsensitive = true;
			dataSortField.descending = false;
			var dataSort:Sort = new Sort();
			dataSort.fields = [dataSortField];
			catArrCol.sort = dataSort;
			catArrCol.refresh();
		}

	}
}