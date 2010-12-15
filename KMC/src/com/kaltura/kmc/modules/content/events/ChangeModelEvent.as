package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ChangeModelEvent extends CairngormEvent {
		
		
		public static const SET_EMBED_STATUS:String = "content_setEmbedStatus";
		
		private var _newValue:*;
		
		public function ChangeModelEvent(type:String, value:*, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_newValue = value;
		}

		public function get newValue():Boolean
		{
			return _newValue;
		}

	}
}