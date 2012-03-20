package com.kaltura.edw.components.fltr
{
	import flash.events.IEventDispatcher;

	/**
	 * dispatched when the value of the component have changed 
	 */	
	[Event(name="changed", type="flash.events.Event")]
	
	/**
	 * A part of the visual filter that manipulates data of a given KalturaFilter attribute 
	 * @author Atar
	 * 
	 */
	public interface IFilterComponent extends IEventDispatcher {
		
		/**
		 * Name of the <code>KalturaFilter</code> attribute this component handles  
		 */		
		function set attribute(value:String):void;
		function get attribute():String;
		
		
		/**
		 * Value for the relevant attribute on <code>KalturaFilter</code>.   
		 */		
		function set filter(value:Object):void;
		function get filter():Object;
		
		
	}
}