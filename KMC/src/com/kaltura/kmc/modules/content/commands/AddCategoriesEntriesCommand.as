package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.categoryEntry.CategoryEntryAdd;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.EntriesEvent;
	import com.kaltura.vo.KalturaBaseEntry;
	import com.kaltura.vo.KalturaCategory;
	import com.kaltura.vo.KalturaCategoryEntry;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class AddCategoriesEntriesCommand extends KalturaCommand {
		
		
		private var _eventType:String;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_eventType = event.type;
			
			var e:EntriesEvent = event as EntriesEvent;
			var categories:Array = e.data as Array; // elements are KalturaCategories
			// for each entry, add the category.
			var entries:Array;
			if (event.type == EntriesEvent.ADD_ON_THE_FLY_CATEGORY) {
				entries = _model.categoriesModel.onTheFlyCategoryEntries;
			}
			else if (event.type == EntriesEvent.ADD_CATEGORIES_ENTRIES) {
				entries = _model.selectedEntries;
			}
			
			var cea:CategoryEntryAdd;
			var kce:KalturaCategoryEntry;
			var mr:MultiRequest = new MultiRequest();
			for each (var kbe:KalturaBaseEntry in entries) {
				for each (var kc:KalturaCategory in categories) {
					kce = new KalturaCategoryEntry();
					kce.entryId = kbe.id;
					kce.categoryId = kc.id;
					cea = new CategoryEntryAdd(kce);
					mr.addAction(cea);
				}
			}
			
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);
			
		}
		
		override public function result(data:Object):void {
			super.result(data);
			
			if (!checkError(data)) {
				if (_eventType == EntriesEvent.ADD_ON_THE_FLY_CATEGORY) {
					// re-load cat.tree
					if (_model.filterModel.catTreeDataManager) {
						_model.filterModel.catTreeDataManager.resetData();
					}
					// "forget" the list on the model
					_model.categoriesModel.onTheFlyCategoryEntries = null;
				}
			}
			
			_model.decreaseLoadCounter();
		}
	}
}