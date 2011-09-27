package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.syndicationFeed.SyndicationFeedAdd;
	import com.kaltura.commands.syndicationFeed.SyndicationFeedGetEntryCount;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.ExternalSyndicationEvent;
	import com.kaltura.kmc.modules.content.view.window.externalsyndication.popupwindows.ExternalSyndicationNotificationPopUpWindow;
	import com.kaltura.vo.KalturaBaseSyndicationFeed;
	import com.kaltura.vo.KalturaGenericXsltSyndicationFeed;
	import com.kaltura.vo.KalturaSyndicationFeedEntryCount;
	
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	public class AddNewExternalSyndicationCommand extends KalturaCommand implements ICommand, IResponder
	{
		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			
			var mr:MultiRequest = new MultiRequest();
			var newFeed:KalturaBaseSyndicationFeed = event.data as KalturaBaseSyndicationFeed;
		 	var addNewFeed:SyndicationFeedAdd = new SyndicationFeedAdd(newFeed);
		 	mr.addAction(addNewFeed);
		 	
		 	var countersAction:SyndicationFeedGetEntryCount = new SyndicationFeedGetEntryCount("{1:result:id}");
		 	mr.addAction(countersAction);
		 	
		 	mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(mr);	   
		}
		
		override public function result(data:Object):void
		{
			super.result(data);
			if (data.data[0] is KalturaBaseSyndicationFeed) 
			{
				if (!(data.data[0] is KalturaGenericXsltSyndicationFeed)) {	
					var extFeedPopUp:ExternalSyndicationNotificationPopUpWindow = new ExternalSyndicationNotificationPopUpWindow();
					extFeedPopUp.partnerData = _model.extSynModel.partnerData;
					extFeedPopUp.rootUrl = _model.context.rootUrl;
					extFeedPopUp.flavorParams = _model.filterModel.flavorParams;
		   			extFeedPopUp.feed = data.data[0] as KalturaBaseSyndicationFeed;
		   			extFeedPopUp.feedCountersData = data.data[1] as KalturaSyndicationFeedEntryCount;
					PopUpManager.addPopUp(extFeedPopUp, Application.application as DisplayObject, true);
					PopUpManager.centerPopUp(extFeedPopUp);
				} 
			}
			else if (data.data[0].error) {
				Alert.show(data.data[0].error.message, ResourceManager.getInstance().getString('cms','error'));
			}
			
			_model.decreaseLoadCounter();
			var getFeedsList:ExternalSyndicationEvent = new ExternalSyndicationEvent(ExternalSyndicationEvent.LIST_EXTERNAL_SYNDICATIONS);
			getFeedsList.dispatch();	
		}


	}
}