package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.ExternalSyndicationEvent;
	import com.kaltura.kmc.modules.content.vo.ExternalSyndicationVO;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	
	public class MarkExternalSyndicationCommand extends KalturaCommand implements ICommand
	{
		override public function execute(event:CairngormEvent):void
		{
			for each(var excSyn:ExternalSyndicationVO in _model.extSynModel.externalSyndicationData)
			{
				excSyn.selected = (event as ExternalSyndicationEvent).selected;
			}
		}
	
	}
}