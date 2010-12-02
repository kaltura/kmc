package com.kaltura.kmc.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.account.events.ExternalSyndicationEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.modules.account.vo.ExternalSyndicationVO;
	
	public class MarkExternalSyndicationCommand implements ICommand
	{
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			for each(var excSyn:ExternalSyndicationVO in _model.partnerData.externalSyndicationData)
			{
				excSyn.selected = (event as ExternalSyndicationEvent).selected;
			}
		}
	
	}
}