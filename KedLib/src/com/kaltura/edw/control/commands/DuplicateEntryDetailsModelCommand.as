package com.kaltura.edw.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.model.EntryDetailsModel;
	import com.kaltura.edw.control.commands.KalturaCommand;

	public class DuplicateEntryDetailsModelCommand extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
			var newEntryDetailsModel:EntryDetailsModel = new EntryDetailsModel();
			// copy permissions and general info stuff
			newEntryDetailsModel.remoteStorageEnabled = _model.entryDetailsModel.remoteStorageEnabled;
			newEntryDetailsModel.conversionProfileLoaded = _model.entryDetailsModel.conversionProfileLoaded;
			newEntryDetailsModel.conversionProfiles = _model.entryDetailsModel.conversionProfiles;
			newEntryDetailsModel.enableThumbResize = _model.entryDetailsModel.enableThumbResize;
			// we open another drilldown, should add another model
			_model.entryDetailsModelsArray.push(newEntryDetailsModel);
		}
	}
}