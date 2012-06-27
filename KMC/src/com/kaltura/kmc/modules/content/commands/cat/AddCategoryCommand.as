package com.kaltura.kmc.modules.content.commands.cat {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.category.CategoryAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.EntriesEvent;
	import com.kaltura.utils.ObjectUtil;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.events.PropertyChangeEvent;

	public class AddCategoryCommand extends KalturaCommand {
		
		/**
		 * should (custom) metadata be saved after category creation
		 * (only saved if values are set) 
		 */		
		private var _saveMetadata:Boolean;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_saveMetadata = event.data[1];
			var newCategory:KalturaCategory = event.data[0] as KalturaCategory;
			var addCategory:CategoryAdd = new CategoryAdd(newCategory);
			addCategory.addEventListener(KalturaEvent.COMPLETE, result);
			addCategory.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(addCategory);
		}


		override public function result(data:Object):void {
			super.result(data);
			if (!checkError(data) && data.data is KalturaCategory) {
				// addition worked out fine
				_model.categoriesModel.processingNewCategory = false;

				var cgEvent:CairngormEvent;
				// if need to add entries to the created category
				if (_model.categoriesModel.onTheFlyCategoryEntries) {
					cgEvent = new EntriesEvent(EntriesEvent.ADD_ON_THE_FLY_CATEGORY);
					cgEvent.data = [data.data];
					cgEvent.dispatch();
				}
				if (_saveMetadata) {
					cgEvent = new CategoryEvent(CategoryEvent.UPDATE_CATEGORY_METADATA_DATA);
					cgEvent.data = (data.data as KalturaCategory).id;
					cgEvent.dispatch();
				}
				
				// copy any attributes from the server object to the client object 
				ObjectUtil.copyObject(data.data, _model.categoriesModel.selectedCategory);
				// retrigger binding
				_model.categoriesModel.dispatchEvent(PropertyChangeEvent.createUpdateEvent(_model.categoriesModel, "selectedCategory", _model.categoriesModel.selectedCategory, _model.categoriesModel.selectedCategory));
			}
			_model.decreaseLoadCounter();
		}
		

	}
}
