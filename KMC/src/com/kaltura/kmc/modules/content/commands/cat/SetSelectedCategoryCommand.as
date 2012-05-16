package com.kaltura.kmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.vo.KalturaCategory;
	
	public class SetSelectedCategoryCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void{
			var catToSet:KalturaCategory = event.data as KalturaCategory;
			_model.categoriesModel.selectedCategory = catToSet;
		}

	}
}