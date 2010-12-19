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
			filter = new KalturaUserFilter();
			filter.isAdminEqual = true;
			filter.loginEnabledEqual = true;
			filter.statusIn = KalturaUserStatus.ACTIVE + "," + KalturaUserStatus.BLOCKED;
//TODO	+		filter.orderBy = KalturaUserOrderBy.
		}
		
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
		
		/**
		 * link to upgrade page on corp website
		 * */
		public var upgradeLink:String;
		
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
		 * array collection with all the roles this partner has
		 * (KalturaRole objects)
		 */		
		public var allRoles:ArrayCollection;
		
		
		/**
		 * when creating a new role from the user drilldown, need to pass  
		 * the KalturaRole returned from the server back to the user drilldown   
		 * window via the model. 
		 */		
		public var newRole:KalturaUserRole;
		
		
		/**
		 * all partner's permissions uiconf 
		 */
		public var partnerPermissions:XML;
		
		
	}
}