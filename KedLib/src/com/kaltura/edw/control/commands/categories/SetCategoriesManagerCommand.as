package com.kaltura.edw.control.commands.categories
{
	import com.kaltura.edw.components.fltr.cat.data.ICategoriesDataManger;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.FilterModel;
	import com.kaltura.edw.model.datapacks.FilterDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;

	public class SetCategoriesManagerCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void
		{
			var filterModel:FilterModel = (_model.getDataPack(FilterDataPack) as FilterDataPack).filterModel;
			filterModel.catTreeDataManager = event.data as ICategoriesDataManger;
		}
	}
}