package com.kaltura.kmc.modules.analytics.control
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GraphEvent extends CairngormEvent
	{
		public static const CHANGE_DIM : String = "changeDim";
		public var newDim : String;
		public function GraphEvent(type:String, newDim : String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.newDim = newDim;
		}
	}
}