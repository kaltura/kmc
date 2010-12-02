package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.MetadataProfileEvent;
	import com.kaltura.kmc.modules.account.events.MetadataFieldEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.MetadataFieldVO;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class EditMetadataFieldCommand implements ICommand
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var editFields:Array = MetadataFieldEvent(event).metadataFields;
			if (!editFields)
				return;
			if (!_model.metadataProfile.xsd) {
				_model.metadataProfile.xsd = MetadataProfileParser.createNewXSD();
			}
			
			try {
				for each (var field:MetadataFieldVO in editFields) {
					MetadataProfileParser.updateFieldOnXSD(field, _model.metadataProfile.xsd);
				}
			}
			catch (e:Error){
				Alert.show(ResourceManager.getInstance().getString('account','metadataMalformedXSDError'), ResourceManager.getInstance().getString('account','error'));
				return;
			}
			
			var updateMetadataProfile:MetadataProfileEvent = new MetadataProfileEvent(MetadataProfileEvent.UPDATE);
			updateMetadataProfile.dispatch();
		}
	}
}