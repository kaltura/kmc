package com.kaltura.kmc.modules.admin.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaUserFilter;
	
	public class ListUsersEvent extends CairngormEvent {
		
		public static const LIST_USERS:String = "admin_listUsers";
		
		private var _filter:KalturaUserFilter;
		private var _pager:KalturaFilterPager;
		
		
		public function ListUsersEvent(type:String, filter:KalturaUserFilter = null, pager:KalturaFilterPager = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_filter = filter;
			_pager = pager;
		}

		public function get filter():KalturaUserFilter
		{
			return _filter;
		}

		public function get pager():KalturaFilterPager
		{
			return _pager;
		}


	}
}