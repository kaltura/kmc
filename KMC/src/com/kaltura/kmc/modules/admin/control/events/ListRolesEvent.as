package com.kaltura.kmc.modules.admin.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.vo.KalturaFilterPager;
	import com.kaltura.vo.KalturaUserRoleFilter;
	
	public class ListRolesEvent extends CairngormEvent {
		
		public static const LIST_ROLES:String = "admin_listRoles";
		
		private var _filter:KalturaUserRoleFilter;
		private var _pager:KalturaFilterPager;
		
		public function ListRolesEvent(type:String, filter:KalturaUserRoleFilter = null, pager:KalturaFilterPager = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_filter = filter;
			_pager = pager;
			
		}
		
		public function get filter():KalturaUserRoleFilter
		{
			return _filter;
		}
		
		public function get pager():KalturaFilterPager
		{
			return _pager;
		}

	}
}