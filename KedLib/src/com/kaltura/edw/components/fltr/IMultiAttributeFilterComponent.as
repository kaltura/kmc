package com.kaltura.edw.components.fltr
{
	
	/**
	 * marker interface for panels that handle ranges (creation dates, etc) 
	 * @author atar.shadmi
	 * 
	 */
	public interface IMultiAttributeFilterComponent extends IFilterComponent {
		
		/**
		 * list of strings which are the attributes this component handles
		 */		
		function set attributes(value:Array):void;
		function get attributes():Array;
		
		/**
		 * list of matching values for the attributes
		 * @internal
		 * named kfilters instead of filters to avoid collision with UIComponent.filters
		 */		
		function set kfilters(value:Array):void;
		function get kfilters():Array;
		
		
	}
}