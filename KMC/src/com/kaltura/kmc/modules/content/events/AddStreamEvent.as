package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.kmc.modules.content.vo.StreamVo;

	public class AddStreamEvent extends CairngormEvent
	{
		public static const ADD_STREAM:String = "addStream";
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