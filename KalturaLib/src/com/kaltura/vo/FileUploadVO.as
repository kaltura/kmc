package com.kaltura.vo
{
	import flash.net.FileReference;
	
	import mx.utils.UIDUtil;

	[Bindable]
	/**
	 * Represents a file being uploaded via FileUploadManager. 
	 * @author Atar
	 */
	public class FileUploadVO {
		
		// optional actions with vo after upload
		public static const ACTION_ADD:String = "action_add";
		public static const ACTION_UPDATE:String = "action_update";
		public static const ACTION_NONE:String = "action_none";
		
		
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
		 * the id of the entry to which this asset belongs, passed as parameter.
		 */
		public var entryId:String; 
		
		/**
		 * used to decide when all assets of a given entry have finished uploading.
		 */
		public var groupId:String;
		
		/**
		 * used when replacing flavors, passed as parameter.
		 */
		public var flavorParamsId:String;
		
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
		 * requested action, represented as consts (add / update / none).  These will be used for 
		 * completing the upload process, i.e. linking the uploaded file with the relevant entry.
		 */
		public var action:String;
		
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
		

	}
}