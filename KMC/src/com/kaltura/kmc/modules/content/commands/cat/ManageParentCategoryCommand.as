package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryGet;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class ManageParentCategoryCommand extends KalturaCommand{
		
		override public function execute(event:CairngormEvent):void{
			switch (event.type){
				case CategoryEvent.CLEAR_PARENT_CATEGORY:
					_model.categoriesModel.parentCategory = null;
					break;
				
				case CategoryEvent.GET_PARENT_CATEGORY:
					
					_model.increaseLoadCounter();
					
					var selectedCat:KalturaCategory = event.data as KalturaCategory;
					var parentId:int = selectedCat.parentId;
					
					var req:CategoryGet = new CategoryGet(parentId);
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
				Alert.show(ResourceManager.getInstance().getString('drilldown', 'error') + ": " +
					(data.data  as KalturaError).errorMsg);
				
				return;
			}
			
			if (data && data.data is KalturaCategory){
				_model.categoriesModel.parentCategory = data.data as KalturaCategory;
			} else {
				Alert.show(ResourceManager.getInstance().getString('drilldown', 'error') + ": " +
					ResourceManager.getInstance().getString('drilldown', 'noMatchingParentError'));
			}
		}
	}
}