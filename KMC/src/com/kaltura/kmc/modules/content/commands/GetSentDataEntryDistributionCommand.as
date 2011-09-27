package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.events.EntryDistributionEvent;
	import com.kaltura.vo.KalturaEntryDistribution;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class GetSentDataEntryDistributionCommand extends KalturaCommand
	{
		override public function execute(event:CairngormEvent):void {
			var entryDis:KalturaEntryDistribution = (event as EntryDistributionEvent).entryDistribution;
			var stringURL:String = _model.context.kc.protocol + _model.context.kc.domain + '/api_v3/index.php/service/contentDistribution_entryDistribution/action/serveSentData/actionType/1/id/' +
				entryDis.id + '/ks/' + _model.context.kc.ks;
			var urlRequest:URLRequest = new URLRequest(stringURL);
			navigateToURL(urlRequest , '_self');
		}
	}
}