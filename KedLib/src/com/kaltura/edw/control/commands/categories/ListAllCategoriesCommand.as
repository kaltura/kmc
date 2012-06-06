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
			buildCategoriesHyrarchy((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMap);
			if (_source && _onComplete != null) {
				_onComplete.apply(_source, [_filterModel.categories]);
			}
			_model.decreaseLoadCounter();
		}
		
		private function buildCategoriesHyrarchy(kCats:Array, catMap:HashMap):void {
			// create category VOs
			var categories:ArrayCollection = new ArrayCollection();
			var category:CategoryVO;
			// add to hashmap
			for each (var kCat:KalturaCategory in kCats) {
				category = new CategoryVO(kCat.id, kCat.name, kCat);
				catMap.put(kCat.id + '', category);
				categories.addItem(category)
			}
			
			// create tree: list children on parent categories
			for each (var cat:CategoryVO in categories) {
				var parentCategory:CategoryVO = catMap.getValue(cat.category.parentId + '') as CategoryVO;
				if (parentCategory != null) {
 					if (!parentCategory.children) {
						parentCategory.children = new ArrayCollection();
					}
					parentCategory.children.addItem(cat);
					// (for falcon, don't sort, use received value)
					// sortCategories(parentCategory.children);
				}
				else {
					// parent is root
					if (!_filterModel.categories) {
						_filterModel.categories = new ArrayCollection();
					}
					_filterModel.categories.addItem(cat);
				}
			}
		}
		
		
		//		private function sortCategories(catArrCol:ArrayCollection):void {
		//			var dataSortField:SortField = new SortField();
		//			dataSortField.name = "name";
		//			dataSortField.caseInsensitive = true;
		//			dataSortField.descending = false;
		//			var dataSort:Sort = new Sort();
		//			dataSort.fields = [dataSortField];
		//			catArrCol.sort = dataSort;
		//			catArrCol.refresh();
		//		}
	}
}