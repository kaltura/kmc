package com.kaltura.edw.control.commands.flavor
{
	import com.kaltura.commands.flavorAsset.FlavorAssetGetUrl;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class DownloadFlavorAsset extends KedCommand
	{
		override public function execute(event:KMvCEvent):void
		{		
		 	_model.increaseLoadCounter();
		 	var obj:KalturaFlavorAssetWithParams = event.data as KalturaFlavorAssetWithParams;
			var downloadCommand:FlavorAssetGetUrl = new FlavorAssetGetUrl(obj.flavorAsset.id);
            downloadCommand.addEventListener(KalturaEvent.COMPLETE, result);
	        downloadCommand.addEventListener(KalturaEvent.FAILED, fault);
    	    _client.post(downloadCommand);  
		}
		
		override public function result(event:Object):void
		{
			super.result(event);
 			_model.decreaseLoadCounter();
 			var downloadUrl:String = event.data;
			var urlRequest:URLRequest = new URLRequest(downloadUrl);
            navigateToURL(urlRequest, "downloadURL");
		}
	}
}
