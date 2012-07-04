package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.CategoryUtils;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;
	
	public class UpdateCategoriesCommand extends KalturaCommand {
		
		private var _categories:Array;
		
		private var _numOfGroups:int = 1;
		private var _callsCompleted:int = 0;
		private var _callFailed:Boolean = false;
		
		override public function execute(event:CairngormEvent):void
		{
			_categories = event.data as Array;
			if (_categories.length > 50) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'updateLotsOfCategoriesMsg', [_categories.length]),
					ResourceManager.getInstance().getString('cms', 'updateLotsOfEntriesTitle'),
					Alert.YES | Alert.NO, null, responesFnc);
			}
			// for small update
			else {
				_model.increaseLoadCounter();
				var mr:MultiRequest = new MultiRequest();
				for each (var kCat:KalturaCategory in _categories) {
					kCat.setUpdatedFieldsOnly(true);
					CategoryUtils.resetUnupdateableFields(kCat);
					var update:CategoryUpdate = new CategoryUpdate(kCat.id, kCat);
					mr.addAction(update);
				}
				
				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(mr); 
			}
		}
		
		
		
		/**
		 * handle large update
		 * */
		private function responesFnc(event:CloseEvent):void {
			if (event.detail == Alert.YES) {
				
				// update:
				_numOfGroups = Math.floor(_categories.length / 50);
				var lastGroupSize:int = _categories.length % 50;
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
						var keepId:int = (_categories[index] as KalturaCategory).id;
						var kCat:KalturaCategory = _categories[index] as KalturaCategory;
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
					Alert.show(ResourceManager.getInstance().getString('cms', 'catUpdtSuccess'));
				}
				
				// reload categories for table (also if no update, so values will be reset)
				var getCategoriesList:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
				getCategoriesList.dispatch();
			}
		}
	}
}