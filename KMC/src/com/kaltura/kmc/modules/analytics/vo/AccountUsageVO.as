package com.kaltura.kmc.modules.analytics.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	public class AccountUsageVO implements IValueObject
	{
		public var totalBWSoFar : Number = 0;
		public var totalPercentSoFar : Number = 0;
		public var hostingGB : Number = 0;
		public var packageBW : Number = 0;
		
		public var usageSeries:String = '';
		
		public function AccountUsageVO()
		{
		}
		
		

	}
}