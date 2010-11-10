package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.events.ExternalSyndicationEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.syndicationFeed.SyndicationFeedDelete;
	import com.kaltura.events.KalturaEvent;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class DeleteExternalSyndicationCommand extends KalturaCommand implements ICommand, IResponder
	{
			
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
		 	var mr:MultiRequest = new MultiRequest();
			for each (var id:String in event.data)
			{
				var deleteFeed:SyndicationFeedDelete = new SyndicationFeedDelete(id);
				mr.addAction(deleteFeed);
			}
					
            mr.addEventListener(KalturaEvent.COMPLETE, result);
            mr.addEventListener(KalturaEvent.FAILED, fault);
            _model.context.kc.post(mr); 
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			Alert.show(ResourceManager.getInstance().getString('cms', 'feedDeleteDoneMsg'));
			var getFeedsList:ExternalSyndicationEvent = new ExternalSyndicationEvent(ExternalSyndicationEvent.LIST_EXTERNAL_SYNDICATIONS);
			getFeedsList.dispatch();
		}
		
		
		

	}
}