package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.CategoryUtils;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.types.KalturaInheritanceType;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class SetCategoriesAttributeCommand extends KalturaCommand {
		
		private var _type:String;	// event type
		
		private var _kCats:Array;	// categories ready for update
		
		private var _numOfGroups:int = 1;	// numbre of groups to process
		
		private var _callsCompleted:int = 0;	// number of calls (groups) already processed
		
		private var _callFailed:Boolean = false;	// if any call failed, set to true
		
		private var _nonUpdate:Boolean = false;	// if any of the categories will not be updated due to lack of entitlements
		
		override public function execute(event:CairngormEvent):void
		{
			_type = event.type;
			_kCats = [];
			var kCat:KalturaCategory;
			var cats:Array = _model.categoriesModel.selectedCategories;
			
			// process cats before update
			for each (kCat in cats) {
				if (!kCat.privacyContexts) {
					_nonUpdate = true;
					continue;
				}
				
				if (_type == CategoryEvent.SET_CATEGORIES_LISTING) {
					kCat.appearInList = event.data as int;
				}
				else if (_type == CategoryEvent.SET_CATEGORIES_CONTRIBUTION) {
					kCat.contributionPolicy = event.data as int;
				} 
				else if (_type == CategoryEvent.SET_CATEGORIES_ACCESS) {
					kCat.privacy = event.data as int;
				} 
				else if (_type == CategoryEvent.SET_CATEGORIES_OWNER) {
//					if (kCat.inheritanceType == KalturaInheritanceType.INHERIT) {
//						_nonUpdate = true;
//						continue;
//					}
					kCat.owner = event.data as String;
				}
				
				CategoryUtils.resetUnupdateableFields(kCat);
				kCat.setUpdatedFieldsOnly(true);
				_kCats.push(kCat);
			}
			
			// is large update?
			if (_kCats.length > 50) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'updateLotsOfCategoriesMsg', [_kCats.length]),
					ResourceManager.getInstance().getString('cms', 'updateLotsOfEntriesTitle'),
					Alert.YES | Alert.NO, null, responesFnc);
				
			}
			else if (_kCats.length > 0) {
				var mr:MultiRequest = new MultiRequest();
				for each (kCat in _kCats) {
					var update:CategoryUpdate = new CategoryUpdate(kCat.id, kCat);
					mr.addAction(update);
				}
				
				_model.increaseLoadCounter();
				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(mr);
			}
			
			if (_nonUpdate) {
				var rm:IResourceManager = ResourceManager.getInstance();
				Alert.show(rm.getString('cms', 'catNotUpdateEnt'), rm.getString('cms', 'attention'));
			}
			
		}
		
		/**
		 * handle large update
		 * */
		private function responesFnc(event:CloseEvent):void {
			if (event.detail == Alert.YES) {
				if (_nonUpdate) {
					var rm:IResourceManager = ResourceManager.getInstance();
					Alert.show(rm.getString('cms', 'catNotUpdateEnt'), rm.getString('cms', 'attention'));
				}
				
				// update:
				_numOfGroups = Math.floor(_kCats.length / 50);
				var lastGroupSize:int = _kCats.length % 50;
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
						var keepId:int = (_kCats[index] as KalturaCategory).id;
						var kCat:KalturaCategory = _kCats[index] as KalturaCategory;
						kCat.setUpdatedFieldsOnly(true);
						CategoryUtils.resetUnupdateableFields(kCat);
						
						var update:CategoryUpdate = new CategoryUpdate(keepId, kCat);
						mr.addAction(update);
					}
					_model.increaseLoadCounter();
					_model.context.kc.post(mr);
				}
			}
			else {
				// announce no update:
				Alert.show(ResourceManager.getInstance().getString('cms', 'noUpdateMadeMsg'),
					ResourceManager.getInstance().getString('cms', 'noUpdateMadeTitle'));
			}
		}
		
		
		
		
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			
			_callsCompleted ++;
			_callFailed ||= checkError(data);
			if (_callsCompleted == _numOfGroups) {
				if (!_callFailed) {
					if (_type == CategoryEvent.SET_CATEGORIES_LISTING) {
						Alert.show(ResourceManager.getInstance().getString('cms', 'catListSuccess'));
					}
					else if (_type == CategoryEvent.SET_CATEGORIES_CONTRIBUTION) {
						Alert.show(ResourceManager.getInstance().getString('cms', 'catContPolSuccess'));
					}
					else if (_type == CategoryEvent.SET_CATEGORIES_ACCESS) {
						Alert.show(ResourceManager.getInstance().getString('cms', 'catAcSuccess'));
					}
					else if (_type == CategoryEvent.SET_CATEGORIES_OWNER) {
						Alert.show(ResourceManager.getInstance().getString('cms', 'catOwnSuccess'));
					}
				}
				
				// reload categories for table (also if no update, so values will be reset)
				var getCategoriesList:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
				getCategoriesList.dispatch();
			}
		}
	}
}