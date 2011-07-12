package com.kaltura.kmc.modules.content.commands.captions
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.uploadToken.UploadTokenAdd;
	import com.kaltura.commands.uploadToken.UploadTokenUpload;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.commands.KalturaCommand;
	import com.kaltura.kmc.modules.content.events.CaptionsEvent;
	import com.kaltura.kmc.modules.content.vo.EntryCaptionVO;
	import com.kaltura.vo.KalturaUploadToken;
	
	import flash.net.FileReference;

	public class UploadCaptionCommand extends KalturaCommand
	{
		private var _fr:FileReference;
		private var _caption:EntryCaptionVO;
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			_fr = (event as CaptionsEvent).fr;
			_caption = (event as CaptionsEvent).caption;
			var uploadToken:KalturaUploadToken = new KalturaUploadToken();
			var uploadTokenAdd:UploadTokenAdd = new UploadTokenAdd(uploadToken);
			
			uploadTokenAdd.addEventListener(KalturaEvent.COMPLETE, uploadTokenAddHandler);
			uploadTokenAdd.addEventListener(KalturaEvent.FAILED, fault);
			_model.context.kc.post(uploadTokenAdd);
		}
		
		private function uploadTokenAddHandler(event:KalturaEvent):void {
			var result:KalturaUploadToken = event.data as KalturaUploadToken;
			if (result) {
				_caption.uploadTokenId = result.id;
				_caption.downloadUrl = null;
				var uploadTokenUpload:UploadTokenUpload = new UploadTokenUpload(result.id, _fr);
				uploadTokenUpload.addEventListener(KalturaEvent.FAILED, fault);
				
				_model.context.kc.post(uploadTokenUpload);
			}
			_model.decreaseLoadCounter();
		}
	}
}