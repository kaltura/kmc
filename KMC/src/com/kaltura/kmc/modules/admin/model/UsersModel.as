package com.kaltura.kmc.modules.admin.model
{
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRole;
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
		public var newRole:KalturaRole;
		
		
		/**
		 * all partner's permissions uiconf 
		 */
		public var partnerPermissions:XML;
		
	}
}