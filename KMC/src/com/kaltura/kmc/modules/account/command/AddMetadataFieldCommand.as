package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.events.MetadataFieldEvent;
	import com.kaltura.kmc.modules.account.events.MetadataProfileEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
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
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();

		/**
		 * Will be triggered when the suitable event will be dispatched.
		 * Then will add the saved field thats on the event to the current metadata profile 
		 * @param event the event that triggered this command
		 * 
		 */	
		public function execute(event:CairngormEvent):void
		{
			var newField:MetadataFieldVO = (event as MetadataFieldEvent).metadataField;
			if (!newField || !_model.selectedMetadataProfile)
				return;
			
			_model.selectedMetadataProfile.metadataFieldVOArray.addItem(newField);
			
			if (!_model.selectedMetadataProfile.xsd) {
				_model.selectedMetadataProfile.xsd = MetadataProfileParser.createNewXSD();
			}
			
			try {
				MetadataProfileParser.addToXSD(newField, _model.selectedMetadataProfile.xsd);	
			}
			catch (e:Error){
				Alert.show(ResourceManager.getInstance().getString('account','metadataMalformedXSDError'), ResourceManager.getInstance().getString('account','error'));
				return;
			}
			_model.selectedMetadataProfile.metadataProfileChanged = true;
		}
		
	}
}