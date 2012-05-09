package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.business.FileManager;
	import com.kaltura.kmc.modules.content.vo.FilterVO;

	public class BulkEvent extends CairngormEvent
	{
		
		/**
		 * upload a csv of category users
		 * event.data is fileReference
		 */
		public static const BULK_UPLOAD_CATEGORY_USERS : String = "content_bulkUploadCategoryUsers";
		
		/**
		 * upload a csv of categories
		 * event.data is fileReference
		 */
		public static const BULK_UPLOAD_CATEGORIES : String = "content_bulkUploadCategories";
		
		
		public static const LIST_BULK_UPLOAD : String = "content_listBulkUpload";
		
		/**
		 * use the <code>event.data</code> for object id 
		 */		
		public static const DELETE_BULK_UPLOAD : String = "content_deleteBulkUpload";
		
		/**
		 * filter for list actions
		 */
		public var filterVO:FilterVO;
		
		public function BulkEvent(type:String, filterVO:FilterVO = null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.filterVO = filterVO;
		}	
	}
}