package com.kaltura.kmc.modules.add
{
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.bulkUpload.BulkUploadAdd;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.model.types.APIErrorCode;
	
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class BulkUploader {
		
		
		private var _client:KalturaClient;
		
		/**
		 * file reference object for bulk uploads
		 * */
		private var _bulkUpldFileRef:FileReference;
		
		public function BulkUploader(client:KalturaClient) {
			_client = client;
		}

		/**
		 * Opens a desktop file selection pop-up, allowing csv/xml files selection
		 * */
		public function doUpload():void {
			_bulkUpldFileRef = new FileReference();
			_bulkUpldFileRef.addEventListener(Event.SELECT, addBulkUpload);
			_bulkUpldFileRef.browse(getBulkUploadTypes());
		}
		
		
		protected function addBulkUpload(event:Event):void {
			//TODO use new API action ?
			var defaultConversionProfileId:int = 458321;
			var kbu:BulkUploadAdd = new BulkUploadAdd(defaultConversionProfileId, _bulkUpldFileRef);
			kbu.addEventListener(KalturaEvent.COMPLETE, bulkUploadCompleteHandler);
			kbu.addEventListener(KalturaEvent.FAILED, bulkUploadCompleteHandler);
			kbu.queued = false;
			_client.post(kbu);
		}
		
		/**
		 * create the list of optional file types for bulk upload
		 * */
		protected function getBulkUploadTypes():Array {
			var types:Array = [new FileFilter(ResourceManager.getInstance().getString('create', 'file_types'), "*.csv;*.xml")];
			return types;
		}
		
		
		
		
		
		protected function bulkUploadCompleteHandler(e:KalturaEvent):void {
			var er:KalturaError = e.error;
			if (!er) return;
			if (er.errorCode == APIErrorCode.INVALID_KS) {
				JSGate.expired();
			}
			else if (er.errorCode == APIErrorCode.SERVICE_FORBIDDEN) {
				// added the support of non closable window
				Alert.show(ResourceManager.getInstance().getString('create','forbiddenError',[er.errorMsg]), 
					ResourceManager.getInstance().getString('create', 'forbiden_error_title'), Alert.OK, null, logout);
			}
			else if (er.errorMsg) {
				var alert:Alert = Alert.show(er.errorMsg, ResourceManager.getInstance().getString('create', 'error'));
			}
		}
		
		/**
		 * logout from KMC
		 * */
		protected function logout(e:Object):void {
			JSGate.expired();
		}
	}
}