package com.kaltura.kmc.modules.analytics.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	public class AggregateDataVo implements IValueObject
	{
		public var title : String;
		public var value : String;
		public var helpToolTip : String;
	}
}