package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.events.MetadataProfileEvent;
	import com.kaltura.kmc.modules.account.events.MetadataFieldEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KalturaMetadataProfile;
	import com.kaltura.vo.MetadataFieldVO;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	/**
	 * This class handles the addition of a new metadata field
	 *  
	 * @author Michal
	 * 
	 */	
	public class AddMetadataFieldCommand implements ICommand
	{	
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();

		/**
		 * Will be triggered when the suitable event will be dispatched.
		 * Then will add the saved field thats on the event to the current metadata profile 
		 * @param event the event that triggered this command
		 * 
		 */	
		public function execute(event:CairngormEvent):void
		{
			var newFields:Array = MetadataFieldEvent(event).metadataFields;
			if (!newFields)
				return;
			if (!_model.metadataProfile.xsd) {
				_model.metadataProfile.xsd = MetadataProfileParser.createNewXSD();
			}
			
			try {
				for each (var field:MetadataFieldVO in newFields) {
					MetadataProfileParser.addToXSD(field, _model.metadataProfile.xsd);	
				}
			}
			catch (e:Error){
				Alert.show(ResourceManager.getInstance().getString('account','metadataMalformedXSDError'), ResourceManager.getInstance().getString('kmc','error'));
				return;
			}

			if (_model.metadataProfile.profile) {
				var updateMetadataProfile:MetadataProfileEvent = new MetadataProfileEvent(MetadataProfileEvent.UPDATE);
				updateMetadataProfile.dispatch();
			}
			else {
				var addMetadataProfile:MetadataProfileEvent = new MetadataProfileEvent(MetadataProfileEvent.ADD);
				addMetadataProfile.dispatch();
			}
			
		}
		
	}
}