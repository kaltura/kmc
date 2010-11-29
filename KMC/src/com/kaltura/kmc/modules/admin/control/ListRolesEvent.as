package com.kaltura.kmc.modules.admin.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ListRolesEvent extends CairngormEvent {
		
		public static const LIST_ROLES:String = "admin_listRoles";
		
		public function ListRolesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}