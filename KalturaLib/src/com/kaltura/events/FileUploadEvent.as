package com.kaltura.events {
	import flash.events.Event;

	/**
	 * Events concerning file upload process 
	 * @author Atar
	 */
	public class FileUploadEvent extends Event {

		/**
		 * defines the value for the "type" property of the upload canceled event
		 */
		public static const UPLOAD_CANCELED:String = "upload_cacnceled";

		/**
		 * defines the value for the "type" property of the upload complete event
		 */
		public static const UPLOAD_COMPLETE:String = "upload_complete";
		
		/**
		 * defines the value for the "type" property of the group upload complete event
		 */
		public static const GROUP_UPLOAD_COMPLETE:String = "group_upload_complete";
		
		/**
		 * defines the value for the "type" property of the group upload complete event
		 */
		public static const GROUP_UPLOAD_STARTED:String = "group_upload_started";
		
		

		private var _uploadid:String;


		public function FileUploadEvent(type:String, uploadid:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_uploadid = uploadid;
		}


		public function get uploadid():String {
			return _uploadid;
		}

	}
}