package com.kaltura.edw.components.fltr.indicators
{
	import com.kaltura.edw.components.fltr.IFilterComponent;
	
	import mx.controls.Button;

	public class IndicatorVo {
		
		/**
		 * label to show on the box 
		 */
		public var label:String;
		
		/**
		 * box tooltip 
		 */
		public var tooltip:String;
		
		
		/**
		 * the field on the KalturaFilter this indicator refers to 
		 */
		public var attribute:String;
		
		
		/**
		 * a value that will allow the origin panel to identify
		 * the exact filter value, 
		 * i.e. for attribute mediaTypeIn, KalturaMediaType.VIDEO 
		 */		
		public var value:*;
		
		
	}
}