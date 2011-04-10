package com.kaltura.kmc.business
{
	import com.kaltura.kmc.business.permissions.TestPermissionManager;
	import com.kaltura.kmc.business.permissions.TestPermissionParser;
	import com.kaltura.kmc.business.permissions.ExtendPermissionManager;
	import com.kaltura.kmc.business.permissions.TestPermissionManager;
	import com.kaltura.kmc.business.permissions.TestPermissionManagerNoInit;
	import com.kaltura.kmc.business.permissions.TestPermissionParser;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class PermissionsSuit
	{
		public var test1:com.kaltura.kmc.business.permissions.TestPermissionManager;
		public var test2:com.kaltura.kmc.business.permissions.TestPermissionParser;
		public var test3:com.kaltura.kmc.business.permissions.TestPermissionManagerNoInit;
		public var test4:com.kaltura.kmc.business.permissions.ExtendPermissionManager;
		
	}
}