package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.events.ConversionSettingsEvent;
	import com.kaltura.kmc.modules.account.model.KMCModelLocator;
	import com.kaltura.kmc.modules.account.vo.FlavorVO;
	
	public class MarkFlavorsCommand implements ICommand
	{
		private var _model : KMCModelLocator = KMCModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			for each(var flavor:FlavorVO in _model.flavorsData)
			{
				flavor.selected = (event as ConversionSettingsEvent).selected;
			} 
		}
	
	}
}