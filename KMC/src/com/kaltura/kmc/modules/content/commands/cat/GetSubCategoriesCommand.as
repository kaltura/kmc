package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryList;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.model.CategoriesModel;
	import com.kaltura.types.KalturaCategoryOrderBy;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryFilter;
	import com.kaltura.vo.KalturaCategoryListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class GetSubCategoriesCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			switch (event.type) {
				case CategoryEvent.RESET_SUB_CATEGORIES:
					_model.categoriesModel.subCategories = null;
					break;
				
				case CategoryEvent.GET_SUB_CATEGORIES:
					_model.increaseLoadCounter();
					
					// filter
					var f:KalturaCategoryFilter = new KalturaCategoryFilter();
					f.parentIdEqual = _model.categoriesModel.selectedCategory.id;
					f.orderBy = KalturaCategoryOrderBy.NAME_DESC;
					// pager
					var p:KalturaFilterPager = new KalturaFilterPager();
					p.pageSize = CategoriesModel.SUB_CATEGORIES_LIMIT;
					p.pageIndex = 1;
					
					var listCategories:CategoryList = new CategoryList(f, p);
					listCategories.addEventListener(KalturaEvent.COMPLETE, result);
					listCategories.addEventListener(KalturaEvent.FAILED, fault);
					_model.context.kc.post(listCategories);
					break;
			}
		}
		
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			
			var er:KalturaError = (data as KalturaEvent).error;
			if (er) { 
				Alert.show(getErrorText(er), ResourceManager.getInstance().getString('cms', 'error'));
				return;
			}
			if ((data.data as KalturaCategoryListResponse).totalCount <= CategoriesModel.SUB_CATEGORIES_LIMIT) {
				// only set to model if less than 50
				var ar:Array = (data.data as KalturaCategoryListResponse).objects;
				if (ar) {
					if (ar[0].partnerSortValue || ar[1].partnerSortValue) { 
						ar.sortOn("partnerSortValue");
					}
					else {
						ar.sortOn("name");
					}
				}
				_model.categoriesModel.subCategories = new ArrayCollection(ar);
			}
		}
		
	}
}