package com.kaltura.kmc.modules.admin.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	public class ListItemsEvent extends CairngormEvent {
		
		public static const LIST_ROLES:String = "admin_listRoles";
		public static const LIST_USERS:String = "admin_listUsers";
		public static const LIST_PARTNER_PERMISSIONS:String = "admin_listPartnerPermissions";
		
		private var _filter:KalturaFilter;
		private var _pager:KalturaFilterPager;
		
		
		public function ListItemsEvent(type:String, filter:KalturaFilter = null, pager:KalturaFilterPager = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_filter = filter;
			_pager = pager;
		}

		public function get filter():KalturaFilter
		{
			return _filter;
		}

		public function get pager():KalturaFilterPager
		{
			return _pager;
		}


	}
}