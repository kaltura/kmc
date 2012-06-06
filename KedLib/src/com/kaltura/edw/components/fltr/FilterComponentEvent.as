package com.kaltura.edw.components.fltr
{
	import com.kaltura.edw.components.fltr.indicators.IndicatorVo;
	
	import flash.events.Event;
	
	public class FilterComponentEvent extends Event {
		
		/**
		 * "remove" value for the "kind" property of a valueChange event 
		 */
		public static const EVENT_KIND_REMOVE:String = "remove";

		
		/**
		 * "removeAll" value for the "kind" property of a valueChange event 
		 */
		public static const EVENT_KIND_REMOVE_ALL:String = "removeAll";
		
		
		/**
		 * "add" value for the "kind" property of a valueChange event 
		 */
		public static const EVENT_KIND_ADD:String = "add"; 
		
		
		/**
		 * "update" value for the "kind" property of a valueChange event 
		 */
		public static const EVENT_KIND_UPDATE:String = "update"; 
		
		
		/**
		 * value for the "type" proerty of a valueChange event
		 */		
		public static const VALUE_CHANGE:String = "valueChange"; 
		
		
		/**
		 * Constructor 
		 */
		public function FilterComponentEvent(type:String, data:IndicatorVo, kind:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_data = data;
			_kind = kind;
		}
		
		
		
		private var _data:IndicatorVo;
		
		/**
		 * indicatorVo describing the filter 
		 * @return 
		 * 
		 */		
		public function get data():IndicatorVo {
			return _data;
		}
		
		private var _kind:String;
		
		/**
		 * event kind 
		 * @return 
		 * 
		 */		
		public function get kind():String {
			return _kind;
		}
		
		override public function clone():Event {
			return new FilterComponentEvent(type, _data, _kind, bubbles, cancelable);
		}
	}
}