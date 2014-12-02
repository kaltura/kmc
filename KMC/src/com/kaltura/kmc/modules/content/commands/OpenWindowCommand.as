package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.types.WindowsStates;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.kmc.modules.content.model.CategoriesModel;
	import com.kaltura.vo.KalturaCategory;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class OpenWindowCommand extends KalturaCommand
	{
		private var _requiredState:String;
		
		override public function execute(event:CairngormEvent):void
		{
		
			var rm:IResourceManager = ResourceManager.getInstance();
			_requiredState = (event as WindowEvent).windowState;
			
			//if the current state is the same as the asked one (drill down in drill down)
			//close the opened window and open other instead
			if(_requiredState == _model.windowState)
				_model.windowState = WindowsStates.NONE;
			
			if(_model.windowState == WindowsStates.ENTRY_DETAILS_WINDOW && _requiredState == WindowsStates.ENTRY_DETAILS_WINDOW_SA)
				_model.windowState = WindowsStates.NONE;
							
			switch(_requiredState)
			{
				case WindowsStates.DOWNLOAD_WINDOW: 			
				case WindowsStates.REMOVE_ENTRY_TAGS_WINDOW:
				case WindowsStates.ADD_ENTRY_TAGS_WINDOW: 
				case WindowsStates.REMOVE_CATEGORIES_WINDOW: 
				case WindowsStates.SETTING_ACCESS_CONTROL_PROFILES_WINDOW:
				case WindowsStates.SETTING_SCHEDULING_WINDOW:
				case WindowsStates.CHANGE_ENTRY_OWNER_WINDOW:
					if(_model.selectedEntries.length > 0)
						_model.windowState =  _requiredState;
					else
						Alert.show( rm.getString('cms','pleaseSelectEntriesFirst') , 
									rm.getString('cms','pleaseSelectEntriesFirstTitle') );
				break;
				// bulk category actions
				case WindowsStates.REMOVE_CATEGORY_TAGS_WINDOW:
				case WindowsStates.ADD_CATEGORY_TAGS_WINDOW:
				case WindowsStates.CATEGORIES_LISTING_WINDOW:
				case WindowsStates.CATEGORIES_ACCESS_WINDOW:
				case WindowsStates.CATEGORIES_OWNER_WINDOW:
				case WindowsStates.CATEGORIES_CONTRIBUTION_WINDOW:
				case WindowsStates.MOVE_CATEGORIES_WINDOW:
					if(_model.categoriesModel.selectedCategories && _model.categoriesModel.selectedCategories.length > 0) {
						// see if any categories have edit warn tag
						var hasEditWarn:Boolean;
						for each (var kCat:KalturaCategory in _model.categoriesModel.selectedCategories) {
							if (kCat.tags && kCat.tags.indexOf(CategoriesModel.EDIT_WARN_TAG) > -1) {
								hasEditWarn = true;
								break;
							}
						}
						if (hasEditWarn) {
							Alert.show(rm.getString('cms','multipleCategoriesEditWarning'),
								rm.getString('cms','attention'), Alert.YES|Alert.NO, null, editWarnHandler);
						}
						else {
							_model.windowState =  _requiredState;
						}
					}
					else {
						Alert.show( rm.getString('cms','pleaseSelectCategoriesFirst') , 
									rm.getString('cms','pleaseSelectCategoriesFirstTitle') );
					}
				break;
				
				default:
					_model.windowState = _requiredState;
					break;
			}
			 
		}	
		
		private function editWarnHandler(event:CloseEvent):void
		{
			if (event.detail == Alert.YES) {
				_model.windowState = _requiredState;
			}
			
		}
	}
}