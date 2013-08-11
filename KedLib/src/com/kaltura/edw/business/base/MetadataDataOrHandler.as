package com.kaltura.edw.business.base
{
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.core.UIComponent;
	import mx.events.PropertyChangeEvent;

	public class MetadataDataOrHandler extends EventDispatcher
	{
		
		public var id:String;
		
		/**
		 * the component to manipulate 
		 */
		public var component:UIComponent;
		
		/**
		 * the attribute on the component to manipulate 
		 */
		public var att:String;
		
		/**
		 * list of changeWatchers to manage or-wise 
		 */
		private var _changeWatchers:Array;
		
		/**
		 * calculated boolean value 
		 */
		public var value:Boolean; 
		
		
		public function MetadataDataOrHandler()
		{
			_changeWatchers = new Array();
		}
		
		public function addWatcher(cw:ChangeWatcher):void {
			_changeWatchers.push(cw);
			changeFunction(cw.getValue());
		}
		
		/**
		 * calculate new value for <code>value</code> 
		 * @param newVal	new value for one of the watchers
		 */
		public function changeFunction(newVal:Boolean):void {
			var result:Boolean = false;
			for each (var cw:ChangeWatcher in _changeWatchers) {
				result ||= cw.getValue();
			}
			//if (value != result) { // don't uncomment this, it messes up the initial value of the bound component 
				value = result;
				if (component && att) {
					component[att] = result;
				}
			//}
		}
		
	}
}