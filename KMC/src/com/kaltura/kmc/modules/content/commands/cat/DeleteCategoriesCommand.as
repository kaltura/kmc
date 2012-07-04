package com.kaltura.kmc.modules.content.commands.cat {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryDelete;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CatTrackEvent;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class DeleteCategoriesCommand extends KalturaCommand {
		
		private var _ids:Array;
		
		private var _numOfGroups:int = 1;	// numbre of groups to process
		
		private var _callsCompleted:int = 0;	// number of calls (groups) already processed
		
		private var _callFailed:Boolean = false;	// if any call failed, set to true
		
		override public function execute(event:CairngormEvent):void {
			var rm:IResourceManager = ResourceManager.getInstance();
			var hasSubCats:Boolean;
			if (event.data) {
				hasSubCats = event.data[1]; 
				_ids = event.data[0] as Array;
			}
			if (!_ids) {
				// get from model
				_ids = [];
				for each (var kCat:KalturaCategory in _model.categoriesModel.selectedCategories) {
					_ids.push(kCat.id);
				}
			}
			
			var msg:String;
			if (_ids.length == 0) {
				// no categories
				Alert.show(rm.getString('entrytable', 'selectCategoriesFirst'),
					rm.getString('cms', 'selectCategoriesFirstTitle'));
				return;
			}
			else if (_ids.length == 1) {
				// batch action
				if (hasSubCats) {
					// "subcats will be deleted"
					msg = rm.getString('cms', 'deleteCategoryWarn');
				}
				else {
					// simple "Are you sure"
					msg = rm.getString('cms', 'deleteCategoryWarn2');
				}
			}
			else {
				msg = rm.getString('cms', 'deleteCategoriesWarn');
			}
			
			// let the user know:
			Alert.show(msg, rm.getString('cms', 'attention'), Alert.OK|Alert.CANCEL, null, deleteCats);
		}
		
		private function deleteCats(e:CloseEvent):void {
			if (e.detail == Alert.OK) {
				_numOfGroups = Math.floor(_ids.length / 50);
				var lastGroupSize:int = _ids.length % 50;
				if (lastGroupSize != 0) {
					_numOfGroups++;
				}
				
				var groupSize:int;
				var mr:MultiRequest;
				for (var groupIndex:int = 0; groupIndex < _numOfGroups; groupIndex++) {
					mr = new MultiRequest();
					mr.addEventListener(KalturaEvent.COMPLETE, result);
					mr.addEventListener(KalturaEvent.FAILED, fault);
					mr.queued = false;
					
					groupSize = (groupIndex < (_numOfGroups - 1)) ? 50 : lastGroupSize;
					for (var entryIndexInGroup:int = 0; entryIndexInGroup < groupSize; entryIndexInGroup++) {
						var index:int = ((groupIndex * 50) + entryIndexInGroup);
						var keepId:int = _ids[index];
						var deleteCategory:CategoryDelete = new CategoryDelete(keepId);
						mr.addAction(deleteCategory);
					}
					_model.increaseLoadCounter();
					_model.context.kc.post(mr);
				}
			}
		}


		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			var rm:IResourceManager = ResourceManager.getInstance();
			
			_callsCompleted ++;
			_callFailed ||= checkError(data);
			if (_callsCompleted == _numOfGroups) {
				if (!_callFailed) {
					Alert.show(rm.getString('cms', 'categoryDeleteDoneMsg'), rm.getString('cms', 'categoryDeleteDoneMsgTitle'));
					
				}
				
				if (_model.filterModel.catTreeDataManager) {
					_model.filterModel.catTreeDataManager.resetData();
				}
				
				var cgEvent:CairngormEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
				cgEvent.dispatch();
				cgEvent = new CatTrackEvent(CatTrackEvent.UPDATE_STATUS);
				cgEvent.dispatch();
			}
		}
	}
}
