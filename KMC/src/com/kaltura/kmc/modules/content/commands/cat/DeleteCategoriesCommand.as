package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryDelete;
	import com.kaltura.edw.control.KedController;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class DeleteCategoriesCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void
		{
			
		 	var mr:MultiRequest = new MultiRequest();
			var ids:Array = event.data as Array;
			if (!ids) {
				// get from model
				ids = [];
				for each (var kCat:KalturaCategory in _model.categoriesModel.selectedCategories) {
					ids.push(kCat.id);
				}
			}
			if (ids.length == 0) {
				// no categories
				var rm:IResourceManager = ResourceManager.getInstance();
				Alert.show(rm.getString('entrytable', 'selectCategoriesFirst'),
					rm.getString('cms', 'selectCategoriesFirstTitle'));
				return;
			}
			
			for each (var id:int in ids) {
				var deleteCategory:CategoryDelete = new CategoryDelete(id);
				mr.addAction(deleteCategory);
			}
			
			_model.increaseLoadCounter();
	        mr.addEventListener(KalturaEvent.COMPLETE, result);
            mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr); 
		}

		override public function result(data:Object):void
		{
			super.result(data);
			var rm:IResourceManager = ResourceManager.getInstance();
			var er:KalturaError = (data as KalturaEvent).error;
			var isError:Boolean;
			if (er) { 
				Alert.show(getErrorText(er), rm.getString('cms', 'error'));
				isError = true;
			}
			else {
				// look iside MR
				for each (var o:Object in data.data) {
					er = o as KalturaError;
					if (er) {
						Alert.show(getErrorText(er), rm.getString('cms', 'error'));
						isError = true;
					}
					else if (o.error) {
						// in MR errors aren't created
						var str:String = rm.getString('cms', o.error.code);
						if (!str) {
							str = o.error.message;
						} 
						Alert.show(str, rm.getString('cms', 'error'));
						isError = true;
					}
				}	
			}
			if (!isError) {			
				Alert.show(ResourceManager.getInstance().getString('cms', 'categoryDeleteDoneMsg'));
				if (_model.filterModel.catTreeDataManager) {
					_model.filterModel.catTreeDataManager.resetData();
				}
				
				var cgEvent:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
				cgEvent.dispatch();
			}
			_model.decreaseLoadCounter();
		}
	}
}