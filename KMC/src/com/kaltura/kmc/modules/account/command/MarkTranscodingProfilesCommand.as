package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.events.ConversionSettingsEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.kmc.modules.account.vo.ConversionProfileVO;
	
	public class MarkTranscodingProfilesCommand implements ICommand
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			for each(var profile:ConversionProfileVO in _model.conversionData)
			{
				profile.selected = (event as ConversionSettingsEvent).selected;
			} 
		}
	
	}
}