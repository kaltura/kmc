package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.CategoryEvent;
	import com.kaltura.commands.category.CategoryAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.types.KalturaStatsKmcEventType;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class AddCategoryCommand extends KalturaCommand implements ICommand,IResponder
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var newCategory:KalturaCategory = event.data as KalturaCategory;
		 	var addCategory:CategoryAdd = new CategoryAdd(newCategory);
		 	addCategory.addEventListener(KalturaEvent.COMPLETE, result);
			addCategory.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(addCategory);
		}

		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			var getCategoriesList:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
			getCategoriesList.dispatch();
		}
		
//		override public function fault(info:Object):void
//		{
//			_model.decreaseLoadCounter();
//			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
//		}
		
	}
}