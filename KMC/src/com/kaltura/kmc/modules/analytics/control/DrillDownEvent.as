package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class DrillDownEvent extends CairngormEvent
	{
		public static const DRILL_DOWN : String = "analytics_drillDown";
		public static const GET_MEDIA_ENTRY : String = "analytics_getMediaEntry";
		
		public var entryId : String;
		public var newScreen : int;
		public var objectName : String;
		
		public function DrillDownEvent(type:String, entryId : String, newScreen : int = 0, objectName : String = "" ,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.entryId = entryId;
			this.newScreen = newScreen;
			this.objectName = objectName;
		}
	}
}