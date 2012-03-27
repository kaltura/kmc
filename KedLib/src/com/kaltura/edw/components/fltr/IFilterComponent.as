package com.kaltura.edw.components.fltr
{
	import com.kaltura.edw.components.fltr.indicators.IndicatorVo;
	
	import flash.events.IEventDispatcher;

	
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
		
		
		/**
		 * remove partial filter. <br>
		 * the IFilterComponent implementation should know how to remove the indicated 
		 * item, because it created the indicatorVo in the first place  
		 * @param item	the item that specifies the partial filter to remove
		 */
		function removeItem(item:IndicatorVo):void;
		
	}
}