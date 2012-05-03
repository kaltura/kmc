package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryGet;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.types.KalturaInheritanceType;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class ManageParentCategoryCommand extends KalturaCommand{
		
		private var _eventType:String;
		
		override public function execute(event:CairngormEvent):void{
			_eventType = event.type;
			
			switch (event.type){
				case CategoryEvent.CLEAR_PARENT_CATEGORY:
					_model.categoriesModel.parentCategory = null;
					_model.categoriesModel.inheritedParentCategory = null;
					break;
				
				case CategoryEvent.GET_PARENT_CATEGORY:
				case CategoryEvent.GET_INHERITED_PARENT_CATEGORY:
					_model.increaseLoadCounter();
					
					var selectedCat:KalturaCategory = event.data as KalturaCategory;
					var req:CategoryGet;
					if (event.type == CategoryEvent.GET_PARENT_CATEGORY) {
						req = new CategoryGet(selectedCat.parentId);
					}
					else if (event.type == CategoryEvent.GET_INHERITED_PARENT_CATEGORY) {
						req = new CategoryGet(selectedCat.inheritedParentId);
					}
					
					req.addEventListener(KalturaEvent.COMPLETE, result);
					req.addEventListener(KalturaEvent.FAILED, fault);
		
					_model.context.kc.post(req);
					
					break;
					
			}
		}
		
		override public function result(data:Object):void{
			super.result(data);
			_model.decreaseLoadCounter();
			
			if (data && data.data is KalturaError){
				Alert.show(ResourceManager.getInstance().getString('cms', 'error') + ": " +
					(data.data  as KalturaError).errorMsg);
				
				return;
			}
			
			if (data && data.data is KalturaCategory){
				var kalCat:KalturaCategory = data.data as KalturaCategory; 
				if (_eventType == CategoryEvent.GET_PARENT_CATEGORY) {
					_model.categoriesModel.parentCategory = kalCat;
					if (kalCat.inheritanceType == KalturaInheritanceType.INHERIT) {
						// get the inherited parent of the parent
						var cgEvent:CategoryEvent = new CategoryEvent(CategoryEvent.GET_INHERITED_PARENT_CATEGORY);
						cgEvent.data = kalCat;
						cgEvent.dispatch();
					}
				}
				else if (_eventType == CategoryEvent.GET_INHERITED_PARENT_CATEGORY) {
					_model.categoriesModel.inheritedParentCategory = data.data as KalturaCategory;
				}
			} else {
				Alert.show(ResourceManager.getInstance().getString('cms', 'error') + ": " +
					ResourceManager.getInstance().getString('cms', 'noMatchingParentError'));
			}
		}
	}
}