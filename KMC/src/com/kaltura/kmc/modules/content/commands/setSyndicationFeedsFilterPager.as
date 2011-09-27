package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.kaltura.kmc.modules.content.events.SetSyndicationPagerEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	public class setSyndicationFeedsFilterPager extends KalturaCommand implements ICommand {
		
		
		override public function execute(event:CairngormEvent):void
		{
			_model.extSynModel.syndicationFeedsFilterPager = (event as SetSyndicationPagerEvent).pager;
		}
	}
}