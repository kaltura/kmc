package com.kaltura.edw.control.commands
{
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.commands.uploadToken.UploadTokenAdd;
	import com.kaltura.commands.uploadToken.UploadTokenUpload;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.edw.control.events.UploadTokenEvent;
	import com.kaltura.edw.vo.AssetVO;
	import com.kaltura.vo.KalturaUploadToken;
	
	import flash.net.FileReference;
	import com.kaltura.edw.control.commands.KedCommand;

	/**
	 * This class will start an upload using uploadToken service. will save the token
	 * on the given object 
	 * @author Michal
	 * 
	 */	
	public class UploadTokenCommand extends KedCommand
	{
		private var _fr:FileReference;
		private var _asset:AssetVO;
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			_fr = (event as UploadTokenEvent).fileReference
			_asset = (event as UploadTokenEvent).assetVo;
			
			var uploadToken:KalturaUploadToken = new KalturaUploadToken();
			var uploadTokenAdd:UploadTokenAdd = new UploadTokenAdd(uploadToken);
			
			uploadTokenAdd.addEventListener(KalturaEvent.COMPLETE, uploadTokenAddHandler);
			uploadTokenAdd.addEventListener(KalturaEvent.FAILED, fault);
			_client.post(uploadTokenAdd);
		}
		
		private function uploadTokenAddHandler(event:KalturaEvent):void {
			var result:KalturaUploadToken = event.data as KalturaUploadToken;
			if (result) {
				_asset.uploadTokenId = result.id;
				//_caption.downloadUrl = null;
				var uploadTokenUpload:UploadTokenUpload = new UploadTokenUpload(result.id, _fr);
				uploadTokenUpload.queued = false;
				uploadTokenUpload.useTimeout = false;
				uploadTokenUpload.addEventListener(KalturaEvent.FAILED, fault);
				
				_client.post(uploadTokenUpload);
			}
			_model.decreaseLoadCounter();
		}
	}
}