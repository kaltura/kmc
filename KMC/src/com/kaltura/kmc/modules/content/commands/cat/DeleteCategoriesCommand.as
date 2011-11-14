package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryDelete;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.control.KedController;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class DeleteCategoriesCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
		 	var mr:MultiRequest = new MultiRequest();
			for each (var id:int in event.data)
			{
				var deleteCategory:CategoryDelete = new CategoryDelete(id);
				mr.addAction(deleteCategory);
			}
			
	        mr.addEventListener(KalturaEvent.COMPLETE, result);
            mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr); 
		}

		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			Alert.show(ResourceManager.getInstance().getString('cms', 'categoryDeleteDoneMsg'));
			var getCategoriesList:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
			getCategoriesList.dispatch();
			
			
//			(_model.getDataPack(ContextDataPack) as ContextDataPack).dispatcher.dispatchEvent(new KedDataEvent(KedDataEvent.CATEGORY_CHANGED));
			var searchEvent:SearchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES , _model.listableVo  );
			KedController.getInstance().dispatch(searchEvent);
		}
	}
}