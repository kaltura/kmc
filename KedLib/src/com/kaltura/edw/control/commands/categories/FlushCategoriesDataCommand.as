package com.kaltura.edw.control.commands.categories
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;
	
	public class FlushCategoriesDataCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void {
			var filterModel:FilterModel = (_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel;
			filterModel.categoriesMapForEntries.clear();
			filterModel.categoriesForEntries = null;
			
			filterModel.categoriesMapForCats.clear();
			filterModel.categoriesForCats = null;
			
			filterModel.categoriesMapGeneral.clear();
			filterModel.categoriesGeneral = null;
		}
	}
}