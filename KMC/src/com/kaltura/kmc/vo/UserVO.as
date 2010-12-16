package com.kaltura.kmc.vo
{
	import com.kaltura.vo.KalturaUser;
	import com.kaltura.vo.KalturaUserRole;

	[Bindable]
	/**
	 * holds together data about a user and their role 
	 * @author Atar
	 */	
	public class UserVO {
		
		/**
		 * user details 
		 */
		public var user:KalturaUser;
		
		/**
		 * the role associated with <code>user</code> 
		 */		
		public var role:KalturaUserRole;
	}
}