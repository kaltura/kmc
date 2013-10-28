package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.StreamVo;

	public class AddStreamEvent extends CairngormEvent
	{
		/**
		 * create a new livestream entry according to the given stream vo. 
		 */
		public static const ADD_STREAM:String = "content_addStream";
		
		
		/**
		 * get a list of the existing live conversion profiles  
		 */
		public static const LIST_LIVE_PROFILES:String = "content_listLiveProfiles";
		
		
		private var _streamVo:StreamVo;
		
		public function AddStreamEvent(type:String , streamVo:StreamVo , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_streamVo = streamVo;
			super(type, bubbles, cancelable);
		}

		public function get streamVo():StreamVo
		{
			return _streamVo;
		}

	}
}