package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.flavorAsset.FlavorAssetGetDownloadUrl;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.vo.KalturaFlavorAssetWithParams;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.rpc.IResponder;
	
	public class DownloadFlavorAsset extends KalturaCommand implements ICommand, IResponder
	{
		override public function execute(event:CairngormEvent):void
		{		
		 	_model.increaseLoadCounter();
		 	var obj:KalturaFlavorAssetWithParams = event.data as KalturaFlavorAssetWithParams;
			var downloadCommand:FlavorAssetGetDownloadUrl = new FlavorAssetGetDownloadUrl(obj.flavorAsset.id);
            downloadCommand.addEventListener(KalturaEvent.COMPLETE, result);
	        downloadCommand.addEventListener(KalturaEvent.FAILED, fault);
    	    _model.context.kc.post(downloadCommand);  
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