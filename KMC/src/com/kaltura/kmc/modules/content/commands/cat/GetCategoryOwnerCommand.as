package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.user.UserGet;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaUser;
	
	public class GetCategoryOwnerCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void{
			
			switch (event.type){
				case CategoryEvent.CLEAR_CATEGORY_OWNER:
					_model.categoriesModel.categoryOwner = null;
					_model.categoriesModel.inheritedOwner = null;
					break;
				
				case CategoryEvent.GET_CATEGORY_OWNER:
					
					var selectedCat:KalturaCategory = event.data as KalturaCategory;
					var req:UserGet = new UserGet(selectedCat.owner);
					
					req.addEventListener(KalturaEvent.COMPLETE, result);
					req.addEventListener(KalturaEvent.FAILED, fault);
					
					_model.increaseLoadCounter();
					_model.context.kc.post(req);
					break;
				
			}
		}
		
		override public function result(data:Object):void{
			super.result(data);
			_model.decreaseLoadCounter();
			
			if (!checkError(data)) {
				_model.categoriesModel.categoryOwner = data.data as KalturaUser;
			}
		}
	}
}