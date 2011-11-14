package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.analytics.GoogleAnalyticsConsts;
	import com.kaltura.analytics.GoogleAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTracker;
	import com.kaltura.analytics.KAnalyticsTrackerConsts;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.baseEntry.BaseEntryApprove;
	import com.kaltura.commands.baseEntry.BaseEntryReject;
	import com.kaltura.edw.control.events.SearchEvent;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.control.KedController;
	import com.kaltura.kmc.modules.content.events.CategoryEvent;
	import com.kaltura.kmc.modules.content.events.ModerationsEvent;
	import com.kaltura.types.KalturaStatsKmcEventType;
	import com.kaltura.vo.KalturaBaseEntry;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
    
   
    
	public class UpdateEntryModerationCommand extends KalturaCommand implements ICommand, IResponder
	{
		private var moderationType:int;
		 
		override public function execute(event:CairngormEvent):void
		{
			var entriesToUpdate:Array = (event as ModerationsEvent).entries;
		    moderationType = (event as ModerationsEvent).moderationType;
			
			// ps3 implementation
			if(entriesToUpdate.length == 0)
			{
				Alert.show( ResourceManager.getInstance().getString('cms','pleaseSelectEntriesFirst') , 
							ResourceManager.getInstance().getString('cms','pleaseSelectEntriesFirstTitle') );
				return;
			}
			
				
			var mr:MultiRequest = new MultiRequest();
			var i:uint;
			if (moderationType == ModerationsEvent.APPROVE) {
				// approve
				for(i=0; i<entriesToUpdate.length;i++)
				{
	        		var aproveEntry:BaseEntryApprove = new BaseEntryApprove((entriesToUpdate[i] as KalturaBaseEntry).id);
					mr.addAction(aproveEntry);
				}
			}
			else if (moderationType == ModerationsEvent.REJECT) {
				// reject
				for( i = 0; i<entriesToUpdate.length;i++)
				{
	        		var reject:BaseEntryReject = new BaseEntryReject((entriesToUpdate[i] as KalturaBaseEntry).id);
					mr.addAction(reject);
				}
			}
			
			
			// reset the array
			_model.moderationModel.moderationsArray.source = [];
			
			mr.addEventListener(KalturaEvent.COMPLETE,result);
			mr.addEventListener(KalturaEvent.FAILED,fault);

			_model.increaseLoadCounter();
			_model.context.kc.post(mr);
			
		}
			

		
		override public function result(data:Object):void
		{
			super.result(data);
			_model.decreaseLoadCounter();
			var searchEvent : SearchEvent = new SearchEvent(SearchEvent.SEARCH_ENTRIES , _model.listableVo  );
			KedController.getInstance().dispatch(searchEvent);
			
			var categoriesEvent:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORIES);
			categoriesEvent.dispatch();
			

			//dispatching - single dispatch for each entry
			if(moderationType)
			{
				switch(moderationType){
					case (1):
					for each (var baseEntryApprove:BaseEntryApprove in data.currentTarget.actions )
					{
						GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_APPROVE_MODERATION+"/entry_id="+baseEntryApprove.args.entryId,GoogleAnalyticsConsts.CONTENT);
				        KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT,KalturaStatsKmcEventType.CONTENT_APPROVE_MODERATION,
																  "Moderation>ApproveSelected");
					}
					break;
					case(2):
					for each (var baseEntryReject:BaseEntryReject in data.currentTarget.actions )
					{
				    	GoogleAnalyticsTracker.getInstance().sendToGA(GoogleAnalyticsConsts.CONTENT_REJECT_MODERATION+"/entry_id="+baseEntryReject.args.entryId,GoogleAnalyticsConsts.CONTENT);
						KAnalyticsTracker.getInstance().sendEvent(KAnalyticsTrackerConsts.CONTENT,KalturaStatsKmcEventType.CONTENT_REJECT_MODERATION,
															  "Moderation>RejectSelected");
					}
					break;
				}
			}
		}
	}
}	
