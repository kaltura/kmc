package com.kaltura.kmc.modules.admin.stubs.vo
{
	/**
	 * this is a stub for the client KalturaRole object
	 * */
	public class KalturaRole {
		
		/**
		 * Role ID number.
		 * */
		public var id:int = int.MIN_VALUE;
		
		/**
		 * Role name.
		 */		
		public var name:String;
		
		/**
		 * Role description.
		 */		
		public var description:String;	
			
		/**
		 * Creation date.
		 */			
		public var createdAt:int;	
			
		/**
		 * Last update date.
		 */
		public var updatedAt:int;	
			
		/**
		 * A list of permission IDs.
		 */
		public var permissions:String;	
			
		/**
		 * Partner that owns this role.
		 */
		public var partnerId:int;	
		
		/**
		 * Will be used for extensions.
		 */
		public var customData:String;	
			
		/**
		 * Active / deleted
		 */
		public var status:int = int.MIN_VALUE;	

	}
}