package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryGet;
	import com.kaltura.commands.user.UserGet;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.types.KalturaInheritanceType;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaUser;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class ManageParentCategoryCommand extends KalturaCommand{
		
		private var _eventType:String;
		
		override public function execute(event:CairngormEvent):void{
			_eventType = event.type;
			
			switch (event.type){
				case CategoryEvent.CLEAR_PARENT_CATEGORY:
					_model.categoriesModel.inheritedParentCategory = null;
					break;
				
				case CategoryEvent.GET_PARENT_CATEGORY:
				case CategoryEvent.GET_INHERITED_PARENT_CATEGORY:
					_model.increaseLoadCounter();
					var mr:MultiRequest = new MultiRequest();
					
					var selectedCat:KalturaCategory = event.data as KalturaCategory;
					var req:CategoryGet;
					if (event.type == CategoryEvent.GET_PARENT_CATEGORY) {
						req = new CategoryGet(selectedCat.parentId);
					}
					else if (event.type == CategoryEvent.GET_INHERITED_PARENT_CATEGORY) {
						req = new CategoryGet(selectedCat.inheritedParentId);
					}
					
					mr.addAction(req);
					
					// inheritedOwner
					var getOwner:UserGet = new UserGet("1"); // dummy value, overriden in 2 lines
					mr.addAction(getOwner);
					mr.mapMultiRequestParam(1, "owner", 2, "userId");
					
					mr.addEventListener(KalturaEvent.COMPLETE, result);
					mr.addEventListener(KalturaEvent.FAILED, fault);
		
					_model.context.kc.post(mr);
					
					break;
					
			}
		}
		
		override public function result(data:Object):void{
			super.result(data);
			_model.decreaseLoadCounter();
			
			if (!checkError(data)) {
				//inheritedOwner
				if (data.data[1] is KalturaUser) {
					_model.categoriesModel.inheritedOwner = data.data[1] as KalturaUser;
				}
				
				// category
				if (data.data[0] is KalturaCategory){
					_model.categoriesModel.inheritedParentCategory = data.data[0] as KalturaCategory;
				}
				else {
					Alert.show(ResourceManager.getInstance().getString('cms', 'error') + ": " +
						ResourceManager.getInstance().getString('cms', 'noMatchingParentError'));
				}
				
			}
		}
	}
}