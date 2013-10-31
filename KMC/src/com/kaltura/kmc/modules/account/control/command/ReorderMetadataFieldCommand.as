package com.kaltura.kmc.modules.account.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.control.events.MetadataProfileEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class ReorderMetadataFieldCommand implements ICommand
	{

		private var _model:AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void 
		{
			if (!_model.selectedMetadataProfile)
				return;
			
			try {
				_model.selectedMetadataProfile.xsd = MetadataProfileParser.fromArrayToXSD(_model.selectedMetadataProfile.metadataFieldVOArray);
			}
			catch (e:Error){
				Alert.show(ResourceManager.getInstance().getString('account','metadataMalformedXSDError'), ResourceManager.getInstance().getString('account','error'));
				return;
			}
			
			_model.selectedMetadataProfile.metadataProfileReordered = true;
			_model.selectedMetadataProfile.metadataProfileChanged = true;
		}
	}
}
