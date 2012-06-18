package com.kaltura.edw.control.commands.categories
{
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.ContentDataPack;
	import com.kaltura.edw.model.datapacks.ContextDataPack;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.types.KalturaCategoryOrderBy;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class ListCategoriesUnderCommand extends KedCommand {
		
		
		private var _branchCat:CategoryVO;
		
		private var _filterModel:FilterModel;
		
		private var _source:*;
		
		private var _onComplete:Function;
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			_filterModel = (_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel;
			_branchCat = event.data as CategoryVO;
			_source = event.source;
			_onComplete = event.onComplete;
			
			var kcf:KalturaCategoryFilter = new KalturaCategoryFilter();
			if (_branchCat) {
				kcf.parentIdEqual = _branchCat.id;
			}
			else {
				kcf.parentIdEqual = 0;
			}
//			kcf.orderBy = KalturaCategoryOrderBy.PARTNER_SORT_VALUE_DESC;
			var listCategories:CategoryList = new CategoryList(kcf);
			
			listCategories.addEventListener(KalturaEvent.COMPLETE, result);
			listCategories.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(listCategories);
		}
		
		override public function result(data:Object):void {
			super.result(data);
			var limit:int = (_model.getDataPack(ContextDataPack) as ContextDataPack).singleLevelMaxCategories;
			if ((data.data as KalturaCategoryListResponse).totalCount >= limit) {
				Alert.show(ResourceManager.getInstance().getString('filter', 'catsSingleLevelExceeded', [limit]));
			}
			else {
				if (_branchCat) {
					// set result in the existing tree 
					addCategoriesToTree((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapForEntries);
					addCategoriesToTree((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapForMod);
					addCategoriesToTree((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapForCats);
					addCategoriesToTree((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapGeneral);
				}
				else {
					// use result as tree base
					_filterModel.categoriesForEntries = addCategoriesToTree((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapForEntries);
					_filterModel.categoriesForMod = addCategoriesToTree((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapForMod);
					_filterModel.categoriesForCats = addCategoriesToTree((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapForCats);
					_filterModel.categoriesGeneral = addCategoriesToTree((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMapGeneral);
				}
			}
			if (_source && _onComplete != null) {
				_onComplete.apply(_source, [_branchCat]);
			}
			_model.decreaseLoadCounter();
		}
		
		private function addCategoriesToTree(kCats:Array, catMap:HashMap):ArrayCollection {
			// create category VOs
			var categories:ArrayCollection = new ArrayCollection();
			var category:CategoryVO;
			
			// add to hashmap
			for each (var kCat:KalturaCategory in kCats) {
				category = new CategoryVO(kCat.id, kCat.name, kCat);
				catMap.put(kCat.id + '', category);
				categories.addItem(category)
			}
			
			// add to tree: list children on parent category
			if (_branchCat) {
				if (!_branchCat.children) {
					_branchCat.children = new ArrayCollection();
				}
				for each (var cat:CategoryVO in categories) {
					_branchCat.children.addItem(cat);
				}
				// sort on partnerSortValue
				var temp:Array = cat.children.source;
				temp.sort(compareValues);
			}
//			else {
//				// first level
//				_filterModel.categories = categories;
//			}
			return categories;
		}
		
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