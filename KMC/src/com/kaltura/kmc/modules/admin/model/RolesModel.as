package com.kaltura.kmc.modules.admin.model
{
	import com.kaltura.types.KalturaPermissionStatus;
	import com.kaltura.types.KalturaPermissionType;
	import com.kaltura.types.KalturaUserRoleOrderBy;
	import com.kaltura.types.KalturaUserRoleStatus;
	import com.kaltura.vo.KalturaPermissionFilter;
	import com.kaltura.vo.KalturaUserRole;
	import com.kaltura.vo.KalturaUserRoleFilter;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class RolesModel {
		
		public function RolesModel(){
			// get only active roles (not deleted)
			rolesFilter = new KalturaUserRoleFilter();
			rolesFilter.statusEqual = KalturaUserRoleStatus.ACTIVE;
			rolesFilter.orderBy = KalturaUserRoleOrderBy.ID_ASC;
			// only get speacial, non-deleted features
			permissionsFilter = new KalturaPermissionFilter();
			permissionsFilter.typeIn = KalturaPermissionType.SPECIAL_FEATURE + ',' + KalturaPermissionType.PLUGIN;
			permissionsFilter.statusEqual = KalturaPermissionStatus.ACTIVE;
		}
		
		/**
		 * the active role entry.
		 * */
		public var selectedRole:KalturaUserRole;
		
		[ArrayElementType("KalturaUserRole")]
		/**
		 * list of all roles (KalturaRole objects) 
		 */
		public var roles:ArrayCollection;
		
		/**
		 * total number of rols as indicated by list result 
		 */		
		public var totalRoles:int;
		
		/**
		 * the filter used for listing roles. 
		 */		
		public var rolesFilter:KalturaUserRoleFilter;
		
		/**
		 * the filter used for listing partner permissions
		 * (only get speacial features). 
		 */		
		public var permissionsFilter:KalturaPermissionFilter;
		
		
		/**
		 * role drilldown mode, either <code>DrilldownMode.ADD</code>, 
		 * <code>DrilldownMode.EDIT</code> or  <code>DrilldownMode.NONE</code>.
		 * */
		public var drilldownMode:String = DrilldownMode.NONE;
		
		
		/**
		 * when duplications a role from the roles table, need to open a 
		 * drilldown window for it. since the only way to trigger ui actions
		 * is via binding, we'll use this propoerty.    
		 */		
		public var newRole:KalturaUserRole;
		
		
		/**
		 * all partner's permissions uiconf 
		 */
		public var partnerPermissionsUiconf:XML;
		
		/**
		 * a list of permissions ids from the KalturaPartner data 
		 */
		public var partnerPermissions:String;
	}
}