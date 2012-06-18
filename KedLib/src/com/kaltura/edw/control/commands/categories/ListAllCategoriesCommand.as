package com.kaltura.edw.control.commands.categories
{
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryCount;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaEntryStatus;
	import com.kaltura.types.KalturaMediaType;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryListResponse;
	import com.kaltura.vo.KalturaMediaEntryFilter;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.resources.ResourceManager;

	public class ListAllCategoriesCommand extends KedCommand {
		
		private var _source:*;
		
		private var _onComplete:Function;
		
		private var _filterModel:FilterModel;
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			
			_source = event.source;
			_onComplete = event.onComplete;
			
			var listCategories:CategoryList = new CategoryList();
			// listeners
			listCategories.addEventListener(KalturaEvent.COMPLETE, result);
			listCategories.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(listCategories);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_filterModel = (_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel;
			// set root level categories to the model
			_filterModel.categoriesForEntries = buildCategoriesHyrarchy((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapForEntries);
			// set root level categories to the model
			_filterModel.categoriesForMod = buildCategoriesHyrarchy((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapForMod);
			// set root level categories to the model
			_filterModel.categoriesForCats = buildCategoriesHyrarchy((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapForCats);
			// set root level categories to the model
			_filterModel.categoriesGeneral = buildCategoriesHyrarchy((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapGeneral);
			_model.decreaseLoadCounter();
		}
		
		private function buildCategoriesHyrarchy(kCats:Array, catMap:HashMap):ArrayCollection {
			var allCategories:ArrayCollection = new ArrayCollection();	// all categories, so we can scan them easily
			var rootLevel:ArrayCollection = new ArrayCollection();	// categories in the root level
			var category:CategoryVO;
			// create category VOs and add to hashmap
			for each (var kCat:KalturaCategory in kCats) {
				category = new CategoryVO(kCat.id, kCat.name, kCat);
				catMap.put(kCat.id + '', category);
				allCategories.addItem(category)
			}
			
			// create tree: list children on parent categories
			for each (category in allCategories) {
				var parentCategory:CategoryVO = catMap.getValue(category.category.parentId + '') as CategoryVO;
				if (parentCategory != null) {
 					if (!parentCategory.children) {
						parentCategory.children = new ArrayCollection();
					}
					parentCategory.children.addItem(category);
				}
				else {
					// parent is root
					rootLevel.addItem(category);
				}
			}
			
			var temp:Array;
			// sort on partnerSortValue
			for each (category in allCategories) {
				if (category.children) {
					temp = category.children.source;
					temp.sort(compareValues);
				}
			}
			
			return rootLevel;
		}
		
		
//		private function sortCategories(catArrCol:ArrayCollection):void {
//			// using this fucks up for each loops!!!!
//			var dataSort:Sort = new Sort();
//			dataSort.compareFunction = compareValues;
//			catArrCol.sort = dataSort;
//			catArrCol.refresh();
//		}
		
		private function compareValues(a:CategoryVO, b:CategoryVO, fields:Array = null):int {
			if (a == null && b == null)
				return 0;
			
			if (a == null)
				return 1;
			
			if (b == null)
				return -1;
			
			if (a.category.partnerSortValue < b.category.partnerSortValue)
				return -1;
			
			if (a.category.partnerSortValue > b.category.partnerSortValue)
				return 1;
			
			return 0;
		}
	}
}