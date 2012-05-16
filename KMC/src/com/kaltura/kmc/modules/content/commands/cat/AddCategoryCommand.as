package com.kaltura.kmc.modules.content.commands.cat {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.EntriesEvent;
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.events.PropertyChangeEvent;

	public class AddCategoryCommand extends KalturaCommand {
		
		/**
		 * should categories list be refreshed after save
		 * (only refreshed if cat drilldown is closed) 
		 */		
		private var _refreshList:Boolean;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_refreshList = event.data[1];
			var newCategory:KalturaCategory = event.data[0] as KalturaCategory;
			var addCategory:CategoryAdd = new CategoryAdd(newCategory);
			addCategory.addEventListener(KalturaEvent.COMPLETE, result);
			addCategory.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(addCategory);
		}


		override public function result(data:Object):void {
			super.result(data);
			if (data.data is KalturaCategory) {
				// addition worked out fine
				_model.categoriesModel.processingNewCategory = false;

				// if need to add entries to the created category
				if (_model.categoriesModel.onTheFlyCategoryEntries) {
					var cgEvent:EntriesEvent = new EntriesEvent(EntriesEvent.ADD_ON_THE_FLY_CATEGORY);
					cgEvent.data = [data.data];
					cgEvent.dispatch();
				}
				
				if (_refreshList) {
					refreshLists();
				}
				else {
					// copy any attributes from the server object to the client object 
					ObjectUtil.copyObject(data.data, _model.categoriesModel.selectedCategory);
					// retrigger binding
					_model.categoriesModel.dispatchEvent(PropertyChangeEvent.createUpdateEvent(_model.categoriesModel, "selectedCategory", _model.categoriesModel.selectedCategory, _model.categoriesModel.selectedCategory));
				}
				
			}
			_model.decreaseLoadCounter();
		}
		
		/**
		 * reloads data 
		 */		
		private function refreshLists():void {
			// reload categories for table
			var getCategoriesList:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
			getCategoriesList.dispatch();
			
			// reload categories for tree
			if (_model.filterModel.catTreeDataManager) {
				_model.filterModel.catTreeDataManager.resetData();
			}
		}

	}
}
