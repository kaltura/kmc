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
			
			_filterModel = _model.filterModel;
			
			var mr:MultiRequest = new MultiRequest();
			var filter:KalturaMediaEntryFilter = new KalturaMediaEntryFilter();

			filter.statusIn = KalturaEntryStatus.NO_CONTENT + "," + KalturaEntryStatus.ERROR_CONVERTING + 
				"," + KalturaEntryStatus.ERROR_IMPORTING + "," + KalturaEntryStatus.IMPORT + 
				"," + KalturaEntryStatus.PRECONVERT + "," + KalturaEntryStatus.READY +"," + KalturaEntryStatus.PENDING;
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
				KedJSGate.expired();
			}
			var o:Object = data.data[1];
			if (o.error && o.error.code) {
				if (o.error.code != APIErrorCode.SERVICE_FORBIDDEN) {
					Alert.show(o.error.code, "Error");
				}
				_model.decreaseLoadCounter();
				return;
			}
			
//			super.result(data);
			var categories:Array = (data.data[1] as KalturaCategoryListResponse).objects;
			_filterModel.categories = buildCategoriesHyrarchy(categories, data.data[0] as String);
			_model.decreaseLoadCounter();
		}
		
		
		/**
		 * builds category data as a tree
		 * @param kCategories		list of KalturaCategory objects to create heirarchy
		 * @param totalEntryCount	total number of entries 
		 * @return 	the root category in the tree
		 */		
		private function buildCategoriesHyrarchy(kCategories:Array, totalEntryCount:String):CategoryVO {
			// get a reference to the categories map
			var catMap:HashMap = _filterModel.categoriesMap;
			catMap.clear();

			// create the dummy "root" category
			var kCat:KalturaCategory = new KalturaCategory();
			kCat.fullName = '';
			kCat.entriesCount = int(totalEntryCount);
			var root:CategoryVO = new CategoryVO(0,
												 ResourceManager.getInstance().getString('cms', 'rootCategoryName'),
												 kCat);
			catMap.put("0", root);

			
			// temp array collection (the values to be used later are stored in the hashmap)
			var categories:ArrayCollection = new ArrayCollection();
			// list of categories' full names, to be used as dataProvider for the categories autocomplete
			var categoryNames:ArrayCollection = new ArrayCollection();

			// build categoryVOs:
			var category:CategoryVO;
			var catName:Object;
			for each (kCat in kCategories) {
				category = new CategoryVO(kCat.id, kCat.name, kCat);
				catMap.put(kCat.id + '', category);
				catName = new Object();
				catName.label = kCat.fullName;
				categoryNames.addItem(catName);
				categories.addItem(category)
			}

			(_model.entryDetailsModel.getDataPack(EntryDataPack) as EntryDataPack).categoriesFullNameList = categoryNames;

			// map parents to children
			for each (category in categories) {
				var parentCategory:CategoryVO = catMap.getValue(category.category.parentId + '') as CategoryVO;
				if (parentCategory != null) {
					parentCategory.children.addItem(category);
					// this is stupid, why not run once after all mapping is done?
//					sortCategories(parentCategory.children);
				}
			}
			
			for each (category in categories) {
				sortCategories(category.children);
			}

			return root;
		}


		/**
		 * sort the given array collection by "name" attribute 
		 * @param catArrCol		the list to sort
		 */
		private function sortCategories(catArrCol:ArrayCollection):void {
			if (!catArrCol) {
				return;
			}
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