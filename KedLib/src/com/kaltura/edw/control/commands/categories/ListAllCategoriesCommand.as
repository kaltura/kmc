package com.kaltura.edw.control.commands.categories
{
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaCategoryOrderBy;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	
	import mx.collections.ArrayCollection;

	public class ListAllCategoriesCommand extends KedCommand {
		
		private var _source:*;
		
		private var _onComplete:Function;
		
		private var _filterModel:FilterModel;
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			
			_source = event.source;
			_onComplete = event.onComplete;
			
			var f:KalturaCategoryFilter = new KalturaCategoryFilter();
			f.orderBy = KalturaCategoryOrderBy.NAME_ASC;
			var listCategories:CategoryList = new CategoryList(f);
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
				if (category.children && category.children.length > 1) {
					temp = category.children.source;
					if (temp[0].category.partnerSortValue || temp[1].category.partnerSortValue) {
						// even if the first one has 0, if it is real order the second one will have a real value
						temp.sort(compareValues);
					}
					else {
						temp.sortOn("name");
					}
				}
			}
			
			return rootLevel;
		}
		
		
//		private function sortCategories(catArrCol:ArrayCollection):void {
//			// using this messes up "for each" loops!!!!
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