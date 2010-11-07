package com.kaltura.kmc.modules.account.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.events.Event;
	
	import mx.utils.ObjectProxy;
	
	[Bindable]
	public class ExternalSyndicationVO  extends ObjectProxy implements IValueObject 
	{
		public static const SELECTED_CHANGED_EVENT : String = "externalSyndicationSelectedChanged";
		
		private var _selected:Boolean = false;
		
		public var name:String = '';
		public var type:String = '';
		
		public var content:String = '';
		public var url:String = '';
		
		
		public function ExternalSyndicationVO(){}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(selected:Boolean):void
		{
			_selected = selected;
			dispatchEvent(new Event(SELECTED_CHANGED_EVENT));
		}
		
		

	}
}