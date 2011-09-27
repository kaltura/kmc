package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	public class ChangeSyndicationFeedsFilterOrderCommand extends KalturaCommand implements ICommand {
		
		
		override public function execute(event:CairngormEvent):void
		{
			_model.extSynModel.syndicationFeedsFilter.orderBy = event.data;
		}
	}
}