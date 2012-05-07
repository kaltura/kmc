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
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			
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
			_model.decreaseLoadCounter();
			
			// look for error
			var er:KalturaError = (data as KalturaEvent).error;
			var rm:IResourceManager = ResourceManager.getInstance();
			if (er) {
				Alert.show(getErrorText(er), rm.getString('cms', 'error'));
				
			}
			else {
				// look iside MR, ignore irrelevant
				for each (var o:Object in data.data) {
					er = o as KalturaError;
					if (er) {
//						if (er.errorCode != "ENTRY_IS_NOT_ASSIGNED_TO_CATEGORY") {
						Alert.show(getErrorText(er), rm.getString('cms', 'error'));
//						}
					}
					else if (o.error) {
						// in MR errors aren't created
//						if (o.error.code != "ENTRY_IS_NOT_ASSIGNED_TO_CATEGORY") {
							var str:String = rm.getString('cms', o.error.code);
							if (!str) {
								str = o.error.message;
							} 
							Alert.show(str, rm.getString('cms', 'error'));
//						}
					}
				}	
			}
			
		}
	}
}