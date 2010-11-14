package flexUnitTests
{
	import flexUnitTests.business.TestKmcModuleLoader;
	import flexUnitTests.business.TestModuleLoaded;
	import flexUnitTests.business.TestPermissionParser;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestBusiness
	{
		public var test1:flexUnitTests.business.TestKmcModuleLoader;
		public var test2:flexUnitTests.business.TestModuleLoaded;
		public var test3:flexUnitTests.business.TestPermissionParser;
		
	}
}