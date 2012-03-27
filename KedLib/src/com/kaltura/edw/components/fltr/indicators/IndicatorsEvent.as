package com.kaltura.edw.components.fltr.indicators {
	import flash.events.Event;

	public class IndicatorsEvent extends Event {

		
		/**
		 * defines the value for the type property of a boxClicked event 
		 */
		public static const BOX_CLICKED:String = "boxClicked"
		
		
		private var _data:IndicatorVo;

		public function get data():IndicatorVo {
			return _data;
		}





		public function IndicatorsEvent(type:String, data:IndicatorVo, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_data = data;
		}
	}
}
