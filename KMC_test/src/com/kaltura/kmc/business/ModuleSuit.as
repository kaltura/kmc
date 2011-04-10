package com.kaltura.kmc.business
{
	import com.kaltura.kmc.business.module.TestKmc;
	import com.kaltura.kmc.business.module.TestKmcModuleLoader;
	import com.kaltura.kmc.business.module.TestModuleLoaded;
	import com.kaltura.kmc.business.module.TestKmc;
	import com.kaltura.kmc.business.module.TestKmcModuleLoader;
	import com.kaltura.kmc.business.module.TestModuleLoaded;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ModuleSuit
	{
		public var test1:com.kaltura.kmc.business.module.TestKmc;
		public var test2:com.kaltura.kmc.business.module.TestKmcModuleLoader;
		public var test3:com.kaltura.kmc.business.module.TestModuleLoaded;
		
	}
}