package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	
	public class SetSelectedCategoryUsersCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void {
			// event.data is [KalturaCategoryUser]
			_model.categoriesModel.selectedCategoryUsers = event.data;
		}
	}
}