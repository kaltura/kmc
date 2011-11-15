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
			
//			var newEntryDetailsModel:EntryDetailsModel = new EntryDetailsModel();
//			// copy permissions and general info stuff
//			newEntryDetailsModel.remoteStorageEnabled = _model.entryDetailsModel.remoteStorageEnabled;
//			newEntryDetailsModel.conversionProfileLoaded = _model.entryDetailsModel.conversionProfileLoaded;
//			newEntryDetailsModel.conversionProfiles = _model.entryDetailsModel.conversionProfiles;
//			newEntryDetailsModel.enableThumbResize = _model.entryDetailsModel.enableThumbResize;
//			// we open another drilldown, should add another model
//			_model.entryDetailsModelsArray.push(newEntryDetailsModel);
		}
	}
}