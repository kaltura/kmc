package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.events.MetadataProfileEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class ReorderMetadataFieldCommand implements ICommand
	{

		private var _model:KMCModelLocator = KMCModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void 
		{
			try {
				_model.metadataProfile.xsd = MetadataProfileParser.fromArrayToXSD(_model.metadataProfile.metadataFieldVOArray);
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
