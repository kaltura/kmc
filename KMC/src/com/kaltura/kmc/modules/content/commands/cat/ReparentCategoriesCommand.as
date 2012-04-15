package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.analytics.control.CategoryEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class ReparentCategoriesCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var cats:Array = event.data[0] as Array;
			var parent:KalturaCategory = event.data[1] as KalturaCategory;
			var mr:MultiRequest = new MultiRequest();
			for each (var kCat:KalturaCategory in cats) {
				kCat.setUpdatedFieldsOnly(true);
				kCat.parentId = parent.id;
				var moveCategory:CategoryUpdate = new CategoryUpdate(kCat.id, kCat);
				mr.addAction(moveCategory);
			}
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr); 
		}
		
		override public function result(data:Object):void {
			super.result(data);
			var rm:IResourceManager = ResourceManager.getInstance();
			var er:KalturaError = (data as KalturaEvent).error;
			if (er) { 
				Alert.show(getErrorText(er), rm.getString('cms', 'error'));
				return;
			}
			else {
				// look iside MR
				for each (var o:Object in data.data) {
					er = o as KalturaError;
					if (er) {
						Alert.show(getErrorText(er), rm.getString('cms', 'error'));
					}
					else if (o.error) {
						// in MR errors aren't created
						var str:String = rm.getString('cms', o.error.code);
						if (!str) {
							str = o.error.message;
						} 
						Alert.show(str, rm.getString('cms', 'error'));
					}
				}	
			}
			
			_model.decreaseLoadCounter();
			
			if (_model.filterModel.catTreeDataManager) {
				_model.filterModel.catTreeDataManager.resetData();
			}
			
			var cgEvent:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
			cgEvent.dispatch();
		}
	}
}