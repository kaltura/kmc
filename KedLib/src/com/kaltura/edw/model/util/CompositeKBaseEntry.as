package com.kaltura.edw.model.util
{
	import com.kaltura.vo.KalturaBaseEntry;
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.PropertyChangeEvent;
	
	public class CompositeKBaseEntry extends KalturaBaseEntry
	{
		
		private var _entries:Vector.<KalturaBaseEntry>;
		
		public function CompositeKBaseEntry(entries:Vector.<KalturaBaseEntry>)
		{
			super();
			_entries = entries;
			
			addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onPropertyChanged);
		}
		
		protected function onPropertyChanged(event:PropertyChangeEvent):void
		{
			var propName:String = event.property as String;
			setBoundValue(propName, event.newValue);
		}
		
		private function setBoundValue(prop:String, value:Object):void{
			for each(var entry:KalturaBaseEntry in _entries){
				entry[prop] = value;
			}
		}
	}
}