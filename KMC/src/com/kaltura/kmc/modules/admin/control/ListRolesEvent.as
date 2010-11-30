package com.kaltura.kmc.modules.admin.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRoleFilter;
	import com.kaltura.vo.KalturaFilterPager;
	
	public class ListRolesEvent extends CairngormEvent {
		
		public static const LIST_ROLES:String = "admin_listRoles";
		
		public function ListRolesEvent(type:String, filter:KalturaRoleFilter = null, pager:KalturaFilterPager = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}