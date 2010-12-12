package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class EmbedStatusEvent extends CairngormEvent {
		
		
		public static const SET_EMBED_STATUS:String = "content_setEmbedStatus";
		
		
		private var _embedStatus:Boolean;
		
		public function EmbedStatusEvent(type:String, status:Boolean, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_embedStatus = status;
		}

		public function get embedStatus():Boolean
		{
			return _embedStatus;
		}

	}
}