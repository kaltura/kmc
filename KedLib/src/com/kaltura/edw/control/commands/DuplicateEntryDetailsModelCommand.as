package com.kaltura.edw.control.commands
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.EntryDetailsModel;
	import com.kaltura.edw.model.datapacks.EntryDataPack;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.kmvc.model.KMvCModel;

	public class DuplicateEntryDetailsModelCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void
		{
			// need to copy maxCats because entry data pack is not shared.
			var maxCats:int = (KMvCModel.getInstance().getDataPack(EntryDataPack) as EntryDataPack).maxNumCategories;
			KMvCModel.addModel();
			(KMvCModel.getInstance().getDataPack(EntryDataPack) as EntryDataPack).maxNumCategories = maxCats;
		}
	}
}