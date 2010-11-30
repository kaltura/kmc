package com.kaltura.kmc.modules.admin.model
{
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRole;
	import com.kaltura.kmc.modules.admin.stubs.vo.KalturaRoleFilter;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class RolesModel {
		
		/**
		 * the active role entry.
		 * */
		public var selectedRole:KalturaRole;
		
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
		public var filter:KalturaRoleFilter;
		//TODO + filter only kmc-relevant roles
		
		/**
		 * role drilldown mode, either <code>DrilldownMode.ADD</code>, 
		 * <code>DrilldownMode.EDIT</code> or  <code>DrilldownMode.NONE</code>.
		 * */
		public var drilldownMode:String = DrilldownMode.NONE;
	}
}