package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.view.controls.FileManager;
	import com.kaltura.kmc.modules.content.vo.FilterVO;
	
	import flash.net.FileReference;

	public class BulkEvent extends CairngormEvent
	{
		public static const LIST_BULK_UPLOAD : String = "content_listBulkUpload";
		public static const ADD_BULK_UPLOAD : String = "content_addBulkUpload";
		
		public var filterVO : FilterVO;
		public var fm : FileManager;
		
		public function BulkEvent(type:String, filterVO : FilterVO = null, fm : FileManager = null ,bubbles:Boolean=false , cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.filterVO = filterVO;
			this.fm = fm;
		}	
	}
}