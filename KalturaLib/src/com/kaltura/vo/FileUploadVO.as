package com.kaltura.vo
{
	import com.kaltura.events.KalturaEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.FileReference;
	
	import mx.utils.UIDUtil;

	[Bindable]
	/**
	 * Represents a file being uploaded via FileUploadManager. 
	 * @author Atar
	 */
	public dynamic class FileUploadVO extends EventDispatcher {
		
		// optional file upload statuses
		public static const STATUS_UPLOADING:String = "status_uploading";
		public static const STATUS_QUEUED:String = "status_queued";
		public static const STATUS_FAILED:String = "status_failed";
		public static const STATUS_COMPLETE:String = "status_complete";
		
		
		protected var _id:String;
		
		public function FileUploadVO(){
			_id = generateUniqueId();
		}
		
		public var file:FileReference;
		
		/**
		 * file name, taken from the FileReference object
		 */
		public var name:String;
		
		/**
		 * upload added date (time), created when the VO is created
		 */
		public var uploadTime:Date;
		
		/**
		 * the id of the entry to which this asset belongs.
		 * passed as parameter.
		 */
		public var entryId:String; 
		
//		/**
//		 * used to decide when all assets of a given entry have finished uploading.
//		 */
//		public var groupId:String;
		
		/**
		 * (when adding assets to a new entry) flavorParamsId of the flavorparams to use. 
		 * passed as parameter.
		 */
		public var flavorParamsId:int;
		
		/**
		 * (when replacing a single flavor) flavorAssetId of the asset to be replaced.
		 * passed as parameter.
		 */
		public var flavorAssetId:String;
		
		/**
		 * file size, taken from the FileReference object
		 */
		public var fileSize:Number;
		
		/**
		 * const (uploading/queued/failed), updated as needed
		 */
		public var status:String = FileUploadVO.STATUS_QUEUED;
		
		/**
		 * load progress in percents
		 */
		public var progress:Number = 0;
		
		/**
		 * if upload failed, the error returned
		 */
		public var error:String;
		
		/**
		 * used upload token id
		 */
		public var uploadToken:String;
		
		/**
		 * the id of the conversion profile to use with this asset, if any. passed as parameter.
		 */
		public var conversionProfile:String;
		
		
		/**
		 * create a unique id for this vo
		 * @return vo id 
		 */
		protected function generateUniqueId():String {
			return UIDUtil.createUID();
		} 
		
		/**
		 * unique id of this file upload
		 */
		public function get id():String {
			return _id;
		}
		
		/**
		 * catch an event, and dispatch equal event with this VO as its target. 
		 * @param e
		 */
		public function bubbleEvent(e:KalturaEvent):void {
			(e.target as EventDispatcher).removeEventListener(KalturaEvent.COMPLETE, bubbleEvent);
			(e.target as EventDispatcher).removeEventListener(KalturaEvent.FAILED, bubbleEvent);
			var event:KalturaEvent = e.clone() as KalturaEvent;
			dispatchEvent(event);
		}
		

	}
}