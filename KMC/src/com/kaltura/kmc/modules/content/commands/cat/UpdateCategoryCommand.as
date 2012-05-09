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
	import mx.resources.ResourceManager;
	
	public class UpdateCategoryCommand extends KalturaCommand 
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var cat:CategoryVO = event.data as CategoryVO;
			cat.category.setUpdatedFieldsOnly(true);
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
				var catSource:KalturaCategory = data.data as KalturaCategory;
				var catTarget:KalturaCategory = _model.categoriesModel.selectedCategories[0]
				var atts:Array = ObjectUtil.getObjectAllKeys(catTarget);
				var att:String;
				for (var i:int = 0; i<atts.length; i++) {
					att = atts[i];
					if (catSource[att] != catTarget[att]){
						catTarget[att] = catSource[att];
					}
				}
				refresh();
			}
		}
		
		
		/**
		 * reloads data 
		 */		
		protected function refresh():void {
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
			refresh();
		}
	}
}