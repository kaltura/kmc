package com.kaltura.edw.vo
{
	import mx.resources.ResourceManager;
	import flash.events.EventDispatcher;
	import mx.events.PropertyChangeEvent;
	import flash.events.Event;
	
	/**
	 * This vo tracks locale changes and updates its contents accordingly. 
	 */
	public class LocalizedVo extends EventDispatcher
	{
		/**
		 * item id  
		 */
		private var _value:String;
		
		/**
		 * item label, i.e to show in combobox 
		 */
		private var _label:String;
		
		/**
		 * key in locale file
		 */		
		private var _key:String;
		
		/**
		 * name of resource bundle that contains the key
		 */		
		private var _resourceBundleName:String;
		
		
		/**
		 * creates a new LocalizedVo
		 * @param value	item value
		 * @param key	key in resource bundle
		 * @param resourceBundleName	name of resource bundle containing the key
		 */
		public function LocalizedVo(value:String, key:String, resourceBundleName:String) {
			_value = value;
			_key = key;
			_resourceBundleName = resourceBundleName;
			_label = ResourceManager.getInstance().getString(resourceBundleName, key);
			ResourceManager.getInstance().addEventListener("change", resourcesChanged);
		}
		
		private function resourcesChanged(e:Event):void {
			var oldVal:String = _label;
			_label = ResourceManager.getInstance().getString(_resourceBundleName, _key);
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "label", oldVal, _label)); 
		}
		
		[Bindable(event="propertyChange")]
		public function get label():String
		{
			return _label;
		}

		public function get value():String
		{
			return _value;
		}
		
		override public function toString():String {
			return _label;
		}

	}
}