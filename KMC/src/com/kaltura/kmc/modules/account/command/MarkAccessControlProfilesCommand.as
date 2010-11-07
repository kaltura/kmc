package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.events.AccessControlProfileEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.vo.AccessControlProfileVO;
	
	public class MarkAccessControlProfilesCommand implements ICommand
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			for each(var profile:AccessControlProfileVO in _model.accessControlData)
			{
				profile.selected = (event as AccessControlProfileEvent).selected;
			}
		}
	
	}
}