package com.kaltura.kmc.modules.content.commands.cat {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.analytics.GoogleAnalyticsConsts;
	import com.kaltura.analytics.GoogleAnalyticsTracker;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryDelete;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CatTrackEvent;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.model.CategoriesModel;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class DeleteCategoriesCommand extends KalturaCommand {

		private var _ids:Array;

		private var _numOfGroups:int = 1; // number of groups to process

		private var _callsCompleted:int = 0; // number of calls (groups) already processed

		private var _callFailed:Boolean = false; // if any call failed, set to true


		override public function execute(event:CairngormEvent):void {
			var hasSubCats:Boolean;		// has direct sub cats
			var hasEditWarn:Boolean;	// bulk && any has editWarn tag (single cat warning is handled earlier)
			
			if (event.data) {	// handling a single category
				hasSubCats = event.data[1];
				_ids = event.data[0] as Array;
			}
			if (!_ids) {	// handling bulk, get from model
				_ids = [];
				for each (var kCat:KalturaCategory in _model.categoriesModel.selectedCategories) {
					_ids.push(kCat.id);
					if (!hasEditWarn && kCat.tags && kCat.tags.indexOf(CategoriesModel.EDIT_WARN_TAG) > -1) {
						hasEditWarn = true;
					}
					if (!hasSubCats && kCat.directSubCategoriesCount > 0) {
						hasSubCats = true;
					}
				}
			}

			showMessage(_ids.length, hasSubCats, hasEditWarn);
		}

		
		private function showMessage(nCats:int, hasSubCats:Boolean, hasEditWarn:Boolean):void
		{
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			var msgs:Array = [];
			if (nCats == 0) {
				// no categories
				Alert.show(resourceManager.getString('entrytable', 'selectCategoriesFirst'),
					resourceManager.getString('cms', 'selectCategoriesFirstTitle'));
				return;
			}
			else {
				if (hasEditWarn) {
					// "some categories created by another app"
					msgs.push(resourceManager.getString('cms', 'multipleCategoriesDeleteWarning'));
				}
				if (nCats == 1) {
					if (hasSubCats) {
						// "subcats will be deleted"
						msgs.push(resourceManager.getString('cms', 'deleteCategoryWarn'));
					}
					else if (!hasEditWarn) {
						// simple "Are you sure"
						msgs.push(resourceManager.getString('cms', 'deleteCategoryWarn2'));
					}
				}
				else {
					// batch action - "Categories will be deleted with their sub-categories"
					msgs.push(resourceManager.getString('cms', 'deleteCategoriesWarn'));
				}
			}				
			// let the user know:
			var msg:String = '';
			if (msgs.length > 1) {
				for (var i:int = 0; i<msgs.length; i++) {
					msg += (i+1) + ') ' + msgs[i] + '\n';
				}
			}
			else {
				msg = msgs[0];
			}
			Alert.show(msg, resourceManager.getString('cms', 'attention'), Alert.OK | Alert.CANCEL, null, deleteCatsApprove);
		}


		private function deleteCatsApprove(e:CloseEvent):void {
			if (e.detail == Alert.OK) {
				GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_CATS_DELETE_BULK, GoogleAnalyticsConsts.CONTENT);
				deleteCats();
			}
		}
		
		
		
		private var _lastGroupSize:int;	// the last group will probably have a different size
		
		private var _groupIndex:int;	// currently processed group 
		
		private function deleteCats():void {
			_numOfGroups = Math.floor(_ids.length / 50);
			_lastGroupSize = _ids.length % 50;
			if (_lastGroupSize != 0) {
				_numOfGroups++;
			}
			else {
				_lastGroupSize = 50;
			}
			
			// start deleting
			_groupIndex = 0;
			if ( _groupIndex < _numOfGroups) {
				deleteGroup();
			}
		}

		
		private function deleteGroup():void {
			var mr:MultiRequest = new MultiRequest();
			mr.addEventListener(KalturaEvent.COMPLETE, deleteGroupResult);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			mr.queued = false;
			
			// get number of categories in group
			var groupSize:int = (_groupIndex < (_numOfGroups - 1)) ? 50 : _lastGroupSize;
			
			for (var entryIndexInGroup:int = 0; entryIndexInGroup < groupSize; entryIndexInGroup++) {
				var index:int = ((_groupIndex * 50) + entryIndexInGroup);
				var keepId:int = _ids[index];
				var deleteCategory:CategoryDelete = new CategoryDelete(keepId);
				mr.addAction(deleteCategory);
			}
			_model.increaseLoadCounter();
			_model.context.kc.post(mr);
		}
		
		
		private function deleteGroupResult(data:KalturaEvent):void {
			super.result(data);
			_model.decreaseLoadCounter();
			
			_callsCompleted++;
			_callFailed ||= checkError(data);
			
			if (_callsCompleted == _numOfGroups) {
				result(data);
			}
			else {
				_groupIndex++;
				deleteGroup();
			}
		}
		
		
		override public function result(data:Object):void {
			if (!_callFailed) {
				var rm:IResourceManager = ResourceManager.getInstance();
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
