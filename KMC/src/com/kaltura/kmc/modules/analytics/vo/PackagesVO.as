package com.kaltura.kmc.modules.analytics.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	public class PackagesVO implements IValueObject
	{
		public var pId : String = "";
  		public var name : String = "";
  		public var cycleType : int;
  		public var cycleBw : String;
  		public var cycleFee : int;
  		public var cycleFeeAsString : String;
  		public var overageFee : String;
  		public var supportTypes : String;	
	}
}