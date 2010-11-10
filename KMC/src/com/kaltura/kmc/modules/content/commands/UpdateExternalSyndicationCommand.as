package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.ExternalSyndicationEvent;
	import com.kaltura.commands.syndicationFeed.SyndicationFeedUpdate;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBaseSyndicationFeed;
	
	import mx.rpc.IResponder;
	
	public class UpdateExternalSyndicationCommand extends KalturaCommand implements ICommand, IResponder
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var feed:KalturaBaseSyndicationFeed = event.data as KalturaBaseSyndicationFeed;
			var id:String = feed.id;
			feed.id = null;
			feed.type = int.MIN_VALUE;
			feed.feedUrl = null;
			feed.partnerId = int.MIN_VALUE;
			feed.status = int.MIN_VALUE;
			feed.createdAt = int.MIN_VALUE;
		
		 	var updateFeed:SyndicationFeedUpdate = new SyndicationFeedUpdate(id, feed);
		 	updateFeed.addEventListener(KalturaEvent.COMPLETE, result);
			updateFeed.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(updateFeed);	   
		}

		override public function result(data:Object):void
		{
			_model.decreaseLoadCounter();
			var feedListEvent:ExternalSyndicationEvent = new ExternalSyndicationEvent(ExternalSyndicationEvent.LIST_EXTERNAL_SYNDICATIONS);
			feedListEvent.dispatch();
		}

	}
}