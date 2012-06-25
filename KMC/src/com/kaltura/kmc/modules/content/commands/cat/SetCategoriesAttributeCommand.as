package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.category.CategoryUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class SetCategoriesAttributeCommand extends KalturaCommand {
		
		private var _type:String;
		
		override public function execute(event:CairngormEvent):void
		{
			_type = event.type;
			_model.increaseLoadCounter();
			var cats:Array = _model.categoriesModel.selectedCategories;
			var mr:MultiRequest = new MultiRequest();
			for each (var kCat:KalturaCategory in cats) {
				kCat.setUpdatedFieldsOnly(true);
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
					kCat.owner = event.data as String;
				} 
				var update:CategoryUpdate = new CategoryUpdate(kCat.id, kCat);
				mr.addAction(update);
			}
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr); 
		}
		
		override public function result(data:Object):void {
			super.result(data);
			_model.decreaseLoadCounter();
			
			var isErr:Boolean = checkError(data);
			if (!isErr) {
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