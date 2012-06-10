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
		
		private var ids:Array;
		
		override public function execute(event:CairngormEvent):void {
			var rm:IResourceManager = ResourceManager.getInstance();
			
			ids = event.data as Array;
			if (!ids) {
				// get from model
				ids = [];
				for each (var kCat:KalturaCategory in _model.categoriesModel.selectedCategories) {
					ids.push(kCat.id);
				}
			}
			if (ids.length == 0) {
				// no categories
				
				Alert.show(rm.getString('entrytable', 'selectCategoriesFirst'),
					rm.getString('cms', 'selectCategoriesFirstTitle'));
				return;
			}

			// let the user know this is an async action:
			Alert.show(rm.getString('cms', 'asyncCategoryWarn'), rm.getString('cms', 'attention'), Alert.OK|Alert.CANCEL, null, deleteCats);
		}
		
		private function deleteCats(e:CloseEvent):void {
			if (e.detail == Alert.OK) {
				var mr:MultiRequest = new MultiRequest();
				for each (var id:int in ids) {
					var deleteCategory:CategoryDelete = new CategoryDelete(id);
					mr.addAction(deleteCategory);
				}
				
				_model.increaseLoadCounter();
				mr.addEventListener(KalturaEvent.COMPLETE, result);
				mr.addEventListener(KalturaEvent.FAILED, fault);
				_model.context.kc.post(mr);
			}
		}


		override public function result(data:Object):void {
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
				Alert.show(rm.getString('cms', 'categoryDeleteDoneMsg'), rm.getString('cms', 'categoryDeleteDoneMsgTitle'));
				if (_model.filterModel.catTreeDataManager) {
					_model.filterModel.catTreeDataManager.resetData();
				}

				var cgEvent:CairngormEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
				cgEvent.dispatch();
				cgEvent = new CatTrackEvent(CatTrackEvent.UPDATE_STATUS);
				cgEvent.dispatch();
			}
			_model.decreaseLoadCounter();
		}
	}
}
