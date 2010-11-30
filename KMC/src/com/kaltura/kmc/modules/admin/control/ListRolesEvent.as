package com.kaltura.kmc.modules.admin.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRoleFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	public class ListRolesEvent extends CairngormEvent {
		
		public static const LIST_ROLES:String = "admin_listRoles";
		
		private var _filter:KalturaRoleFilter;
		private var _pager:KalturaFilterPager;
		
		public function ListRolesEvent(type:String, filter:KalturaRoleFilter = null, pager:KalturaFilterPager = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_filter = filter;
			_pager = pager;
			
		}
		
		public function get filter():KalturaRoleFilter
		{
			return _filter;
		}
		
		public function get pager():KalturaFilterPager
		{
			return _pager;
		}

	}
}