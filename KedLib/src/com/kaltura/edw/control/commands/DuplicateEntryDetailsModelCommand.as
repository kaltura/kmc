package com.kaltura.edw.control.commands
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.model.EntryDetailsModel;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.kmvc.model.KMvCModel;

	public class DuplicateEntryDetailsModelCommand extends KedCommand {
		
		override public function execute(event:KMvCEvent):void
		{
			KMvCModel.addModel();
		}
	}
}