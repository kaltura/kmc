package com.kaltura.edw.control.commands.cuepoints
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	public class DownloadCuePoints extends KalturaCommand {
		
		override public function execute(event:CairngormEvent):void
		{
//			http://devtests.kaltura.co.cc/api_v3/index.php/service/cuepoint_cuepoint/action/serveBulk/filter:entryIdEqual/0_sfdsfsf/pager:pageSize/1000/ks/NzU1Zm
			var serveURL:String = "/api_v3/index.php/service/cuepoint_cuepoint/action/serveBulk";
			var fp:String = "/filter:entryIdEqual/" + event.data + "/filter:orderBy/+startTime/pager:pageSize/1000";
			var filePath:String = _model.context.kc.protocol + _model.context.kc.domain + serveURL + fp + "/ks/" + _model.context.kc.ks;
			var request:URLRequest = new URLRequest(filePath);
			var fr:FileReference = new FileReference();
			fr.addEventListener(Event.CANCEL, downloadHandler);
			fr.addEventListener(Event.COMPLETE, downloadHandler);
			fr.addEventListener(IOErrorEvent.IO_ERROR, downloadHandler);
			fr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, downloadHandler);
			fr.download(request, 'cuepoints_'+event.data+'.xml');
			
		}
		
		
		
		private function downloadHandler(e:Event):void {
			e.target.removeEventListener(Event.CANCEL, downloadHandler);
			e.target.removeEventListener(Event.COMPLETE, downloadHandler);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, downloadHandler);
			e.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, downloadHandler);
			if (e is IOErrorEvent || e is SecurityErrorEvent) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'downloadFailed'));
			}
		}
		
	}
}