package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class DrillDownEvent extends CairngormEvent
	{
		public static const DRILL_DOWN : String = "analytics_drillDown";
		public static const GET_MEDIA_ENTRY : String = "analytics_getMediaEntry";
		
		/**
		 * id of the drilldown subject (either user or entry) 
		 */
		public var subjectId : String;
		
		/**
		 * type of required screen, or 0 for default behaviour
		 * @see com.kaltura.kmc.modules.analytics.model.types.ScreenTypes
		 */
		public var newScreen : int;
		
		/**
		 * name (not id) of the object we drill to (i.e entry name, user name)
		 */
		public var objectName : String;
		
		public function DrillDownEvent(type:String, entryId : String, newScreen : int = 0, objectName : String = "" ,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.subjectId = entryId;
			this.newScreen = newScreen;
			this.objectName = objectName;
		}
	}
}