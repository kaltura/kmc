package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.syndicationFeed.SyndicationFeedList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.vo.ExternalSyndicationVO;
	import com.kaltura.vo.KalturaBaseSyndicationFeed;
	import com.kaltura.vo.KalturaBaseSyndicationFeedListResponse;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaGenericSyndicationFeed;
	import com.kaltura.vo.KalturaGenericXsltSyndicationFeed;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	public class ListExternalSyndicationsCommand extends KalturaCommand implements ICommand, IResponder
	{

		override public function execute(event:CairngormEvent):void
		{
			_model.increaseLoadCounter();
			var kfp:KalturaFilterPager = _model.extSynModel.syndicationFeedsFilterPager;
			if (event.data is KalturaFilterPager) {
				kfp = event.data;
			}
			var listFeeds:SyndicationFeedList = new SyndicationFeedList(_model.extSynModel.syndicationFeedsFilter, kfp);
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
			
			for each(var feed:Object in response.objects)
			{
				if (feed is KalturaBaseSyndicationFeed) {
					if (feed is KalturaGenericSyndicationFeed && !(feed is KalturaGenericXsltSyndicationFeed)) {
						// in KMC we only support the xslt generic type 
						continue;
					}
					var exSyn:ExternalSyndicationVO = new ExternalSyndicationVO();
					exSyn.kSyndicationFeed = feed as KalturaBaseSyndicationFeed;
					tempArr.addItem(exSyn);
				}
			}
			_model.extSynModel.externalSyndicationData = tempArr;
		}
	}
}