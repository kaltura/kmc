package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.edw.control.KedController;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.events.PropertyChangeEvent;
	import mx.resources.ResourceManager;
	
	public class UpdateCategoryCommand extends KalturaCommand 
	{
		/**
		 * should categories / entries lists be refreshed after save
		 * (only refreshed if cat drilldown is closed) 
		 */		
		private var _refreshList:Boolean;
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var cat:CategoryVO = event.data[0] as CategoryVO;
			cat.category.setUpdatedFieldsOnly(true);
			_refreshList = event.data[1];
		 	var updateCategory:CategoryUpdate = new CategoryUpdate(cat.id, cat.category);
		 	updateCategory.addEventListener(KalturaEvent.COMPLETE, result);
			updateCategory.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(updateCategory);	   
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			if (!checkError(data)) {
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
		}
		
		
		/**
		 * reloads data 
		 */		
		private function refreshLists():void {
			var getCategoriesList:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
			getCategoriesList.dispatch();

			if (_model.listableVo) {
				var searchEvent:SearchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES , _model.listableVo);
				KedController.getInstance().dispatch(searchEvent);
			}
			
			// reload categories for tree
			if (_model.filterModel.catTreeDataManager) {
				_model.filterModel.catTreeDataManager.resetData();
			}
		}
		
		override public function fault(info:Object):void
		{
			_model.decreaseLoadCounter();
			var alert : Alert = Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
			refreshLists();
		}
	}
}