package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.ExternalSyndicationVO;
	import com.kaltura.commands.syndicationFeed.SyndicationFeedList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaBaseSyndicationFeed;
	import com.kaltura.vo.KalturaBaseSyndicationFeedListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	public class ListExternalSyndicationsCommand extends KalturaCommand implements ICommand, IResponder
	{

		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var listFeeds:SyndicationFeedList = new SyndicationFeedList(_model.extSynModel.syndicationFeedsFilter, _model.extSynModel.syndicationFeedsFilterPager);
		 	listFeeds.addEventListener(KalturaEvent.COMPLETE, result);
			listFeeds.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(listFeeds);	  
		}
		
		override public function result(event:Object):void
		{
			super.result(event);
			_model.decreaseLoadCounter();
			var tempArr:ArrayCollection = new ArrayCollection();
			_model.extSynModel.externalSyndicationData.removeAll();
			var response:KalturaBaseSyndicationFeedListResponse = event.data as KalturaBaseSyndicationFeedListResponse;
			_model.extSynModel.externalSyndicationFeedsTotalCount = response.totalCount;
			
			for each(var feed:KalturaBaseSyndicationFeed in response.objects)
			{
				var exSyn:ExternalSyndicationVO = new ExternalSyndicationVO();
				exSyn.kSyndicationFeed = feed;
				tempArr.addItem(exSyn);
			}
			_model.extSynModel.externalSyndicationData = tempArr;
		}
		
//		override public function fault(event:Object):void
//		{
//			_model.decreaseLoadCounter();
//			var alert : Alert = Alert.show(event.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
//		}
	
	}
}