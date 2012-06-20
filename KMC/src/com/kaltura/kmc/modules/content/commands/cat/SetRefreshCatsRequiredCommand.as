package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	
	public class SetRefreshCatsRequiredCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			_model.categoriesModel.refreshCategoriesRequired = event.data;
		}
	}
}