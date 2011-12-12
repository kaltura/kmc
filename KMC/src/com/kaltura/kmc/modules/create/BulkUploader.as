package com.kaltura.kmc.modules.create
{
	import com.kaltura.KalturaClient;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.bulkUpload.BulkUploadAdd;
	import com.kaltura.errors.KalturaError;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.edw.model.types.APIErrorCode;
	import com.kaltura.types.KalturaBulkUploadType;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	import mx.validators.EmailValidator;
	
	import mx.core.mx_internal;

	public class BulkUploader extends EventDispatcher {
		
		
		private var _client:KalturaClient;
		
		/**
		 * file reference object for bulk uploads
		 * */
		private var _bulkUpldFileRef:FileReference;
		
		public function BulkUploader(client:KalturaClient) {
			super(this);
			_client = client;
		}

		/**
		 * Opens a desktop file selection pop-up, allowing csv/xml files selection
		 * */
		public function doUpload():void {
			_bulkUpldFileRef = new FileReference();
			_bulkUpldFileRef.addEventListener(Event.SELECT, addBulkUpload);
			_bulkUpldFileRef.browse(getBulkUploadFilter());
		}
		
		
		protected function addBulkUpload(event:Event):void {
			var defaultConversionProfileId:int = -1;
			// pass in xml or csv file type
			var kbu:BulkUploadAdd = new BulkUploadAdd(defaultConversionProfileId, _bulkUpldFileRef, getUploadType(_bulkUpldFileRef.name));
			kbu.addEventListener(KalturaEvent.COMPLETE, bulkUploadCompleteHandler);
			kbu.addEventListener(KalturaEvent.FAILED, bulkUploadCompleteHandler);
			kbu.queued = false;
			_client.post(kbu);
		}
		
		/**
		 * create the list of optional file types for bulk upload
		 * */
		protected function getBulkUploadFilter():Array {
			var types:Array = [new FileFilter(ResourceManager.getInstance().getString('create', 'file_types'), "*.csv;*.xml")];
			return types;
		}
		
		/**
		 * get upload type (csv / xml) by file extension
		 * */
		protected function getUploadType(url:String):String {
			var ext:String = url.substring(url.length - 3);
			ext = ext.toLowerCase();
			if (ext == "csv") {
				return KalturaBulkUploadType.CSV;
			}
			return KalturaBulkUploadType.XML;
		}
		
		
		
		protected function bulkUploadCompleteHandler(e:KalturaEvent):void {
			var er:KalturaError = e.error;
			if (!er)  {
				var string:String = ResourceManager.getInstance().getString('create', 'bulk_submitted');
				var alert:Alert = Alert.show(string);
				alert.mx_internal::alertForm.mx_internal::textField.htmlText = string;

				// dispatch complete event
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			if (er.errorCode == APIErrorCode.INVALID_KS) {
				JSGate.expired();
			}
			else if (er.errorCode == APIErrorCode.SERVICE_FORBIDDEN) {
				// added the support of non closable window
				Alert.show(ResourceManager.getInstance().getString('common','forbiddenError',[er.errorMsg]), 
					ResourceManager.getInstance().getString('create', 'forbiden_error_title'), Alert.OK, null, logout);
			}
			else if (er.errorMsg) {
				Alert.show(er.errorMsg, ResourceManager.getInstance().getString('common', 'error'));
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