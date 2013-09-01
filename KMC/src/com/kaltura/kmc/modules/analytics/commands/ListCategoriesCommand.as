package com.kaltura.kmc.modules.analytics.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.CategoryUtils;
	import com.kaltura.kmc.modules.analytics.model.AnalyticsModelLocator;
	import com.kaltura.types.KalturaCategoryOrderBy;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListCategoriesCommand implements ICommand, IResponder {
		private var _model:AnalyticsModelLocator = AnalyticsModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			_model.loadingCategories = true;

			var f:KalturaCategoryFilter = new KalturaCategoryFilter();
			f.orderBy = KalturaCategoryOrderBy.NAME_ASC;
			var listCategories:CategoryList = new CategoryList(f);

			listCategories.addEventListener(KalturaEvent.COMPLETE, result);
			listCategories.addEventListener(KalturaEvent.FAILED, fault);
			_model.kc.post(listCategories);
		}


		public function fault(info:Object):void {
			_model.loadingCategories = true;
			_model.checkLoading();
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('analytics', 'error'));
		}


		public function result(event:Object):void {
			_model.loadingCategories = true;
			_model.checkLoading();

			var kclr:KalturaCategoryListResponse;
			var kc:KalturaCategory;

			if (event.data[0] is KalturaError) {
				Alert.show((event.data[0] as KalturaError).errorMsg, ResourceManager.getInstance().getString('analytics', 'error'));
			}
			else {
				_model.categories = buildCategoriesHyrarchy((event.data as KalturaCategoryListResponse).objects, _model.categoriesMap);
			}

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
					temp.sort(CategoryUtils.compareValues);
				}
			}
			
			return rootLevel;
		}
		

	}
}
