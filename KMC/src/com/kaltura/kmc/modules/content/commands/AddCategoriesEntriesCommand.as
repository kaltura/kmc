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
		private var _entries:Array;
		private var _categories:Array;
		
		/**
		 * objects like {entry, category} for each request
		 */
		private var _catents:Array;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_eventType = event.type;
			
			var e:EntriesEvent = event as EntriesEvent;
			_categories = e.data as Array; // elements are KalturaCategories
			// for each entry, add the category.
			if (event.type == EntriesEvent.ADD_ON_THE_FLY_CATEGORY) {
				_entries = _model.categoriesModel.onTheFlyCategoryEntries;
			}
			else if (event.type == EntriesEvent.ADD_CATEGORIES_ENTRIES) {
				_entries = _model.selectedEntries;
			}
			
			var cea:CategoryEntryAdd;
			var kce:KalturaCategoryEntry;
			var mr:MultiRequest = new MultiRequest();
			_catents = new Array();
			for each (var kbe:KalturaBaseEntry in _entries) {
				for each (var kc:KalturaCategory in _categories) {
					kce = new KalturaCategoryEntry();
					kce.entryId = kbe.id;
					kce.categoryId = kc.id;
					cea = new CategoryEntryAdd(kce);
					mr.addAction(cea);
					_catents.push({entry:kbe, category:kc});
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
		
		
		override protected function checkError(resultData:Object, header:String = ''):Boolean {
			if (!header) {
				header = ResourceManager.getInstance().getString('cms', 'error');
			}
			// look for error
			var str:String = '';
			var o:Object;
			var er:KalturaError = (resultData as KalturaEvent).error;
			if (er) {
				str = getMessageFromError(er.errorCode, er.errorMsg);
				Alert.show(str, header);
				return true;
			} 
			else {
				if (resultData.data is Array && resultData.data.length) {
					// this was a multirequest, we need to check its contents.
					str = '';
					for (var i:int = 0; i<resultData.data.length; i++) {
						o = resultData.data[i];
						if (o.error) {
							// in MR errors aren't created
							if (o.error.code == 'CATEGORY_ENTRY_ALREADY_EXISTS') {
								str += ResourceManager.getInstance().getString('cms', 'entry_already_assigned', [_catents[i]['entry'].name, _catents[i]['category'].name]);
							}
							else {
								str += getMessageFromError(o.error.code, o.error.message); 
							}
							str += '\n';
						}
					}
					if (str.length > 0) {
						Alert.show(str, header);
						return true;
					}
				}
			}
			return false;
		}
	}
}