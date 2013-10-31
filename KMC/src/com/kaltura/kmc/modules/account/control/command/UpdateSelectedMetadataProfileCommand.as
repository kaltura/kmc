package com.kaltura.kmc.modules.account.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.control.events.MetadataProfileEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;

	public class UpdateSelectedMetadataProfileCommand implements ICommand
	{
		
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void {
			_model.selectedMetadataProfile = (event as MetadataProfileEvent).profile;
			_model.selectedMetadataProfile.isCurrentlyEdited = true;
		}
		
	}
}