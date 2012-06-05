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
			
			if (!_branchCat) {
				// if not provided, use root
				_branchCat = _filterModel.categories;
			}
			
			var kcf:KalturaCategoryFilter = new KalturaCategoryFilter();
			kcf.parentIdEqual = _branchCat.id;
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
				addCategoriesToTree((data.data as KalturaCategoryListResponse).objects, _filterModel.categoriesMap);
			}
			if (_source && _onComplete != null) {
				_onComplete.apply(_source, [_branchCat]);
			}
			_model.decreaseLoadCounter();
		}
		
		private function addCategoriesToTree(kCats:Array, catMap:HashMap):void {
			// create category VOs
			var categories:ArrayCollection = new ArrayCollection();
			var category:CategoryVO;
			for each (var kCat:KalturaCategory in kCats) {
				category = new CategoryVO(kCat.id, kCat.name, kCat);
				catMap.put(kCat.id + '', category);
				categories.addItem(category)
			}
			
			if (!_branchCat.children) {
				_branchCat.children = new ArrayCollection();
			}
			// add to tree: list children on parent category
			for each (var cat:CategoryVO in categories) {
				_branchCat.children.addItem(cat);
			}
			
		}
	}
}