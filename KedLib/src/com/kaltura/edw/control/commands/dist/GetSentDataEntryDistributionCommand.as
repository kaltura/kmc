package com.kaltura.edw.control.commands.dist
{
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.EntryDistributionEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaEntryDistribution;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class GetSentDataEntryDistributionCommand extends KedCommand
	{
		override public function execute(event:KMvCEvent):void {
			var entryDis:KalturaEntryDistribution = (event as EntryDistributionEvent).entryDistribution;
			var stringURL:String = _client.protocol + _client.domain + '/api_v3/index.php/service/contentDistribution_entryDistribution/action/serveSentData/actionType/1/id/' +
				entryDis.id + '/ks/' + _client.ks;
			var urlRequest:URLRequest = new URLRequest(stringURL);
			navigateToURL(urlRequest , '_self');
		}
	}
}