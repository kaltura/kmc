package com.kaltura.kmc.modules.admin.model
{
	import com.kaltura.types.KalturaUserOrderBy;
	import com.kaltura.types.KalturaUserStatus;
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.vo.KalturaUserFilter;
	import com.kaltura.vo.KalturaUserRole;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class UsersModel {
		
		public function UsersModel() {
			// init filter - only admin users who have access to KMC and are either active or blocked.
			usersFilter = new KalturaUserFilter();
			usersFilter.isAdminEqual = true;
			usersFilter.loginEnabledEqual = true;
			usersFilter.statusIn = KalturaUserStatus.ACTIVE + "," + KalturaUserStatus.BLOCKED;
//TODO	+		filter.orderBy = KalturaUserOrderBy.
		}
		
		/**
		 * the active user entry.
		 * */
		public var selectedUser:KalturaUser;
		
		[ArrayElementType("KalturaUser")]
		/**
		 * a list of all users (KalturaUser objects)
		 * */
		public var users:ArrayCollection;
		
		/**
		 * total number of users as indicated by list result 
		 */		
		public var totalUsers:int;
		
		/**
		 * total number of users the partner may use 
		 */
		public var loginUsersQuota:int;
		//TODO hook
		
		/**
		 * the filter used for listing users. 
		 */		
		public var usersFilter:KalturaUserFilter;
		
		/**
		 * link to upgrade page on corp website
		 * */
		public var usersUpgradeLink:String;
		
		/**
		 * user drilldown mode, either <code>DrilldownMode.ADD</code>, 
		 * <code>DrilldownMode.EDIT</code> or <code>DrilldownMode.NONE</code>.
		 * */
		public var drilldownMode:String = DrilldownMode.NONE;
		
		/**
		 * role drilldown mode when opened from this screen, either <code>DrilldownMode.ADD</code>, 
		 * <code>DrilldownMode.EDIT</code> or <code>DrilldownMode.NONE</code>.
		 * */
		public var roleDrilldownMode:String = DrilldownMode.NONE;
		
		
		/**
		 * when creating a new role from the user drilldown, need to pass  
		 * the KalturaUserRole returned from the server back to the user drilldown   
		 * window via the model. 
		 */		
		public var newRole:KalturaUserRole;
		
	}
}