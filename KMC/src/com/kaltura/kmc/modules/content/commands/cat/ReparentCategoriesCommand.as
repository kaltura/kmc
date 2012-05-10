package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryMove;
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.analytics.control.CategoryEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class ReparentCategoriesCommand extends KalturaCommand {
		
		
		private var cats:Array;
		
		private var newParent:int;
		
		override public function execute(event:CairngormEvent):void
		{
			cats = event.data[0] as Array;
			newParent = (event.data[1] as KalturaCategory).id;
			var rm:IResourceManager = ResourceManager.getInstance();
			
			if (!cats || cats.length == 0) {
				// no categories
				Alert.show(rm.getString('entrytable', 'selectCategoriesFirst'), rm.getString('cms', 'selectCategoriesFirstTitle'));
				return;
			}
			// verify all cats have the same parent:
			var origParentId:int = (cats[0] as KalturaCategory).parentId;
			for each (var kCat:KalturaCategory in cats) {
				if (kCat.parentId != origParentId) {
					Alert.show(rm.getString('cms', 'bulkMoveDeny'));
					return;
				}
			}
			
			// let the user know this is an async action:
			Alert.show(rm.getString('cms', 'asyncCategoryWarn'), rm.getString('cms', 'attention'), Alert.OK|Alert.CANCEL, null, moveCats);
			
		}
		
		
		/**
		 * move categories to new parent
		 * */
		private function moveCats(e:CloseEvent):void {
			if (e.detail == Alert.OK) {
				_model.increaseLoadCounter();
				var idstr:String = '';;
				for each (var kCat:KalturaCategory in cats) {
					idstr += kCat.id + ",";
				}
				var move:CategoryMove = new CategoryMove(idstr, newParent);
				
				move.addEventListener(KalturaEvent.COMPLETE, result);
				move.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(move);
			}
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			var rm:IResourceManager = ResourceManager.getInstance();
			var er:KalturaError = (data as KalturaEvent).error;
			if (er) { 
				Alert.show(getErrorText(er), rm.getString('cms', 'error'));
				return;
			}
			
			if (_model.filterModel.catTreeDataManager) {
				_model.filterModel.catTreeDataManager.resetData();
			}
			
			var cgEvent:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
			cgEvent.dispatch();
		}
	}
}