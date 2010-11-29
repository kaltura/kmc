package com.kaltura.kmc.modules.admin.model
{
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.vo.KalturaUserFilter;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class UsersModel {
		
		/**
		 * the active user entry.
		 * */
		public var selectedUser:KalturaUser;
		
		/**
		 * a list of all users (KalturaUser objects)
		 * */
		public var users:ArrayCollection;
		
		/**
		 * total number of users as indicated by list result 
		 */		
		public var totalUsers:int;
		
		/**
		 * the filter used for listing users. 
		 */		
		public var filter:KalturaUserFilter;
		//TODO + filter by status - we don't want the deleted ones
		
		/**
		 * link to upgrade page on corp website
		 * */
		public var upgradeLink:String;
		
		/**
		 * user drilldown mode, either <code>UserDrilldownMode.ADD</code>, 
		 * <code>UserDrilldownMode.EDIT</code> or  <code>UserDrilldownMode.NONE</code>.
		 * */
		public var drilldownMode:String = UserDrilldownMode.NONE;
		
		
	}
}