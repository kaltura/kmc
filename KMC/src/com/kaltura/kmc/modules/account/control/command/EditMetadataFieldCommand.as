package com.kaltura.kmc.modules.account.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.control.events.MetadataFieldEvent;
	import com.kaltura.kmc.modules.account.control.events.MetadataProfileEvent;
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
			var editField:MetadataFieldVO = (event as MetadataFieldEvent).metadataField;
			if (!_model.selectedMetadataProfile || !editField)
				return;
			
			if (!_model.selectedMetadataProfile.xsd) {
				_model.selectedMetadataProfile.xsd = MetadataProfileParser.createNewXSD();
			}
			
			try {
				MetadataProfileParser.updateFieldOnXSD(editField, _model.selectedMetadataProfile.xsd);
			}
			catch (e:Error){
				Alert.show(ResourceManager.getInstance().getString('account','metadataMalformedXSDError'), ResourceManager.getInstance().getString('account','error'));
				return;
			}
			_model.selectedMetadataProfile.metadataProfileChanged = true;
		}
	}
}